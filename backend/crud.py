# backend/crud.py

from sqlmodel import Session, select
from typing import List, Optional
from unidecode import unidecode
from datetime import datetime, date
from sqlalchemy import or_, and_
import uuid
from sqlalchemy.orm import selectinload
from sqlalchemy.sql import func
# Import SQLAlchemy ORM MODELS
from backend.models import Customer, Product, Invoice, InvoiceDetail, InvoiceStatus, User
# Import Pydantic SCHEMAS
from backend.schemas import (
    CustomerCreate, CustomerUpdate, CustomerRead,
    ProductCreate, ProductUpdate, ProductRead,
    InvoiceCreate,
    InvoiceUpdate,
    InvoicePay,
    InvoiceRead,
    UserCreate,
    UserRead,
    UserChangePassword
)
from backend import auth

def normalize_string_for_search(s: Optional[str]) -> Optional[str]:
    if s is None:
        return None
    return unidecode(s).lower().strip()
    
def generate_unique_invoice_code(session):
    """Sinh mã hóa đơn duy nhất (không trùng)"""
    for _ in range(10):
        new_code = generate_invoice_code(session)
        existing = session.exec(select(Invoice).where(Invoice.mahd == new_code)).first()
        if not existing:
            return new_code
    raise Exception("Không thể sinh mã hóa đơn duy nhất sau nhiều lần thử.")

def calculate_invoice_totals_only(details: List[dict]):
    """
    Tính toán tổng tiền hàng, tổng chiết khấu từ chi tiết hóa đơn mà không thay đổi đối tượng đầu vào.
    Trả về tổng tiền hàng và tổng chiết khấu.
    """
    total_goods_amount = 0.0
    total_discount_amount = 0.0
    for detail in details:
        item_original_price = detail["sl"] * detail["dongia"]
        item_discount_amount = item_original_price * (detail["ck"] / 100)
        total_goods_amount += item_original_price
        total_discount_amount += item_discount_amount
    return total_goods_amount, total_discount_amount

def generate_invoice_code(session: Session) -> str:
    """
    Generates a unique invoice code.
    Format: HD-YYYYMMDD-UUID_SHORT
    """
    while True:
        today_str = datetime.now().strftime("%Y%m%d")
        unique_part = str(uuid.uuid4()).split('-')[0].upper()
        new_code = f"HD-{today_str}-{unique_part}"

        existing_invoice = session.exec(select(Invoice).where(Invoice.mahd == new_code)).first()
        if not existing_invoice:
            return new_code

def update_customer_debt(db: Session, makh: int):
    customer = db.get(Customer, makh)
    if not customer:
        print(f"Không tìm thấy khách hàng với mã: {makh}")
        return

    active_invoices = db.exec(
        select(Invoice)
        .where(Invoice.makh == makh)
        .where(Invoice.trangthai != InvoiceStatus.CANCELLED)
    ).all()

    total_goods_amount_for_customer = 0.0
    total_discount_amount_for_customer = 0.0
    total_paid_by_customer = 0.0
    total_remaining_debt_for_customer = 0.0

    for inv in active_invoices:
        total_goods_amount_for_customer += inv.congtienhang
        total_discount_amount_for_customer += inv.congchietkhau
        total_paid_by_customer += inv.khhdathanhtoan

        # Calculate the current debt for *this* invoice.
        # This is where the change is needed: remove the if invoice_current_debt < 0: invoice_current_debt = 0 line.
        invoice_current_debt = (inv.congtienhang - inv.congchietkhau) - inv.khhdathanhtoan
        total_remaining_debt_for_customer += invoice_current_debt

    customer.tongtienhang = total_goods_amount_for_customer
    customer.tongchietkhau = total_discount_amount_for_customer
    
    customer.khhdathanhtoan = total_paid_by_customer
    customer.tongthanhtoan = total_paid_by_customer 

    customer.conno = total_remaining_debt_for_customer # This will now correctly store negative values

    db.add(customer)
    db.flush()


# --- CRUD for Users ---
def get_user_by_username(session: Session, username: str) -> User | None:
    """Lấy thông tin người dùng theo username."""
    return session.exec(select(User).where(User.username == username)).first()

# Loại bỏ get_user_by_email vì không dùng email nữa
# def get_user_by_email(session: Session, email: str) -> User | None:
#     """Lấy thông tin người dùng theo email."""
#     return session.exec(select(User).where(User.email == email)).first()

