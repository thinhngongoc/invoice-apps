from fastapi import APIRouter, Depends, HTTPException, status, Query, UploadFile, File
from fastapi.responses import StreamingResponse
from sqlmodel import Session, select, func, or_, and_
from typing import List, Optional
from unidecode import unidecode
from backend.database import get_session
from backend.models import Customer, Invoice, InvoiceDetail, Product
from backend.schemas import CustomerCreate, CustomerRead, CustomerUpdate, PaginatedCustomersResponse
import pandas as pd
import io
import datetime

router = APIRouter(prefix="/customers", tags=["customers"])

# ==============================================================================
# HÀM TIỆN ÍCH
# ==============================================================================
def normalize_string_for_search(text: str) -> str:
    """Chuyển đổi chuỗi sang dạng không dấu, viết thường để tìm kiếm."""
    if not text:
        return ""
    return unidecode(text).lower().strip()

# ==============================================================================
# CÁC ENDPOINT API
# ==============================================================================

# 1. Endpoint Export Excel
@router.get("/export_excel", status_code=status.HTTP_200_OK)
async def export_customers_to_excel(
    search_query: Optional[str] = Query(None),
    db: Session = Depends(get_session)
):
    query = select(Customer)

    if search_query:
        normalized_search_query = normalize_string_for_search(search_query)
        search_terms = normalized_search_query.split()
        
        if search_terms:
            all_term_conditions = []
            for term in search_terms:
                term_match_condition = or_(
                    Customer.tenkh.ilike(f"%{term}%"),
                    Customer.tenkh_khongdau.ilike(f"%{term}%"),
                    Customer.diachi_sdt.ilike(f"%{term}%")
                )
                all_term_conditions.append(term_match_condition)
            
            if all_term_conditions: # Đảm bảo có điều kiện để áp dụng
                query = query.where(and_(*all_term_conditions))

    customers = db.exec(query).all()

    if not customers:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Không tìm thấy khách hàng nào để xuất."
        )

    customers_data = []
    for customer in customers:
        customers_data.append({
            "Mã KH": customer.makh,
            "Tên Khách hàng": customer.tenkh,
            "Tên KH Không dấu": customer.tenkh_khongdau,
            "Địa chỉ/SĐT": customer.diachi_sdt,
            "Ghi chú": customer.ghichu,
            "Tổng tiền hàng": customer.tongtienhang,
            "Tổng chiết khấu": customer.tongchietkhau,
            "Tổng thanh toán": customer.tongthanhtoan,
            "Khách đã thanh toán": customer.khdathanhtoan,
            "Còn nợ": customer.conno,
            "Ngày tạo": customer.created_at.strftime("%Y-%m-%d %H:%M:%S") if customer.created_at else None,
            "Ngày cập nhật": customer.updated_at.strftime("%Y-%m-%d %H:%M:%S") if customer.updated_at else None,
        })

    df = pd.DataFrame(customers_data)

    excel_buffer = io.BytesIO()
    df.to_excel(excel_buffer, index=False, engine='openpyxl')
    excel_buffer.seek(0)

    filename = f"danh_sach_khach_hang_{datetime.datetime.now().strftime('%Y%m%d%H%M%S')}.xlsx"
    return StreamingResponse(
        excel_buffer,
        media_type="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
        headers={"Content-Disposition": f"attachment; filename={filename}"}
    )

