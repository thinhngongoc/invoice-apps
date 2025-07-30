from fastapi import APIRouter, Depends, HTTPException, status, Query, Request
from sqlmodel import Session, select, func, delete
from typing import List, Optional
from datetime import date, datetime
from fastapi.responses import HTMLResponse, Response # <-- Đảm bảo 'Response' có ở đây

from io import BytesIO
import pandas as pd

from backend import crud
from backend.database import get_session
from backend.crud import generate_invoice_code
from sqlalchemy.orm import selectinload
from fastapi.templating import Jinja2Templates
from sqlalchemy import and_

# Import các Pydantic Schemas và Enum trạng thái hóa đơn
from backend.schemas import (
    InvoiceCreate,
    InvoicePay,
    InvoiceRead,
    InvoiceUpdate,
    InvoiceDetailCreate,
    PaginatedInvoicesResponse,
)
# Vẫn cần InvoiceStatus và các ORM models cho các câu lệnh select() và thao tác DB
from backend.models import InvoiceStatus, Invoice, InvoiceDetail, Customer, Product

router = APIRouter(prefix="/invoices", tags=["Invoices"])
templates = Jinja2Templates(directory="templates")

@router.get("/generate_code/", response_model=str, summary="Generate a new invoice code")
def get_new_invoice_code(db: Session = Depends(get_session)):
    """
    Returns a newly generated unique invoice code.
    """
    try:
        return crud.generate_unique_invoice_code(db) # Sử dụng generate_unique_invoice_code từ crud
    except Exception as e:
        raise HTTPException(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, detail=f"Error generating invoice code: {e}")


# --- SỬA ĐỔI: Endpoint để Tạo Hóa đơn Mới (POST /) ---
@router.post("/", response_model=InvoiceRead, status_code=status.HTTP_201_CREATED)
def create_invoice_route(invoice_data: InvoiceCreate, db: Session = Depends(get_session)):
    # Nếu người dùng truyền sẵn mã => kiểm tra trùng
    if invoice_data.mahd:
        cleaned_mahd = invoice_data.mahd.strip('"').strip('\\"')
        existing = db.exec(select(Invoice).where(Invoice.mahd == cleaned_mahd)).first()
        if existing:
            # Nếu mã bị trùng => sinh mã mới tự động
            cleaned_mahd = crud.generate_unique_invoice_code(db)
    else:
        # Nếu không truyền mã => sinh tự động
        cleaned_mahd = crud.generate_unique_invoice_code(db)
    
    try:
        total_goods_amount = 0.0
        total_discount_amount = 0.0

        invoice_details_for_db = []
        for detail_item_data in invoice_data.details:
            product = db.get(Product, detail_item_data.masp)
            if not product:
                raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail=f"Sản phẩm với mã {detail_item_data.masp} không tồn tại.")
            
            actual_dongia = detail_item_data.dongia
            actual_donvi = detail_item_data.donvi

            original_item_amount = detail_item_data.sl * actual_dongia
            item_discount_amount = original_item_amount * (detail_item_data.ck / 100)

            total_goods_amount += original_item_amount
            total_discount_amount += item_discount_amount

            thanhtien_calculated = original_item_amount - item_discount_amount

            db_detail = InvoiceDetail(
                mahd=cleaned_mahd,
                masp=detail_item_data.masp,
                donvi=actual_donvi,
                sl=detail_item_data.sl,
                dongia=actual_dongia,
                ck=detail_item_data.ck,
                thanhtien=thanhtien_calculated
            )
            invoice_details_for_db.append(db_detail)

            # NEW: Trừ tồn kho sản phẩm
            product.tonkho -= detail_item_data.sl
            db.add(product) # Đánh dấu sản phẩm để cập nhật

        final_total_amount = total_goods_amount - total_discount_amount
        remaining_debt = final_total_amount - invoice_data.khhdathanhtoan

        initial_status = InvoiceStatus.UNPAID
        # KHÔNG GÁN remaining_debt = 0 nếu nó âm ở đây nữa
        if remaining_debt <= 0:
            initial_status = InvoiceStatus.PAID
            # BỎ DÒNG SAU: remaining_debt = 0

        db_invoice_new = Invoice(
            mahd=cleaned_mahd,
            makh=invoice_data.makh,
            ngaylap=invoice_data.ngaylap,
            khhdathanhtoan=invoice_data.khhdathanhtoan,
            nguoilap=invoice_data.nguoilap,
            ghichu=invoice_data.ghichu,
            congtienhang=total_goods_amount,
            congchietkhau=total_discount_amount,
            conno=remaining_debt, # Giữ nguyên giá trị âm nếu có
            trangthai=initial_status,
            ngay_huy=None,
            nguoi_huy=None,
            created_at=datetime.now(), # Đảm bảo có created_at
            updated_at=datetime.now()  # Đảm bảo có updated_at
        )

        db_invoice_new.details.extend(invoice_details_for_db)

        db.add(db_invoice_new)
        db.flush() # Flush để db_invoice_new có thể được truy cập và các thay đổi tồn kho được ghi nhận

        # Cập nhật công nợ khách hàng
        crud.update_customer_debt(db, db_invoice_new.makh)

        created_invoice_with_relations = crud.get_invoice(db, mahd=db_invoice_new.mahd)
        if not created_invoice_with_relations:
            raise HTTPException(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, detail="Không thể lấy thông tin hóa đơn sau khi tạo.")

        db.commit() # Commit tất cả các thay đổi (hóa đơn, chi tiết, tồn kho, công nợ khách hàng)
        db.refresh(created_invoice_with_relations) # Refresh để đảm bảo dữ liệu trả về là mới nhất
        
        return created_invoice_with_relations

    except HTTPException:
        db.rollback() # Rollback nếu có HTTPException
        raise
    except Exception as e:
        db.rollback() # Rollback nếu có lỗi khác
        print(f"Lỗi khi tạo hóa đơn mới: {e}")
        raise HTTPException(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, detail=f"Đã xảy ra lỗi nội bộ khi tạo hóa đơn: {e}")


