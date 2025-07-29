from fastapi import APIRouter, Depends, HTTPException, status, Query, UploadFile, File, Form
from fastapi.responses import StreamingResponse
from sqlmodel import Session, select, func, or_, and_
from typing import List, Optional
from unidecode import unidecode
from backend import crud
from backend.database import get_session

# Đảm bảo import tất cả các models và schemas cần thiết
from backend.models import Product, ProductPriceHistory, Invoice, InvoiceDetail, Customer
from backend.schemas import ProductCreate, ProductUpdate, ProductRead, ProductPriceHistoryRead, SalesHistoryEntry
import pandas as pd
import io
import datetime
import uuid

from pydantic import BaseModel

class ProductListResponse(BaseModel):
    products: List[ProductRead]
    total_count: int

class ImportResult(BaseModel):
    message: str
    added_count: int
    updated_count: int
    errors: List[str] = []

router = APIRouter(prefix="/products", tags=["products"])

# ==============================================================================
# QUAN TRỌNG: ĐẶT CÁC ENDPOINT CỤ THỂ HƠN LÊN TRƯỚC CÁC ENDPOINT CHUNG HƠN
# ==============================================================================

# 1. Endpoint Export Excel (cụ thể hơn)
@router.get("/export_excel", status_code=status.HTTP_200_OK)
async def export_products_to_excel(
    search_query: Optional[str] = Query(None),
    db: Session = Depends(get_session)
):
    """
    Xuất danh sách sản phẩm ra file Excel.
    Có thể lọc sản phẩm theo search_query (nếu có).
    """
    query = select(Product)

    if search_query:
        normalized_search_query = crud.normalize_string_for_search(search_query)
        search_terms = normalized_search_query.split()
        
        conditions = []
        for term in search_terms:
            conditions.append(
                or_(
                    Product.tensp.ilike(f"%{term}%"),
                    Product.tensp_khongdau.ilike(f"%{term}%"),
                )
            )
        
        if conditions:
            query = query.where(and_(*conditions))

    products = db.exec(query).all()

    if not products:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Không tìm thấy sản phẩm nào để xuất."
        )

    products_data = []
    for product in products:
        products_data.append({
            # Sử dụng các tên cột thân thiện với người dùng và nhất quán cho import/export
            "Mã SP": product.masp, # Mã SP chỉ để hiển thị, không dùng khi import
            "Tên SP": product.tensp,
            "Đơn vị": product.donvi,
            "Đơn giá": product.dongia,
            "Tồn kho": product.tonkho, # Thêm Tồn kho
            "Ghi chú": product.ghichu,
            "Ngày tạo": product.created_at.strftime("%Y-%m-%d %H:%M:%S") if product.created_at else None, # Chỉ để hiển thị
            "Ngày cập nhật": product.updated_at.strftime("%Y-%m-%d %H:%M:%S") if product.updated_at else None, # Chỉ để hiển thị
            # "Tên SP Không dấu": product.tensp_khongdau, # Có thể bỏ cột này khi export nếu không cần thiết cho người dùng
        })

    df = pd.DataFrame(products_data)

    excel_buffer = io.BytesIO()
    df.to_excel(excel_buffer, index=False, engine='openpyxl')
    excel_buffer.seek(0)

    filename = f"danh_sach_san_pham_{datetime.datetime.now().strftime('%Y%m%d%H%M%S')}.xlsx"
    return StreamingResponse(
        excel_buffer,
        media_type="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
        headers={"Content-Disposition": f"attachment; filename={filename}"}
    )