# 2. Endpoint Import Excel
@router.post("/import_excel", status_code=status.HTTP_200_OK)
async def import_customers_from_excel(
    file: UploadFile = File(...),
    db: Session = Depends(get_session)
):
    """
    Import danh sách khách hàng từ file Excel.
    """
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
        df.columns = [col.strip().lower() for col in df.columns]
        required_columns = ['tenkh']

        if not all(col in df.columns for col in required_columns):
            missing_cols = [col for col in required_columns if col not in df.columns]
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail=f"File Excel thiếu các cột bắt buộc: {', '.join(missing_cols)}. Vui lòng kiểm tra file mẫu."
            )
        
        # Lấy tất cả khách hàng hiện có để kiểm tra trùng lặp hiệu quả hơn
        existing_customers_map = {
            normalize_string_for_search(c.tenkh): c 
            for c in db.exec(select(Customer)).all()
        }

        for index, row in df.iterrows():
            row_num = index + 2 # Dòng trong excel bắt đầu từ 1, header là 1 dòng
            try:
                tenkh_excel = str(row.get('tenkh', '')).strip() if pd.notna(row.get('tenkh')) else None
                diachi_sdt_excel = str(row.get('diachi_sdt', '')).strip() if pd.notna(row.get('diachi_sdt')) else None
                ghichu_excel = str(row.get('ghichu', '')).strip() if pd.notna(row.get('ghichu')) else None

                if not tenkh_excel:
                    errors.append(f"Dòng {row_num}: Tên khách hàng không được để trống. Bỏ qua hàng này.")
                    continue

                normalized_tenkh = normalize_string_for_search(tenkh_excel)

                if normalized_tenkh in existing_customers_map:
                    db_customer = existing_customers_map[normalized_tenkh]
                    # Cập nhật thông tin khách hàng hiện có
                    db_customer.tenkh = tenkh_excel
                    db_customer.tenkh_khongdau = normalized_tenkh
                    db_customer.diachi_sdt = diachi_sdt_excel
                    db_customer.ghichu = ghichu_excel
                    #db_customer.updated_at = datetime.datetime.now()
                    db.add(db_customer)
                    updated_count += 1
                else:
                    # Thêm khách hàng mới
                    new_customer = Customer(
                        tenkh=tenkh_excel,
                        tenkh_khongdau=normalized_tenkh,
                        diachi_sdt=diachi_sdt_excel,
                        ghichu=ghichu_excel
                    )
                    db.add(new_customer)
                    added_count += 1
                    # Cập nhật map để các dòng sau có thể nhận diện khách hàng vừa thêm
                    db.flush() # Đảm bảo new_customer.makh được gán
                    existing_customers_map[normalized_tenkh] = new_customer

            except Exception as e:
                errors.append(f"Dòng {row_num} (Tên: {tenkh_excel or 'N/A'}): Lỗi xử lý dữ liệu - {e}")

        db.commit()

        message = f"Đã import thành công {added_count} khách hàng mới và cập nhật {updated_count} khách hàng."
        if errors:
            message += f" Có {len(errors)} lỗi khi xử lý các dòng dữ liệu."
            
        return {"message": message, "added_count": added_count, "updated_count": updated_count, "errors": errors}

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


# 3. Endpoint POST /customers/ (Tạo khách hàng mới)
@router.post("/", response_model=CustomerRead, status_code=status.HTTP_201_CREATED)
async def create_customer(customer: CustomerCreate, db: Session = Depends(get_session)):
    # Chuẩn hóa tên khách hàng để kiểm tra trùng lặp
    normalized_tenkh = normalize_string_for_search(customer.tenkh)

    # Kiểm tra xem tên khách hàng đã tồn tại chưa
    existing_customer = db.exec(
        select(Customer).where(Customer.tenkh_khongdau == normalized_tenkh)
    ).first()

    if existing_customer:
        raise HTTPException(
            status_code=status.HTTP_409_CONFLICT, # 409 Conflict
            detail=f"Khách hàng với tên '{customer.tenkh}' đã tồn tại."
        )

    db_customer = Customer(
        tenkh=customer.tenkh,
        tenkh_khongdau=normalized_tenkh,
        diachi_sdt=customer.diachi_sdt,
        ghichu=customer.ghichu
    )
    db.add(db_customer)
    db.commit()
    db.refresh(db_customer)
    return db_customer

# 4. Endpoint GET /customers/{makh} (Đọc thông tin khách hàng theo ID)
@router.get("/{makh}", response_model=CustomerRead)
def read_customer(makh: int, db: Session = Depends(get_session)):
    customer = db.exec(select(Customer).where(Customer.makh == makh)).first()
    if not customer:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Customer not found")
    return customer

