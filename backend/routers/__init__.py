# backend/routers/__init__.py

# Import các router con để chúng được đăng ký với ứng dụng FastAPI
# và dễ dàng import từ main.py
from .customers import router as customers_router
from .products import router as products_router
from .invoices import router as invoices_router

# Nếu muốn, bạn có thể expose chúng ra ngoài package
__all__ = ["customers_router", "products_router", "invoices_router"]