@router.get("/", response_model=PaginatedInvoicesResponse, summary="Read all invoices with pagination and filters")
def read_invoices_route(
    mahd: Optional[str] = Query(None, description="Lọc theo mã hóa đơn"),
    makh: Optional[int] = Query(None, description="Lọc theo mã khách hàng"),
    ngaylap_from: Optional[date] = Query(None, description="Ngày lập từ (YYYY-MM-DD)"),
    ngaylap_to: Optional[date] = Query(None, description="Ngày lập đến (YYYY-MM-DD)"),
    trangthai: Optional[List[InvoiceStatus]] = Query(None, description="Lọc theo trạng thái hóa đơn (ChuaTT, DaTT, Huy). Có thể chọn nhiều."),
    skip: int = 0,
    limit: int = 10,
    db: Session = Depends(get_session)
):
    """Đọc danh sách hóa đơn với tùy chọn lọc và phân trang."""
    
    # 1. Xây dựng truy vấn cơ bản (chỉ để tính tổng)
    count_query = select(func.count(Invoice.mahd))
    
    # 2. Xây dựng truy vấn chính để lấy dữ liệu (với eager loading)
    data_query = select(Invoice).options(
        selectinload(Invoice.customer), 
        selectinload(Invoice.details).selectinload(InvoiceDetail.product)
        ).order_by(Invoice.ngaylap.desc()
    )

    # 3. Áp dụng các bộ lọc cho cả hai truy vấn
    conditions = []
    if mahd:
        conditions.append(Invoice.mahd.contains(mahd))
    
    if makh:
        conditions.append(Invoice.makh == makh)
    
    if ngaylap_from:
        conditions.append(Invoice.ngaylap >= ngaylap_from)
    
    if ngaylap_to:
        conditions.append(Invoice.ngaylap <= ngaylap_to)

    # --- BỔ SUNG LOGIC LỌC THEO TRẠNG THÁI ---
    if trangthai:
        # FastAPI tự động chuyển các chuỗi query param thành List[InvoiceStatus]
        # (ví dụ: ['ChuaTT', 'DaTT'])
        # Sử dụng Invoice.trangthai.in_(trangthai) để lọc nhiều trạng thái
        conditions.append(Invoice.trangthai.in_(trangthai))
    # --- KẾT THÚC BỔ SUNG ---

    if conditions:
        count_query = count_query.where(and_(*conditions))
        data_query = data_query.where(and_(*conditions))

    total_count = db.exec(count_query).one() 
    
    data_query = data_query.offset(skip).limit(limit)

    invoices = db.exec(data_query).all()
    
    return PaginatedInvoicesResponse(total_count=total_count, invoices=invoices)
