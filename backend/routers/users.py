from fastapi import APIRouter, Depends, HTTPException, status
from fastapi.responses import RedirectResponse # Cần cho admin_required
from sqlmodel import Session
import logging

# Import các thành phần từ backend của bạn
from backend.database import get_session
from backend.models import User # Giả định User model của bạn không có trường email và không có quan hệ với PasswordResetToken
from backend.schemas import UserChangePassword, UserLogin, AdminResetPassword, Token # Import các schema cần thiết
from backend import crud, auth # Import crud functions và auth utilities
from backend.auth import (
    get_current_user,
    verify_password,
    create_access_token,
    ACCESS_TOKEN_EXPIRE_MINUTES,
    admin_required # Import admin_required
)
from datetime import timedelta

# Khởi tạo logger
logger = logging.getLogger(__name__)

router = APIRouter(prefix="/users", tags=["users"])

@router.put(
    "/admin-reset-password",
    response_model=dict,
    status_code=status.HTTP_200_OK,
    summary="Admin: Reset password for another user"
)
async def admin_reset_user_password(
    # THAY THẾ: Nhận toàn bộ dữ liệu từ body bằng schema mới
    password_reset_data: AdminResetPassword, # <--- SỬ DỤNG SCHEMA MỚI Ở ĐÂY
    current_admin_user: User = Depends(admin_required),
    db: Session = Depends(get_session)
):
    # Xử lý trường hợp admin_required có thể trả về RedirectResponse (ví dụ: nếu bạn dùng nó cho HTML pages)
    if isinstance(current_admin_user, RedirectResponse):
        raise HTTPException(
            status_code=current_admin_user.status_code,
            detail="Forbidden",
            headers={"Location": current_admin_user.headers.get("Location", "/")}
        )

    # 1. Kiểm tra mật khẩu mới và xác nhận có khớp không (tùy chọn nếu đã dùng field_validator)
    if password_reset_data.new_password != password_reset_data.confirm_new_password:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Mật khẩu mới và xác nhận mật khẩu mới không khớp."
        )

    # 2. Tìm người dùng mục tiêu
    # Truy cập target_username từ schema mới
    user_to_reset = crud.get_user_by_username(db, password_reset_data.target_username)
    if not user_to_reset:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Người dùng không tồn tại."
        )

    # 3. Optional: Kiểm tra mật khẩu mới có trùng với mật khẩu cũ của người dùng đích không
    if verify_password(password_reset_data.new_password, user_to_reset.hashed_password):
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Mật khẩu mới không được trùng với mật khẩu hiện tại của người dùng."
        )

    # 4. Cập nhật mật khẩu
    try:
        updated_user = crud.update_user_password(db, user_to_reset, password_reset_data.new_password)
        logger.info(f"Admin '{current_admin_user.username}' reset password for user '{updated_user.username}' successfully.")
        return {"message": f"Mật khẩu của người dùng '{updated_user.username}' đã được đặt lại thành công."}
    except Exception as e:
        logger.error(f"Error resetting password for user '{password_reset_data.target_username}' by admin '{current_admin_user.username}': {e}")
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Có lỗi xảy ra khi đặt lại mật khẩu. Vui lòng thử lại sau."
        )

# Endpoint để đăng nhập và lấy token JWT
@router.post("/token", response_model=Token, summary="Login and get JWT token")
async def login_for_access_token(
    form_data: UserLogin,
    session: Session = Depends(get_session)
):
    user = auth.authenticate_user(session, form_data.username, form_data.password)
    if not user:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Tên đăng nhập hoặc mật khẩu không đúng",
            headers={"WWW-Authenticate": "Bearer"},
        )
    access_token_expires = timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES)
    access_token = create_access_token(
        data={"sub": user.username}, expires_delta=access_token_expires
    )
    return {"access_token": access_token, "token_type": "bearer"}