def create_user(session: Session, user_create: UserCreate, is_admin: bool = False) -> User: # <--- THÊM 'is_admin: bool = False' vào đây
    """Tạo người dùng mới với mật khẩu đã băm."""
    db_user = User(
        username=user_create.username,
        # Loại bỏ email=user_create.email,
        hashed_password=auth.get_password_hash(user_create.password),
        is_active=True,
        is_admin=is_admin # <--- THAY ĐỔI DÒNG NÀY để dùng giá trị từ tham số
    )
    session.add(db_user)
    session.commit()
    session.refresh(db_user)
    return db_user
def update_user_password(session: Session, user: User, new_password: str) -> User:
    """
    Cập nhật mật khẩu băm của người dùng và lưu vào database.
    """
    from backend.auth import get_password_hash
    # Hash mật khẩu mới
    hashed_new_password = get_password_hash(new_password)

    # Cập nhật trường hashed_password của đối tượng user
    user.hashed_password = hashed_new_password

    # Thêm user vào session và commit thay đổi
    session.add(user) # Đảm bảo đối tượng user đang được theo dõi bởi session
    session.commit()   # Lưu thay đổi vào database
    session.refresh(user) # Tải lại đối tượng user từ database để có dữ liệu mới nhất (đặc biệt nếu có updated_at)

    return user
# --- CRUD for Invoices ---
def get_invoice(session: Session, mahd: str) -> Invoice | None:
    """
    Tải hóa đơn cùng với chi tiết của nó, thông tin khách hàng và thông tin sản phẩm trong chi tiết.
    """
    invoice = session.exec(
        select(Invoice)
        .where(Invoice.mahd == mahd)
        .options(
            selectinload(Invoice.customer),
            selectinload(Invoice.details).selectinload(InvoiceDetail.product)
        )
    ).first()
    return invoice

def get_invoices(session: Session, skip: int = 0, limit: int = 100) -> list[Invoice]:
    """
    Tải danh sách hóa đơn cùng với chi tiết của chúng, thông tin khách hàng và thông tin sản phẩm trong chi tiết.
    """
    invoices = session.exec(
        select(Invoice)
        .offset(skip)
        .limit(limit)
        .options(
            selectinload(Invoice.customer),
            selectinload(Invoice.details).selectinload(InvoiceDetail.product)
        )
    ).all()
    return invoices

def get_invoice_detail(session: Session, detail_id: int) -> InvoiceDetail | None:
    return session.get(InvoiceDetail, detail_id)

def get_invoice_details_by_invoice(session: Session, mahd: str) -> list[InvoiceDetail]:
    return session.exec(select(InvoiceDetail).where(InvoiceDetail.mahd == mahd)).all()

def create_invoice_db(session: Session, db_invoice: Invoice) -> Invoice:
    """
    Thêm một đối tượng Invoice đã được chuẩn bị vào session.
    Hàm này không thực hiện commit, để caller (router) quản lý transaction.
    """
    session.add(db_invoice)
    return db_invoice

def update_invoice_db(session: Session, db_invoice: Invoice) -> Invoice:
    """
    Cập nhật một đối tượng Invoice đã được chỉnh sửa trong session.
    Hàm này không thực hiện commit, để caller (router) quản lý transaction.
    """
    session.add(db_invoice)
    return db_invoice


# --- CRUD for Customers ---
def get_customers(session: Session, skip: int = 0, limit: int = 100, search: Optional[str] = None) -> list[Customer]:
    query = select(Customer)

    if search:
        normalized_search = normalize_string_for_search(search)
        search_terms = search.lower().split()

        conditions = []
        for term in search_terms:
            normalized_term = normalize_string_for_search(term)
            
            conditions.append(
                or_(
                    Customer.tenkh.ilike(f"%{term}%"), 
                    Customer.tenkh_khongdau.ilike(f"%{normalized_term}%") 
                )
            )
        
        if conditions:
            query = query.where(and_(*conditions))

    customers = session.exec(query.offset(skip).limit(limit)).all()
    return customers

def get_customer(session: Session, makh: int):
    return session.get(Customer, makh)