@router.get("/detail/{mahd}", response_model=InvoiceRead, summary="Read a single invoice by code")
def read_invoice_route(mahd: str, db: Session = Depends(get_session)):
    """Đọc thông tin một hóa đơn cụ thể."""
    clean_mahd_param = mahd.strip('"').strip('\\"')
    invoice = crud.get_invoice(db, mahd=clean_mahd_param)
    if not invoice:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Hóa đơn không tồn tại.")
    return invoice

@router.put("/detail/{mahd}", response_model=InvoiceRead, summary="Update an existing invoice")
def update_invoice_route(
    mahd: str, 
    invoice_data: InvoiceUpdate, 
    db: Session = Depends(get_session)
):
    try:
        db_invoice = db.exec(
            select(Invoice)
            .where(Invoice.mahd == mahd)
            .options(selectinload(Invoice.details)) 
        ).first()

        if not db_invoice:
            raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Hóa đơn không tồn tại.")

        # Hóa đơn đã hủy thì không được sửa
        if db_invoice.trangthai == InvoiceStatus.CANCELLED:
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST, 
                detail="Không thể sửa hóa đơn đã hủy. Vui lòng tạo hóa đơn mới nếu cần."
            )
        
        old_makh = db_invoice.makh
        
        # LƯU TRỮ CÁC CHI TIẾT CŨ ĐỂ HOÀN LẠI TỒN KHO
        old_invoice_details = list(db_invoice.details) # Tạo bản sao để không bị ảnh hưởng bởi clear()

        # Hoàn lại tồn kho cho các sản phẩm trong chi tiết hóa đơn cũ
        for old_detail in old_invoice_details:
            product = db.get(Product, old_detail.masp)
            if product:
                product.tonkho += old_detail.sl
                db.add(product) # Đánh dấu sản phẩm để cập nhật

        # Xóa các chi tiết hóa đơn cũ
        db.exec(delete(InvoiceDetail).where(InvoiceDetail.mahd == mahd))
        db_invoice.details.clear() # Đảm bảo làm sạch danh sách chi tiết
        db.flush() # Flush để các thay đổi xóa chi tiết cũ được ghi nhận trước khi thêm mới

        total_goods_amount = 0.0
        total_discount_amount = 0.0

        for detail_item_data in invoice_data.details:
            # Lấy product chỉ để kiểm tra xem sản phẩm có tồn tại không và cập nhật tồn kho
            product = db.get(Product, detail_item_data.masp) 
            if not product:
                raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail=f"Sản phẩm với mã {detail_item_data.masp} không tồn tại.")
            
            actual_dongia = detail_item_data.dongia 
            actual_donvi = detail_item_data.donvi 

            original_item_amount = detail_item_data.sl * actual_dongia
            item_discount_amount = original_item_amount * (detail_item_data.ck / 100)
            
            total_goods_amount += original_item_amount 
            total_discount_amount += item_discount_amount 
            
            thanhtien_calculated = original_item_amount - item_discount_amount
            
            db_detail = InvoiceDetail(
                mahd=db_invoice.mahd, 
                masp=detail_item_data.masp,
                donvi=actual_donvi, 
                sl=detail_item_data.sl,
                dongia=actual_dongia, 
                ck=detail_item_data.ck,
                thanhtien=thanhtien_calculated
            )
            db_invoice.details.append(db_detail) 

            # NEW: Trừ tồn kho sản phẩm cho số lượng mới
            product.tonkho -= detail_item_data.sl
            db.add(product) # Đánh dấu sản phẩm để cập nhật

        db_invoice.congtienhang = total_goods_amount
        db_invoice.congchietkhau = total_discount_amount
        db_invoice.khhdathanhtoan = invoice_data.khhdathanhtoan # Cập nhật số tiền đã thanh toán từ request
        
        # Cập nhật conno cho phép âm
        db_invoice.conno = (total_goods_amount - total_discount_amount) - db_invoice.khhdathanhtoan
        
        db_invoice.updated_at = datetime.now() # Cập nhật thời gian cập nhật
        db_invoice.ghichu = invoice_data.ghichu
        db_invoice.makh = invoice_data.makh
        db_invoice.ngaylap = invoice_data.ngaylap
        # Cập nhật trạng thái DỰA TRÊN conno MỚI
        if db_invoice.conno <= 0:
            db_invoice.trangthai = InvoiceStatus.PAID
        else:
            db_invoice.trangthai = InvoiceStatus.UNPAID


        db.add(db_invoice) 
        db.flush() # Flush để các thay đổi trên hóa đơn và tồn kho được ghi nhận trước khi cập nhật công nợ

        crud.update_customer_debt(db, db_invoice.makh) 
        if old_makh != db_invoice.makh: 
            crud.update_customer_debt(db, old_makh)
        
        updated_invoice_with_relations = crud.get_invoice(db, mahd=mahd)
        
        if not updated_invoice_with_relations:
            raise HTTPException(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, detail="Could not retrieve updated invoice with relations.")

        db.commit() # Commit tất cả các thay đổi
        db.refresh(updated_invoice_with_relations) # Refresh để đảm bảo dữ liệu trả về là mới nhất
        return updated_invoice_with_relations

    except HTTPException:
        db.rollback() # Rollback nếu có HTTPException
        raise
    except Exception as e:
        db.rollback() # Rollback nếu có lỗi khác
        print(f"Lỗi khi cập nhật hóa đơn: {e}")
        raise HTTPException(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, detail=f"Đã xảy ra lỗi nội bộ khi cập nhật hóa đơn: {e}")