# 2. Endpoint Import Excel (cụ thể hơn)
@router.post("/import_excel", response_model=ImportResult, status_code=status.HTTP_200_OK)
async def import_products_from_excel(
    file: UploadFile = File(...),
    db: Session = Depends(get_session)
):
    if not file.filename.endswith(('.xlsx', '.xls')):
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="File không hợp lệ. Vui lòng tải lên file .xlsx hoặc .xls."
        )

    added_count = 0
    updated_count = 0
    errors = []

    try:
        contents = await file.read()
        excel_file = io.BytesIO(contents)

        df = pd.read_excel(excel_file, engine='openpyxl')
        
        # CHUYỂN ĐỔI CÁC TÊN CỘT TRONG EXCEL THÀNH CÁC KEY CHUẨN ĐỂ XỬ LÝ
        # Đảm bảo các tên cột trong Excel khớp với các key ở đây
        df.columns = [col.strip() for col in df.columns] # Giữ nguyên case ban đầu từ Excel
        # TẠO MỘT MAPPER ĐỂ ÁNH XẠ CÁC TÊN CỘT THÂN THIỆN VỚI NGƯỜI DÙNG
        # SANG CÁC TÊN THUỘC TÍNH CỦA MODEL
        column_mapping = {
            "Tên SP": "tensp",
            "Đơn vị": "donvi",
            "Đơn giá": "dongia",
            "Tồn kho": "tonkho", # <--- THÊM CỘT TỒN KHO
            "Ghi chú": "ghichu",
            # "Mã SP": "masp", # Mã SP không dùng để import (do tự tăng hoặc tạo mới)
            # "Ngày tạo": "created_at",
            # "Ngày cập nhật": "updated_at",
        }

        # Đổi tên cột trong DataFrame dựa trên mapping, bỏ qua các cột không có trong mapping
        df.rename(columns=column_mapping, inplace=True)
        
        # Các cột bắt buộc để import
        required_columns = ['tensp', 'dongia']

        if not all(col in df.columns for col in required_columns):
            missing_cols_friendly = [
                k for k, v in column_mapping.items() if v in required_columns and v not in df.columns
            ]
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail=f"File Excel thiếu các cột bắt buộc: {', '.join(missing_cols_friendly)}. Vui lòng kiểm tra file mẫu."
            )
        
        existing_products_map = {}
        for p in db.exec(select(Product)).all():
            key = (p.tensp_khongdau, p.donvi)
            existing_products_map[key] = p


        for index, row in df.iterrows():
            row_num = index + 2 # Dòng trong Excel (bắt đầu từ 1, bỏ qua header)
            
            # Sử dụng .get() với tên cột đã được đổi tên
            tensp_excel = str(row.get('tensp', '')).strip() if pd.notna(row.get('tensp')) else None
            donvi_excel = str(row.get('donvi', '')).strip() if pd.notna(row.get('donvi')) else ""
            dongia_excel_raw = row.get('dongia')
            tonkho_excel_raw = row.get('tonkho') # <--- LẤY GIÁ TRỊ TỒN KHO
            ghichu_excel = str(row.get('ghichu', '')).strip() if pd.notna(row.get('ghichu')) else None

            try:
                if not tensp_excel:
                    errors.append(f"Dòng {row_num}: Tên sản phẩm không được để trống. Bỏ qua hàng này.")
                    continue
                
                # Xử lý đơn giá
                try:
                    dongia = float(dongia_excel_raw)
                    if dongia < 0:
                        errors.append(f"Dòng {row_num} (Tên: {tensp_excel}): Đơn giá không hợp lệ (phải >= 0).")
                        continue
                except (ValueError, TypeError):
                    errors.append(f"Dòng {row_num} (Tên: {tensp_excel}): Đơn giá '{dongia_excel_raw}' không phải là số hợp lệ.")
                    continue

                # Xử lý tồn kho (có thể là optional, nếu không có thì mặc định là 0 hoặc bỏ qua)
                tonkho = 0.0 # Giá trị mặc định
                if pd.notna(tonkho_excel_raw) and str(tonkho_excel_raw).strip() != '':
                    try:
                        tonkho = float(tonkho_excel_raw)
                        if tonkho < 0:
                            errors.append(f"Dòng {row_num} (Tên: {tensp_excel}): Tồn kho không hợp lệ (phải >= 0). Đặt về 0.")
                            tonkho = 0.0 # Hoặc bạn có thể 'continue' nếu muốn bỏ qua hàng
                    except (ValueError, TypeError):
                        errors.append(f"Dòng {row_num} (Tên: {tensp_excel}): Tồn kho '{tonkho_excel_raw}' không phải là số hợp lệ. Đặt về 0.")
                        tonkho = 0.0 # Hoặc bạn có thể 'continue' nếu muốn bỏ qua hàng
                
                tensp_khongdau = crud.normalize_string_for_search(tensp_excel)
                normalized_donvi = donvi_excel.lower()

                product_lookup_key = (tensp_khongdau, normalized_donvi)
                
                if product_lookup_key in existing_products_map:
                    db_product = existing_products_map[product_lookup_key]
                    
                    # Ghi lại lịch sử giá NẾU giá thay đổi khi import
                    if dongia != db_product.dongia:
                        old_price = db_product.dongia
                        new_price_history = ProductPriceHistory(
                            product_masp=db_product.masp,
                            price=old_price,
                            effective_date=datetime.datetime.now()
                        )
                        db.add(new_price_history)

                    # Cập nhật thông tin sản phẩm hiện có
                    db_product.tensp = tensp_excel
                    db_product.tensp_khongdau = tensp_khongdau
                    db_product.donvi = normalized_donvi
                    db_product.dongia = dongia
                    db_product.tonkho = tonkho # <--- CẬP NHẬT TỒN KHO
                    db_product.ghichu = ghichu_excel if ghichu_excel else None # Lưu None nếu rỗng
                    db_product.updated_at = datetime.datetime.now()
                    
                    db.add(db_product)
                    updated_count += 1
                else:
                    # Tạo sản phẩm mới
                    new_product = Product(
                        tensp=tensp_excel,
                        tensp_khongdau=tensp_khongdau,
                        donvi=normalized_donvi,
                        dongia=dongia,
                        tonkho=tonkho, # <--- GÁN TỒN KHO KHI TẠO MỚI
                        ghichu=ghichu_excel if ghichu_excel else None # Lưu None nếu rỗng
                    )
                    db.add(new_product)
                    added_count += 1
                    db.flush() # Để có masp cho new_price_history
                    
                    new_price_history = ProductPriceHistory(
                        product_masp=new_product.masp,
                        price=new_product.dongia,
                        effective_date=new_product.created_at
                    )
                    db.add(new_price_history)


            except Exception as e:
                errors.append(f"Dòng {row_num} (Tên: {tensp_excel or 'N/A'}, Đơn vị: {donvi_excel or 'N/A'}): Lỗi xử lý dữ liệu - {e}")

        db.commit()

        message = f"Đã import thành công {added_count} sản phẩm mới và cập nhật {updated_count} sản phẩm."
        if errors:
            message += f" Có {len(errors)} lỗi khi xử lý các dòng dữ liệu."
            
        return ImportResult(
            message=message,
            added_count=added_count,
            updated_count=updated_count,
            errors=errors
        )

    except pd.errors.EmptyDataError:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="File Excel trống hoặc không có dữ liệu."
        )
    except Exception as e:
        db.rollback()
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"Lỗi xử lý file Excel: {e}. Vui lòng đảm bảo file đúng định dạng và cấu trúc."
        )

