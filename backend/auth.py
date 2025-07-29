# backend/auth.py

from datetime import datetime, timedelta
from typing import Optional, Union
from jose import JWTError, jwt
from passlib.context import CryptContext
from fastapi import Depends, HTTPException, status, Request
from fastapi.security import OAuth2PasswordBearer
from sqlmodel import Session, select
from backend.database import get_session
from backend.models import User
from backend.schemas import TokenData
from fastapi.responses import RedirectResponse
from backend import models
from backend import schemas
from backend import crud
import logging # Import module logging

# Cấu hình logger
logging.basicConfig(level=logging.INFO) # Bạn có thể đổi INFO thành DEBUG để xem nhiều log hơn
logger = logging.getLogger(__name__)

# Cấu hình JWT
SECRET_KEY = "zFocmOk0dI615ALoEXMAIGXZw4KycsfVWuvi8Hi9Xkk"
ALGORITHM = "HS256"
ACCESS_TOKEN_EXPIRE_MINUTES = 60

pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")
oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token")

def verify_password(plain_password, hashed_password):
    return pwd_context.verify(plain_password, hashed_password)

def get_password_hash(password):
    return pwd_context.hash(password)

def create_access_token(data: dict, expires_delta: Optional[timedelta] = None):
    to_encode = data.copy()
    if expires_delta:
        expire = datetime.utcnow() + expires_delta
    else:
        expire = datetime.utcnow() + timedelta(minutes=15)
    to_encode.update({"exp": expire})
    encoded_jwt = jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)
    return encoded_jwt

async def get_current_user(
    session: Session = Depends(get_session), token: str = Depends(oauth2_scheme)
) -> User:
    credentials_exception = HTTPException(
        status_code=status.HTTP_401_UNAUTHORIZED,
        detail="Could not validate credentials",
        headers={"WWW-Authenticate": "Bearer"},
    )
    
    logger.info(f"Attempting to validate token in get_current_user: {token[:30]}...") # Log 30 ký tự đầu của token
    
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        username: str = payload.get("sub")
        
        logger.info(f"Token decoded successfully. Username: {username}")
        
        if username is None:
            logger.warning("Username 'sub' not found in token payload.")
            raise credentials_exception
        token_data = TokenData(username=username.lower())
    except JWTError as e:
        logger.error(f"JWT Error during token decode: {e}")
        raise credentials_exception
    except Exception as e:
        logger.error(f"Unexpected error during token decode: {e}")
        raise credentials_exception

    user = session.exec(select(User).where(User.username == token_data.username)).first()
    
    if user is None:
        logger.warning(f"User '{token_data.username}' not found in database.")
        raise credentials_exception
    
    if not user.is_active:
        logger.warning(f"User '{user.username}' is inactive.")
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail="Inactive user")
    
    logger.info(f"User '{user.username}' successfully authenticated.")
    return user

# Dependency MỚI cho các trang HTML
async def get_current_user_for_html_pages(request: Request, db: Session = Depends(get_session)):
    # Cố gắng lấy token từ session của server
    token = request.session.get('access_token')
    
    logger.info(f"Attempting to validate token for HTML pages. Token from session: {token[:30]}..." if token else "No token in session.")
    
    # Nếu không có token trong session, người dùng chưa đăng nhập cho HTML routes
    if not token:
        request.session['flash_message'] = "Vui lòng đăng nhập để truy cập trang này."
        request.session['flash_category'] = 'danger'
        return RedirectResponse(url="/login-page", status_code=status.HTTP_302_FOUND)

    # Thử giải mã token để lấy thông tin người dùng
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        username: str = payload.get("sub")
        
        logger.info(f"HTML token decoded. Username: {username}")
        
        if username is None:
            # Token không có username, coi như không hợp lệ
            logger.warning("Username 'sub' not found in HTML token payload.")
            raise JWTError # Chuyển đến khối except JWTError
        token_data = schemas.TokenData(username=username)
    except JWTError as e:
        logger.error(f"JWT Error during HTML token decode: {e}")
        # Nếu token không hợp lệ (hết hạn, sai chữ ký, lỗi giải mã)
        # Xóa token cũ khỏi session để buộc đăng nhập lại
        request.session.pop('access_token', None)
        request.session.pop('token_type', None)
        request.session.pop('username', None)
        request.session['flash_message'] = "Phiên đăng nhập đã hết hạn hoặc không hợp lệ. Vui lòng đăng nhập lại."
        request.session['flash_category'] = 'danger'
        return RedirectResponse(url="/login-page", status_code=status.HTTP_302_FOUND)
    except Exception as e:
        logger.error(f"Unexpected error during HTML token decode: {e}")
        request.session.pop('access_token', None)
        request.session.pop('token_type', None)
        request.session.pop('username', None)
        request.session['flash_message'] = "Lỗi xác thực. Vui lòng đăng nhập lại."
        request.session['flash_category'] = 'danger'
        return RedirectResponse(url="/login-page", status_code=status.HTTP_302_FOUND)
        
    user = crud.get_user_by_username(db, token_data.username)
    if user is None:
        # Nếu người dùng không tồn tại trong DB, xóa token và chuyển hướng
        logger.warning(f"User '{token_data.username}' not found in DB for HTML pages.")
        request.session.pop('access_token', None)
        request.session.pop('token_type', None)
        request.session.pop('username', None)
        request.session['flash_message'] = "Tài khoản không tồn tại. Vui lòng đăng nhập lại."
        request.session['flash_category'] = 'danger'
        return RedirectResponse(url="/login-page", status_code=status.HTTP_302_FOUND)
        
    logger.info(f"User '{user.username}' successfully authenticated for HTML pages.")
    return user

async def admin_required(request: Request, current_user: models.User = Depends(get_current_user_for_html_pages)):
    if isinstance(current_user, RedirectResponse): # Nếu get_current_user_for_html_pages đã chuyển hướng
        return current_user # Trả về RedirectResponse để FastAPI xử lý
    
    if not current_user.is_admin:
        request.session['flash_message'] = "Bạn không có quyền truy cập trang này."
        request.session['flash_category'] = 'danger'
        raise HTTPException(
            status_code=status.HTTP_302_FOUND, # 403 FORBIDDEN cho API, nhưng 302 cho HTML redirect
            detail="Forbidden",
            headers={"Location": "/"}, # Chuyển hướng về trang chủ
        )
    return current_user