def create_customer(session: Session, customer: CustomerCreate) -> Customer:
    db_customer = Customer.model_validate(customer)
    db_customer.tenkh_khongdau = normalize_string_for_search(customer.tenkh)

    session.add(db_customer)
    session.commit()
    session.refresh(db_customer)
    return db_customer

def update_customer(session: Session, makh: int, customer: CustomerUpdate) -> Customer | None:
    db_customer = session.get(Customer, makh)
    if db_customer:
        update_data = customer.model_dump(exclude_unset=True)
        for key, value in update_data.items():
            setattr(db_customer, key, value)
        
        if "tenkh" in update_data and update_data["tenkh"] is not None:
            db_customer.tenkh_khongdau = normalize_string_for_search(db_customer.tenkh)
            
        session.add(db_customer)
        session.commit()
        session.refresh(db_customer)
    return db_customer

# --- CRUD for Products ---
def get_product(session: Session, masp: int) -> Product | None:
    return session.get(Product, masp)

def get_products(session: Session, skip: int = 0, limit: int = 100, search_query: Optional[str] = None) -> list[Product]:
    query = select(Product)

    if search_query:
        normalized_search_query = normalize_string_for_search(search_query)

        search_terms = normalized_search_query.split()

        conditions_for_each_term = []
        for term in search_terms:
            conditions_for_each_term.append(
                or_(
                    Product.tensp.ilike(f"%{term}%"),
                    Product.tensp_khongdau.ilike(f"%{term}%")
                )
            )

        if conditions_for_each_term:
            query = query.where(and_(*conditions_for_each_term))

        query = query.order_by(
            (Product.tensp_khongdau.startswith(normalized_search_query)).desc(),
            (Product.tensp_khongdau.ilike(f"%{normalized_search_query}%")).desc(),
            func.length(Product.tensp_khongdau),
            Product.tensp_khongdau
        )

    products = session.exec(query.offset(skip).limit(limit)).all()
    return products

def create_product(*, session: Session, product: ProductCreate) -> Product:
    product_data = product.model_dump()
    product_data["tensp_khongdau"] = normalize_string_for_search(product.tensp)
    db_product = Product.model_validate(product_data)
    session.add(db_product)
    session.commit()
    session.refresh(db_product)
    return db_product

def update_product(session: Session, masp: int, product: ProductUpdate) -> Product | None:
    db_product = session.get(Product, masp)
    if db_product:
        update_data = product.model_dump(exclude_unset=True)
        for key, value in update_data.items():
            setattr(db_product, key, value)
        if "tensp" in update_data and update_data["tensp"] is not None:
            db_product.tensp_khongdau = normalize_string_for_search(db_product.tensp)
        session.add(db_product)
        session.commit()
        session.refresh(db_product)
    return db_product

def cancel_invoice(session: Session, mahd: str, cancel_user: str) -> Invoice | None:
    invoice = session.exec(select(Invoice).where(Invoice.mahd == mahd)).first()
    if not invoice:
        return None

    if invoice.trangthai == InvoiceStatus.CANCELLED:
        return invoice

    customer = session.get(Customer, invoice.makh)

    if customer:
        pass

    invoice.trangthai = InvoiceStatus.CANCELLED
    invoice.ngay_huy = datetime.now()
    invoice.nguoi_huy = cancel_user

    invoice.congtienhang = 0.0
    invoice.congchietkhau = 0.0
    invoice.khhdathanhtoan = 0.0
    invoice.conno = 0.0

    session.add(invoice)

    if customer:
        update_customer_debt(session, customer.makh)
    
    session.commit()
    session.refresh(invoice)

    return invoice

def update_user_password(session: Session, user: User, new_password: str) -> User:
    """
    Cập nhật mật khẩu băm của người dùng và lưu vào database.
    """
    from backend.auth import get_password_hash # This line is now CORRECT!
    # Hash mật khẩu mới
    hashed_new_password = get_password_hash(new_password) # This line is now CORRECT!

    # Cập nhật trường hashed_password của đối tượng user
    user.hashed_password = hashed_new_password

    # Thêm user vào session và commit thay đổi
    session.add(user) # Đảm bảo đối tượng user đang được theo dõi bởi session
    session.commit()   # Lưu thay đổi vào database
    session.refresh(user) # Tải lại đối tượng user từ database để có dữ liệu mới nhất (đặc biệt nếu có updated_at)

    return user