@router.put("/{mahd}/pay", response_model=InvoiceRead, summary="Record a payment for an invoice")
def record_payment_route(mahd: str, payment_data: InvoicePay, db: Session = Depends(get_session)):
    clean_mahd_param = mahd.strip('"').strip('\\"') 
    invoice = crud.get_invoice(db, mahd=clean_mahd_param) 
    if not invoice:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Hóa đơn không tồn tại.")

    if invoice.trangthai == InvoiceStatus.CANCELLED:
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail="Không thể ghi nhận thanh toán cho hóa đơn đã hủy.")
    
    invoice.khhdathanhtoan += payment_data.amount

    # Cập nhật conno cho phép âm
    invoice.conno = invoice.congtienhang - invoice.congchietkhau - invoice.khhdathanhtoan
    
    # Trạng thái hóa đơn chỉ chuyển sang PAID nếu conno <= 0
    if invoice.conno <= 0:
        invoice.trangthai = InvoiceStatus.PAID
    else:
        invoice.trangthai = InvoiceStatus.UNPAID # Đảm bảo trạng thái đúng nếu trước đó là PAID nhưng giờ lại nợ

    invoice.updated_at = datetime.now() # Cập nhật thời gian cập nhật

    db.add(invoice) 

    crud.update_customer_debt(db, invoice.makh)
    
    updated_invoice_with_relations = crud.get_invoice(db, mahd=invoice.mahd)
    if not updated_invoice_with_relations:
        raise HTTPException(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, detail="Could not retrieve updated invoice with relations.")
    
    db.commit() # Commit các thay đổi
    db.refresh(updated_invoice_with_relations) # Refresh để đảm bảo dữ liệu trả về là mới nhất
    return updated_invoice_with_relations

# --- MỚI: Endpoint để Hủy hóa đơn (Sửa lại chỉ giữ 1 hàm) ---
@router.put("/{mahd}/cancel", response_model=InvoiceRead, summary="Cancel an invoice")
def cancel_invoice_route(
    mahd: str,
    cancel_user_data: dict, # Expects {"cancel_user": "..."}
    db: Session = Depends(get_session)
):
    """
    Hủy một hóa đơn.
    Khi hủy, các giá trị tiền tệ trên hóa đơn (congtienhang, congchietkhau, khhdathanhtoan, conno) được KHÔNG THAY ĐỔI
    chỉ trạng thái hóa đơn là CANCELLED.
    Công nợ tổng của khách hàng sẽ được tính toán lại, không bao gồm hóa đơn đã hủy này.
    """
    clean_mahd = mahd.strip('"').strip('\\"')
    invoice = db.exec(
        select(Invoice)
        .where(Invoice.mahd == clean_mahd)
        .options(selectinload(Invoice.customer), selectinload(Invoice.details)) # Load details để hoàn tồn kho
    ).first()

    if not invoice:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Hóa đơn không tồn tại.")

    if invoice.trangthai == InvoiceStatus.CANCELLED:
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail="Hóa đơn đã được hủy trước đó.")

    cancel_user = cancel_user_data.get("cancel_user", "System")
    old_customer_id = invoice.makh

    # NEW: Hoàn lại tồn kho cho các sản phẩm trong hóa đơn bị hủy
    for detail in invoice.details:
        product = db.get(Product, detail.masp) # Sử dụng db.get cho nhất quán
        if product:
            product.tonkho += detail.sl # Cộng lại số lượng vào tồn kho
            db.add(product) # Đánh dấu sản phẩm để cập nhật

    # Cập nhật trạng thái và thông tin hủy
    invoice.trangthai = InvoiceStatus.CANCELLED
    invoice.ngay_huy = datetime.now()
    invoice.nguoi_huy = cancel_user
    invoice.updated_at = datetime.now() # Cập nhật thời gian cập nhật


    db.add(invoice)
    db.flush() # Flush để các thay đổi trên hóa đơn và tồn kho được ghi nhận

    crud.update_customer_debt(db, old_customer_id)

    db.commit() # Commit tất cả các thay đổi
    db.refresh(invoice)
    if invoice.customer:
        db.refresh(invoice.customer)
    
    # Tải lại thông tin sản phẩm cho các chi tiết để trả về response đầy đủ (nếu cần)
    for detail in invoice.details:
        detail.product = db.get(Product, detail.masp)

    return invoice


