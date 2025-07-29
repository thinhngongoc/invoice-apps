# backend/database.py

from sqlmodel import create_engine, Session, SQLModel
from typing import Generator
import os

# --- THÊM DÒNG IMPORT TẤT CẢ CÁC MODEL CỦA BẠN TẠI ĐÂY ---
# Đảm bảo bạn import TẤT CẢ các class model mà bạn muốn SQLModel tạo bảng cho.
from backend.models import (
    User,
    Customer,
    Product,
    Invoice,
    InvoiceDetail,
    ProductPriceHistory # Thêm bất kỳ model nào khác bạn có vào đây
)

DATABASE_URL = os.getenv("DATABASE_URL", "postgresql://admin:210219@localhost:5432/invoices")

# Tạo engine cho PostgreSQL
# echo=True sẽ in ra các câu lệnh SQL được thực thi (hữu ích cho debug)
engine = create_engine(DATABASE_URL, echo=True)

def create_db_and_tables():
    """Tạo tất cả các bảng trong cơ sở dữ liệu dựa trên các mô hình SQLModel."""
    print("Attempting to create database tables...") # Thêm thông báo rõ hơn
    SQLModel.metadata.create_all(engine)
    print("Database tables created or already exist.")

def get_session() -> Generator[Session, None, None]:
    """Dependency để lấy một phiên làm việc (session) với cơ sở dữ liệu."""
    with Session(engine) as session:
        yield session