# Endpoint để đổi mật khẩu của chính người dùng
@router.put("/change-password", response_model=dict, status_code=status.HTTP_200_OK, summary="Change user password")
async def change_password_api(
    password_data: UserChangePassword,
    current_user: User = Depends(get_current_user), # Xác thực người dùng hiện tại
    session: Session = Depends(get_session)
):
    """
    Cho phép người dùng đã đăng nhập đổi mật khẩu của họ.
    Yêu cầu mật khẩu cũ để xác thực.
    """
    # 1. Xác minh mật khẩu cũ
    if not verify_password(password_data.old_password, current_user.hashed_password):
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Mật khẩu cũ không đúng."
        )

    # 2. Kiểm tra mật khẩu mới có giống mật khẩu cũ không (tùy chọn nhưng nên có)
    # Lưu ý: password_data.new_password và password_data.confirm_new_password
    # được giả định là giống nhau ở client side hoặc đã được kiểm tra trong Pydantic schema
    if verify_password(password_data.new_password, current_user.hashed_password):
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Mật khẩu mới không được trùng với mật khẩu cũ."
        )
    
    # 3. Kiểm tra mật khẩu mới và xác nhận có khớp không (nếu schema có cả hai)
    if password_data.new_password != password_data.confirm_new_password:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Mật khẩu mới và xác nhận mật khẩu mới không khớp."
        )

    try:
        updated_user = crud.update_user_password(session, current_user, password_data.new_password)
        logger.info(f"User '{updated_user.username}' changed password successfully.")
        return {"message": "Mật khẩu đã được thay đổi thành công."}
    except Exception as e:
        logger.error(f"Error changing password for user '{current_user.username}': {e}")
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"Có lỗi xảy ra khi đổi mật khẩu: {e}"
        )

# Endpoint chỉ dành cho ADMIN để ĐẶT LẠI MẬT KHẨU CỦA NGƯỜI KHÁC
@router.put(
    "/admin-reset-password",
    response_model=dict,
    status_code=status.HTTP_200_OK,
    summary="Admin: Reset password for another user"
)
async def admin_reset_user_password(
    target_username: str, # Tên người dùng cần đặt lại mật khẩu
    new_password_data: UserChangePassword, # Sử dụng lại schema UserChangePassword
    current_admin_user: User = Depends(admin_required), # Chỉ admin mới có thể truy cập
    db: Session = Depends(get_session)
):
    # Xử lý trường hợp admin_required có thể trả về RedirectResponse (ví dụ: nếu bạn dùng nó cho HTML pages)
    if isinstance(current_admin_user, RedirectResponse):
        raise HTTPException(
            status_code=current_admin_user.status_code,
            detail="Forbidden",
            headers={"Location": current_admin_user.headers.get("Location", "/")}
        )

    # 1. Tìm người dùng mục tiêu
    user_to_reset = crud.get_user_by_username(db, target_username)
    if not user_to_reset:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Người dùng không tồn tại."
        )

    # 2. Xác thực mật khẩu mới
    # UserChangePassword schema có old_password, nhưng ở đây không cần dùng.
    # Chỉ cần kiểm tra new_password và confirm_new_password
    if new_password_data.new_password != new_password_data.confirm_new_password:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Mật khẩu mới và xác nhận mật khẩu mới không khớp."
        )

    # Optional: Kiểm tra mật khẩu mới có trùng với mật khẩu cũ không
    # (Sử dụng verify_password thay vì so sánh hashed_password trực tiếp)
    if verify_password(new_password_data.new_password, user_to_reset.hashed_password):
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Mật khẩu mới không được trùng với mật khẩu cũ."
        )

    # 3. Cập nhật mật khẩu
    try:
        updated_user = crud.update_user_password(db, user_to_reset, new_password_data.new_password)
        logger.info(f"Admin '{current_admin_user.username}' reset password for user '{updated_user.username}' successfully.")
        return {"message": f"Mật khẩu của người dùng '{updated_user.username}' đã được đặt lại thành công."}
    except Exception as e:
        logger.error(f"Error resetting password for user '{target_username}' by admin '{current_admin_user.username}': {e}")
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Có lỗi xảy ra khi đặt lại mật khẩu. Vui lòng thử lại sau."
        )

# Có thể thêm các endpoint khác nếu cần, ví dụ:
# Endpoint để lấy thông tin người dùng hiện tại
@router.get("/me", response_model=User, summary="Get current user information")
async def read_users_me(current_user: User = Depends(get_current_user)):
    return current_user