@router.get("/print-preview/{mahd}", response_class=HTMLResponse, summary="Get print preview of an invoice")
async def get_invoice_print_preview(mahd: str, request: Request, db: Session = Depends(get_session)):
    invoice = db.exec(
        select(Invoice).where(Invoice.mahd == mahd).options(
            selectinload(Invoice.customer), 
            selectinload(Invoice.details).selectinload(InvoiceDetail.product) 
        )
    ).first()

    if not invoice:
        raise HTTPException(status_code=404, detail="Invoice not found")
    
    invoice_data = invoice.model_dump() 

    if invoice.customer:
        invoice_data['customer'] = invoice.customer.model_dump()
    else:
        invoice_data['customer'] = {} 

    invoice_details_list = []
    if invoice.details:
        for detail in invoice.details:
            detail_data = detail.model_dump()
            if detail.product:
                detail_data['product'] = detail.product.model_dump()
            else:
                detail_data['product'] = {} 
            invoice_details_list.append(detail_data)
    invoice_data['details'] = invoice_details_list
    
    invoice_data['ngaylap_formatted'] = invoice.ngaylap.strftime("%d/%m/%Y") if invoice.ngaylap else 'N/A'

    return templates.TemplateResponse(
        "invoice_print_template.html", 
        {"request": request, "invoice": invoice_data}
    )