# NEW ENDPOINT: Lấy lịch sử BÁN của một sản phẩm (Cụ thể hơn so với /{masp})
@router.get("/{masp}/sales_history", response_model=List[SalesHistoryEntry])
def get_product_sales_history(masp: int, db: Session = Depends(get_session)):
    """
    Lấy lịch sử bán ra của một sản phẩm cho các khách hàng khác nhau.
    Bao gồm mã hóa đơn, ngày lập, tên khách hàng, số lượng, đơn giá và chiết khấu.
    Giới hạn 5 lần bán gần đây nhất.
    """
    product = db.exec(select(Product).where(Product.masp == masp)).first()
    if not product:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Sản phẩm không tìm thấy.")

    # TRUY VẤN ĐÃ ĐƯỢC CHỈNH SỬA ĐỂ LẤY TẤT CẢ CÁC TRƯỜNG CẦN THIẾT VÀ GIỚI HẠN 5 KẾT QUẢ
    statement = select(
        Invoice.mahd,
        Invoice.ngaylap,
        Customer.tenkh,
        InvoiceDetail.sl,
        InvoiceDetail.dongia,
        InvoiceDetail.ck
    ).join(InvoiceDetail.invoice).join(Invoice.customer).where(InvoiceDetail.masp == masp).order_by(Invoice.ngaylap.desc()).limit(10) # Giới hạn 5 kết quả

    results = db.exec(statement).all()

    if not results:
        return []

    sales_history = []
    # Vòng lặp unpack đúng 6 giá trị
    for mahd_val, ngaylap_val, customer_name_val, sl_val, dongia_val, ck_val in results:
        sales_history.append(
            SalesHistoryEntry(
                mahd=mahd_val,
                ngaylap=ngaylap_val,
                customer_name=customer_name_val,
                quantity_sold=sl_val,
                unit_price_at_sale=dongia_val,
                discount_percentage=ck_val
            )
        )
    return sales_history

# 4. Endpoint GET /products/{masp} (Chung hơn)
@router.get("/{masp}", response_model=ProductRead)
def read_product_route(masp: int, db: Session = Depends(get_session)):
    """Đọc thông tin một sản phẩm cụ thể."""
    db_product = db.exec(select(Product).where(Product.masp == masp)).first()
    if db_product is None:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Product not found")
    return db_product