# 5. Endpoint PUT /customers/{makh} (Cập nhật thông tin khách hàng)
@router.put("/{makh}", response_model=CustomerRead)
def update_customer(makh: int, customer_data: CustomerUpdate, db: Session = Depends(get_session)):
    db_customer = db.exec(select(Customer).where(Customer.makh == makh)).first()
    if not db_customer:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Customer not found")

    update_data = customer_data.model_dump(exclude_unset=True)
    for key, value in update_data.items():
        if key == "tenkh" and value is not None:
            normalized_new_tenkh = normalize_string_for_search(value)
            # Kiểm tra trùng lặp tên mới với các khách hàng khác (trừ chính nó)
            existing_customer_with_new_name = db.exec(
                select(Customer).where(
                    Customer.tenkh_khongdau == normalized_new_tenkh,
                    Customer.makh != makh
                )
            ).first()
            if existing_customer_with_new_name:
                raise HTTPException(
                    status_code=status.HTTP_409_CONFLICT,
                    detail=f"Tên khách hàng '{value}' đã tồn tại cho khách hàng khác."
                )
            db_customer.tenkh = value
            db_customer.tenkh_khongdau = normalized_new_tenkh
        elif value is not None:
            setattr(db_customer, key, value)
    
    #db_customer.updated_at = datetime.datetime.now()
    db.add(db_customer)
    db.commit()
    db.refresh(db_customer)
    return db_customer

# 6. Endpoint DELETE /customers/{makh} (Xóa khách hàng)
@router.delete("/{makh}", status_code=status.HTTP_204_NO_CONTENT)
def delete_customer(makh: int, db: Session = Depends(get_session)):
    customer = db.exec(select(Customer).where(Customer.makh == makh)).first()
    if not customer:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Customer not found")

    # Kiểm tra xem khách hàng có hóa đơn liên quan không
    invoices_exist = db.exec(select(Invoice).where(Invoice.makh == makh)).first()
    if invoices_exist:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Không thể xóa khách hàng này vì có hóa đơn liên quan."
        )

    db.delete(customer)
    db.commit()
    return {"message": "Customer deleted successfully"}

# 7. Endpoint GET /customers/ (Lấy danh sách khách hàng có phân trang và tìm kiếm)
@router.get("/", response_model=PaginatedCustomersResponse)
def read_customers(
    skip: int = 0,
    limit: int = Query(default=100, le=200),
    search: Optional[str] = Query(None), # <--- Tham số đầu vào là 'search'
    db: Session = Depends(get_session)
):
    query = select(Customer)
    count_query = select(func.count()).select_from(Customer)

    if search: # <--- Dùng 'search' ở đây (trước đây là 'search_query')
        normalized_search_query = normalize_string_for_search(search) # <--- Dùng 'search' ở đây (trước đây là 'search_query')
        # Tách chuỗi tìm kiếm thành các từ khóa
        search_terms = normalized_search_query.split()
        
        # Chỉ xử lý nếu có từ khóa sau khi chuẩn hóa
        if search_terms:
            # Danh sách các điều kiện cho TỪNG từ khóa
            all_term_conditions = []
            for term in search_terms:
                # Mỗi từ phải khớp với TÊN (có dấu/không dấu) HOẶC ĐỊA CHỈ/SĐT
                term_match_condition = or_(
                    Customer.tenkh.ilike(f"%{term}%"),             # Tên có dấu
                    Customer.tenkh_khongdau.ilike(f"%{term}%"),   # Tên không dấu
                    Customer.diachi_sdt.ilike(f"%{term}%")        # Địa chỉ/SĐT
                )
                all_term_conditions.append(term_match_condition)
            
            # Kết hợp TẤT CẢ các điều kiện của TỪNG từ khóa bằng toán tử AND
            # Điều này có nghĩa là một khách hàng phải chứa TẤT CẢ các từ trong chuỗi tìm kiếm của người dùng
            query = query.where(and_(*all_term_conditions))
            count_query = count_query.where(and_(*all_term_conditions))

    total_count = db.exec(count_query).one()
    customers = db.exec(query.offset(skip).limit(limit)).all()

    return {"customers": customers, "total_count": total_count}