@router.get("/export-excel", summary="Export invoices to Excel based on filters")
async def export_invoices_to_excel(
    mahd: Optional[str] = Query(None, description="Mã hóa đơn để lọc"),
    makh: Optional[int] = Query(None, description="Mã khách hàng để lọc"),
    ngaylap_from: Optional[date] = Query(None, description="Ngày lập từ (YYYY-MM-DD)"),
    ngaylap_to: Optional[date] = Query(None, description="Ngày lập đến (YYYY-MM-DD)"),
    trangthai: Optional[List[InvoiceStatus]] = Query(None, description="Lọc theo trạng thái hóa đơn (ChuaTT, DaTT, Huy). Có thể chọn nhiều."),
    db: Session = Depends(get_session)
):
    """
    Xuất danh sách hóa đơn ra file Excel dựa trên các bộ lọc đã chọn.
    """
    query = select(Invoice).options(
        selectinload(Invoice.customer), 
        selectinload(Invoice.details).selectinload(InvoiceDetail.product)
    ).order_by(Invoice.ngaylap.desc())

    conditions = []
    if mahd:
        conditions.append(Invoice.mahd.contains(mahd))
    if makh:
        conditions.append(Invoice.makh == makh)
    if ngaylap_from:
        conditions.append(Invoice.ngaylap >= ngaylap_from)
    if ngaylap_to:
        conditions.append(Invoice.ngaylap <= ngaylap_to)
    
    # --- BỔ SUNG LOGIC LỌC THEO TRẠNG THÁI (CHO EXCEL EXPORT CŨNG CẦN) ---
    if trangthai:
        conditions.append(Invoice.trangthai.in_(trangthai))
    # --- KẾT THÚC BỔ SUNG ---

    if conditions:
        query = query.where(and_(*conditions))

    invoices = db.exec(query).all()

    if not invoices:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Không tìm thấy hóa đơn nào phù hợp để xuất.")

    data_for_df = []
    for inv in invoices:
        customer_name = inv.customer.tenkh if inv.customer else 'N/A'
        
        invoice_row = {
            "Mã HD": inv.mahd,
            "Khách hàng": customer_name,
            "Ngày lập": inv.ngaylap.strftime("%Y-%m-%d") if inv.ngaylap else '',
            "Tổng Tiền hàng": inv.congtienhang,
            "Tổng CK": inv.congchietkhau,
            "Đã Thanh toán (HD)": inv.khhdathanhtoan,
            "Chưa thanh toán (HD)": inv.conno,
            "Trạng thái": inv.trangthai.value if inv.trangthai else '',
            "Người lập": inv.nguoilap,
            "Ghi chú": inv.ghichu,
            "Ngày tạo bản ghi": inv.created_at.strftime("%Y-%m-%d %H:%M:%S") if inv.created_at else '',
            "Cập nhật cuối": inv.updated_at.strftime("%Y-%m-%d %H:%M:%S") if inv.updated_at else '',
            "Ngày hủy": inv.ngay_huy.strftime("%Y-%m-%d") if inv.ngay_huy else '',
            "Người hủy": inv.nguoi_huy,
        }
        data_for_df.append(invoice_row)

        if inv.details:
            for i, detail in enumerate(inv.details):
                product_name = detail.product.tensp if detail.product else 'Sản phẩm không xác định'
                detail_row = {
                    "Mã HD": "",
                    "Khách hàng": "", 
                    "Ngày lập": "",
                    "Tổng Tiền hàng": "",
                    "Tổng CK": "",
                    "Đã Thanh toán (HD)": "",
                    "Chưa thanh toán (HD)": "",
                    "Trạng thái": "",
                    "Người lập": "",
                    "Ghi chú": "",
                    "Ngày tạo bản ghi": "",
                    "Ngày tạo bản ghi": "",
                    "Cập nhật cuối": "",
                    "Ngày hủy": "",
                    "Người hủy": "",
                    "Sản phẩm": f" -- {product_name}",
                    "ĐVT": detail.donvi,
                    "SL": detail.sl,
                    "Đơn giá": detail.dongia,
                    "CK (%)": detail.ck,
                    "Thành tiền (SP)": detail.thanhtien,
                }
                data_for_df.append(detail_row)

    df = pd.DataFrame(data_for_df)

    invoice_cols = [
        "Mã HD", "Khách hàng", "Ngày lập", "Tổng Tiền hàng", "Tổng CK", 
        "Đã Thanh toán (HD)", "Chưa thanh toán (HD)", "Trạng thái", 
        "Người lập", "Ghi chú", "Ngày tạo bản ghi", "Cập nhật cuối", 
        "Ngày hủy", "Người hủy", "Mã HD thay thế"
    ]
    detail_cols = [
        "Sản phẩm", "ĐVT", "SL", "Đơn giá", "CK (%)", "Thành tiền (SP)"
    ]
    ordered_cols = invoice_cols + detail_cols
    
    actual_cols_in_df = [col for col in ordered_cols if col in df.columns]
    df = df[actual_cols_in_df]

    output = BytesIO()
    with pd.ExcelWriter(output, engine='xlsxwriter') as writer:
        df.to_excel(writer, index=False, sheet_name='Danh_sach_Hoa_don')
        
        workbook = writer.book
        worksheet = writer.sheets['Danh_sach_Hoa_don']
        
        currency_format = workbook.add_format({'num_format': '#,##0'})
        date_format = workbook.add_format({'num_format': 'yyyy-mm-dd'})
        datetime_format = workbook.add_format({'num_format': 'yyyy-mm-dd hh:mm:ss'})

        for i, col in enumerate(df.columns):
            max_len = max(df[col].astype(str).map(len).max(), len(col)) + 2
            worksheet.set_column(i, i, max_len)
            
            if col in ["Tổng Tiền hàng", "Tổng CK", "Đã Thanh toán (HD)", "Chưa thanh toán (HD)", "Đơn giá", "Thành tiền (SP)"]:
                worksheet.set_column(i, i, max_len, currency_format)
            elif col in ["Ngày lập", "Ngày hủy"]:
                worksheet.set_column(i, i, max_len, date_format)
            elif col in ["Ngày tạo bản ghi", "Cập nhật cuối"]:
                worksheet.set_column(i, i, max_len, datetime_format)

    output.seek(0)

    headers = {
        "Content-Disposition": f"attachment; filename=danh_sach_hoa_don_{datetime.now().strftime('%Y%m%d_%H%M%S')}.xlsx",
        "Content-Type": "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    }
    return Response(content=output.read(), headers=headers)