# 5. Endpoint PUT /products/{masp} (Chung hơn)
@router.put("/{masp}", response_model=ProductRead)
def update_product_route(masp: int, product_data: ProductUpdate, db: Session = Depends(get_session)):
    """Cập nhật thông tin sản phẩm."""
    db_product = db.exec(select(Product).where(Product.masp == masp)).first()
    if not db_product:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Product not found")
    
    # Ghi lại lịch sử giá NẾU giá thay đổi
    if product_data.dongia is not None and product_data.dongia != db_product.dongia:
        old_price = db_product.dongia
        new_price_history = ProductPriceHistory(
            product_masp=db_product.masp,
            price=old_price,
            effective_date=datetime.datetime.now()
        )
        db.add(new_price_history)

    update_data = product_data.model_dump(exclude_unset=True)
    for key, value in update_data.items():
        if key == "tensp": # Không cần kiểm tra value is not None ở đây, vì model_dump(exclude_unset=True) đã lọc rồi
            db_product.tensp = value
            db_product.tensp_khongdau = crud.normalize_string_for_search(value)
        elif key == "donvi": # Không cần kiểm tra value is not None ở đây
            db_product.donvi = value.strip().lower() if value is not None else None # Xử lý trường hợp donvi là None
        else:
            # Dành cho các trường khác như dongia, tonkho, ghichu
            # Dòng này sẽ gán cả chuỗi rỗng "" và None (nếu được gửi lên)
            # Nếu value là None (tức là bạn muốn set NULL vào DB), thì sẽ set NULL.
            # Nếu value là "" (chuỗi rỗng), thì sẽ set chuỗi rỗng.
            setattr(db_product, key, value) 
    
    db_product.updated_at = datetime.datetime.now()
    db.add(db_product)
    db.commit()
    db.refresh(db_product)
    return db_product

# 6. Endpoint DELETE /products/{masp} (Chung hơn)
@router.delete("/{masp}", status_code=status.HTTP_204_NO_CONTENT)
def delete_product_route(masp: int, db: Session = Depends(get_session)):
    """Xóa một sản phẩm theo masp."""
    # Tùy chọn: Xóa lịch sử giá liên quan khi xóa sản phẩm chính
    # db.exec(delete(ProductPriceHistory).where(ProductPriceHistory.product_masp == masp))
    success = crud.delete_product(session=db, masp=masp)
    if not success:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Product not found")
    return {"message": "Product deleted successfully"}

# 7. Endpoint POST /products/ (Chung nhất)
@router.post("/", response_model=ProductRead, status_code=status.HTTP_201_CREATED)
async def create_product(product: ProductCreate, db: Session = Depends(get_session)):
    tensp_khongdau_value = crud.normalize_string_for_search(product.tensp)
    normalized_donvi = product.donvi.strip().lower() if product.donvi else ""

    existing_product = db.query(Product).filter(
        Product.tensp_khongdau == tensp_khongdau_value,
        Product.donvi == normalized_donvi
    ).first()

    if existing_product:
        raise HTTPException(
            status_code=status.HTTP_409_CONFLICT,
            detail=f"Sản phẩm với tên '{product.tensp}' và đơn vị tính '{product.donvi}' đã tồn tại."
        )

    db_product = Product(
        tensp=product.tensp,
        tensp_khongdau=tensp_khongdau_value,
        donvi=normalized_donvi,
        dongia=product.dongia,
        tonkho=product.tonkho, 
        ghichu=product.ghichu
    )
    db.add(db_product)
    db.commit()
    db.refresh(db_product)
    
    # Ghi lại giá ban đầu khi tạo sản phẩm mới
    new_price_history = ProductPriceHistory(
        product_masp=db_product.masp,
        price=db_product.dongia,
        effective_date=db_product.created_at
    )
    db.add(new_price_history)
    db.commit()
    db.refresh(new_price_history)
    
    return db_product

# 8. Endpoint GET /products/ (Chung nhất)
@router.get("/", response_model=ProductListResponse)
def read_products_route_list(
    skip: int = 0,
    limit: int = Query(default=100, le=200),
    search_query: Optional[str] = Query(None),
    db: Session = Depends(get_session)
):
    query = select(Product)
    count_query = select(func.count()).select_from(Product)

    if search_query:
        normalized_search_query = crud.normalize_string_for_search(search_query)
        search_terms = normalized_search_query.split()
        
        conditions = []
        for term in search_terms:
            conditions.append(
                or_(
                    Product.tensp.ilike(f"%{term}%"),
                    Product.tensp_khongdau.ilike(f"%{term}%")
                )
            )
        
        if conditions:
            query = query.where(and_(*conditions))
            count_query = count_query.where(and_(*conditions))

    total_count = db.exec(count_query).one()

    products = db.exec(query.offset(skip).limit(limit)).all()

    return {"products": products, "total_count": total_count}
