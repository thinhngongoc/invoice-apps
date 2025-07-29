from sqlmodel import Field, SQLModel, Relationship
from typing import List, Optional
from datetime import date, datetime
from enum import Enum 

# Cập nhật mô hình User để có quan hệ ngược lại
class User(SQLModel, table=True):
    id: Optional[int] = Field(default=None, primary_key=True)
    username: str = Field(index=True, unique=True, min_length=3, max_length=50)
    hashed_password: str = Field(nullable=False)
    is_active: bool = Field(default=True)
    is_admin: bool = Field(default=False)

class Customer(SQLModel, table=True):
    makh: Optional[int] = Field(default=None, primary_key=True)
    tenkh: str = Field(index=True, max_length=100)
    diachi_sdt: Optional[str] = Field(default=None, max_length=200)
    ghichu: Optional[str] = None
    
    tongtienhang: float = Field(default=0.0)
    tongchietkhau: float = Field(default=0.0)
    tongthanhtoan: float = Field(default=0.0)
    khhdathanhtoan: float = Field(default=0.0)
    conno: float = Field(default=0.0)
    tenkh_khongdau: Optional[str] = Field(default=None, index=True, max_length=100)
    invoices: List["Invoice"] = Relationship(back_populates="customer")

class InvoiceStatus(str, Enum):
    PAID = "DaTT"        # Đã thanh toán
    UNPAID = "ChuaTT"    # Chưa thanh toán
    CANCELLED = "Huy"    # Đã hủy

# --- Product ORM Model ---
class Product(SQLModel, table=True):
    masp: Optional[int] = Field(default=None, primary_key=True)
    tensp: str
    tensp_khongdau: str = Field(index=True)
    donvi: Optional[str] = None
    dongia: float
    tonkho: Optional[float] = Field(default=0.0)
    ghichu: Optional[str] = None
    
    price_history: List["ProductPriceHistory"] = Relationship(back_populates="product")
    invoice_details: List["InvoiceDetail"] = Relationship(back_populates="product") 

    created_at: datetime = Field(default_factory=datetime.now, nullable=False)
    updated_at: datetime = Field(default_factory=datetime.now, sa_column_kwargs={"onupdate": datetime.now}, nullable=False)

# --- ProductPriceHistory Model ---
class ProductPriceHistory(SQLModel, table=True):
    id: Optional[int] = Field(default=None, primary_key=True)
    
    product_masp: int = Field(foreign_key="product.masp", index=True)
    product: Product = Relationship(back_populates="price_history")

    price: float = Field(ge=0)
    effective_date: datetime = Field(default_factory=datetime.now, nullable=False)
    recorded_at: datetime = Field(default_factory=datetime.now, nullable=False)

# --- Invoice Detail ORM Model ---
class InvoiceDetail(SQLModel, table=True):
    id: Optional[int] = Field(default=None, primary_key=True)

    mahd: str = Field(foreign_key="invoice.mahd", index=True) 
    masp: int = Field(foreign_key="product.masp", index=True) 

    donvi: Optional[str] = None
    sl: float # <--- ĐÃ SỬA TỪ 'int' SANG 'float' Ở ĐÂY
    dongia: float
    ck: float = 0.0
    thanhtien: float

    invoice: "Invoice" = Relationship(back_populates="details")
    product: "Product" = Relationship(back_populates="invoice_details") 

# --- Invoice ORM Model ---
class Invoice(SQLModel, table=True):
    mahd: str = Field(primary_key=True, index=True)
    makh: int = Field(foreign_key="customer.makh", index=True)
    ngaylap: date = Field(default_factory=date.today)
    khhdathanhtoan: float = 0.0
    nguoilap: Optional[str] = None
    ghichu: Optional[str] = None
    congtienhang: float = 0.0
    congchietkhau: float = 0.0
    conno: float = 0.0

    trangthai: InvoiceStatus = Field(default=InvoiceStatus.UNPAID)
    ngay_huy: Optional[datetime] = Field(default=None)
    nguoi_huy: Optional[str] = Field(default=None)

    created_at: datetime = Field(default_factory=datetime.now, nullable=False)
    updated_at: datetime = Field(default_factory=datetime.now, sa_column_kwargs={"onupdate": datetime.now}, nullable=False)

    customer: "Customer" = Relationship(back_populates="invoices")
    details: List["InvoiceDetail"] = Relationship(back_populates="invoice",
                                                   sa_relationship_kwargs={"cascade": "all, delete-orphan"})

Customer.model_rebuild()
Invoice.model_rebuild()
InvoiceDetail.model_rebuild()
Product.model_rebuild()