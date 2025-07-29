from pydantic import BaseModel, Field, EmailStr, ValidationError, model_validator
from typing import Optional, List
from datetime import datetime, date

# Đảm bảo import đúng Enum InvoiceStatus đã được cập nhật
# Ví dụ: from backend.models import InvoiceStatus
# Tôi sẽ giả định rằng backend.models đã có InvoiceStatus mới
from backend.models import InvoiceStatus 

class AdminResetPassword(BaseModel):
    target_username: str = Field(..., min_length=3, max_length=50, description="Tên đăng nhập của người dùng cần đặt lại mật khẩu")
    new_password: str = Field(..., min_length=6, max_length=50, description="Mật khẩu mới cho người dùng")
    confirm_new_password: str = Field(..., min_length=6, max_length=50, description="Xác nhận mật khẩu mới")
    
    @model_validator(mode='after')
    def check_passwords_match(self) -> 'AdminResetPassword':
        if self.new_password != self.confirm_new_password:
            raise ValueError("Mật khẩu mới và xác nhận mật khẩu mới không khớp.")
        return self

class UserChangePassword(BaseModel):
    old_password: str = Field(min_length=6, max_length=50)
    new_password: str = Field(min_length=6, max_length=50)
    confirm_new_password: str = Field(min_length=6, max_length=50)
    
    @model_validator(mode='after')
    def check_passwords_match(self) -> 'UserChangePassword':
        if self.new_password != self.confirm_new_password:
            raise ValueError("Mật khẩu mới và xác nhận mật khẩu mới không khớp.")
        return self

class UserBase(BaseModel):
    username: str = Field(..., min_length=3, max_length=50)

class UserCreate(UserBase):
    password: str = Field(..., min_length=6)

class UserRead(UserBase):
    id: int
    is_active: bool
    is_admin: bool    

    class Config:
        from_attributes = True

class UserLogin(BaseModel):
    username: str
    password: str

class Token(BaseModel):
    access_token: str
    token_type: str

class TokenData(BaseModel):
    username: Optional[str] = None

# --- Customer Schemas ---
class CustomerBase(BaseModel):
    tenkh: str = Field(..., max_length=100)
    diachi_sdt: Optional[str] = Field(None, max_length=200)
    ghichu: Optional[str] = None

class CustomerCreate(CustomerBase):
    pass

class CustomerUpdate(BaseModel):
    tenkh: Optional[str] = Field(None, max_length=100)
    diachi_sdt: Optional[str] = Field(None, max_length=200)
    ghichu: Optional[str] = None

class CustomerRead(CustomerBase):
    makh: int
    tongtienhang: float
    tongchietkhau: float
    tongthanhtoan: float
    khhdathanhtoan: float
    conno: float

    class Config:
        from_attributes = True

class PaginatedCustomersResponse(BaseModel):
    total_count: int
    customers: List[CustomerRead]

# --- Product Schemas ---
class ProductBase(BaseModel):
    tensp: str = Field(..., max_length=100)
    donvi: Optional[str] = Field(None, max_length=20)
    dongia: float = Field(..., ge=0)
    tonkho: float = Field(default=0.0)
    ghichu: Optional[str] = None

class ProductCreate(ProductBase):
    pass

class ProductUpdate(BaseModel):
    tensp: Optional[str] = Field(None, max_length=100)
    donvi: Optional[str] = Field(None, max_length=20)
    dongia: Optional[float] = Field(None, ge=0)
    tonkho: float = Field(default=0.0)
    ghichu: Optional[str] = None

class ProductRead(ProductBase):
    masp: int
    tensp_khongdau: str
    created_at: datetime
    updated_at: datetime
    class Config:
        from_attributes = True

# --- Invoice Detail Schemas ---
class InvoiceDetailCreate(BaseModel):
    masp: int
    donvi: Optional[str] = Field(None, max_length=20)
    sl: float = Field(..., gt=-float('inf')) 
    dongia: float = Field(..., ge=0)
    ck: float = Field(0, ge=0, le=100)

class InvoiceDetailRead(BaseModel):
    id: int
    mahd: str
    masp: int
    donvi: Optional[str] = None
    sl: float 
    dongia: float
    ck: float
    thanhtien: float
    product: Optional[ProductRead] = None
    class Config:
        from_attributes = True

# --- Invoice Schemas ---
class InvoiceBase(BaseModel):
    makh: int
    ngaylap: date = Field(default_factory=date.today)
    khhdathanhtoan: float = Field(0, ge=0)
    
    # === ĐÃ CẬP NHẬT GIÁ TRỊ MẶC ĐỊNH CHO TRẠNG THÁI ===
    trangthai: InvoiceStatus = InvoiceStatus.UNPAID 
    
    nguoilap: Optional[str] = None
    ghichu: Optional[str] = None

class InvoiceCreate(InvoiceBase):
    mahd: Optional[str] = None
    details: List[InvoiceDetailCreate]

class InvoiceUpdate(BaseModel):
    makh: Optional[int] = None
    ngaylap: Optional[date] = None
    khhdathanhtoan: Optional[float] = Field(None, ge=0) 
    
    # === ĐÃ CẬP NHẬT KIỂU DỮ LIỆU CHO TRẠNG THÁI ===
    trangthai: Optional[InvoiceStatus] = None 
    
    nguoilap: Optional[str] = None
    ghichu: Optional[str] = None
    details: Optional[List[InvoiceDetailCreate]] = None 

class InvoiceRead(InvoiceBase):
    mahd: str
    congtienhang: float
    congchietkhau: float
    conno: float
    customer: Optional[CustomerRead] = None
    details: List[InvoiceDetailRead] = []
    
    ngay_huy: Optional[datetime] = None
    nguoi_huy: Optional[str] = None
    created_at: datetime
    updated_at: datetime
    class Config:
        from_attributes = True

class InvoicePay(BaseModel):
    amount: float = Field(..., gt=0)
    ngay_thanh_toan: date = Field(default_factory=date.today)

class PaginatedInvoicesResponse(BaseModel):
    total_count: int
    invoices: List[InvoiceRead]

class ProductPriceHistoryRead(BaseModel):
    id: int
    product_masp: int
    price: float
    effective_date: datetime
    recorded_at: datetime

class SalesHistoryEntry(BaseModel):
    mahd: str
    ngaylap: date
    customer_name: str
    quantity_sold: float = Field(alias="sl") 
    unit_price_at_sale: float = Field(alias="dongia") 
    discount_percentage: float = Field(alias="ck")

    class Config:
        from_attributes = True
        populate_by_name = True