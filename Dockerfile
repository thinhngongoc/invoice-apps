# Sử dụng image Python chính thức làm base image
FROM python:3.9-slim-buster

# Đặt biến môi trường để đảm bảo output của Python không bị buffered
ENV PYTHONUNBUFFERED 1

# Tạo thư mục làm việc trong container
WORKDIR /app

# Copy file requirements.txt vào thư mục làm việc
COPY requirements.txt .

# Cài đặt các thư viện Python
RUN pip install --no-cache-dir -r requirements.txt

# Copy toàn bộ mã nguồn ứng dụng vào thư mục làm việc
COPY . .

# Cài đặt các biến môi trường nếu cần thiết (ví dụ: PYTHONPATH)
# ENV PYTHONPATH=/app

# Expose port mà ứng dụng sẽ lắng nghe (Cloud Run sẽ mapping cổng này)
# Cloud Run sẽ cung cấp biến môi trường PORT. Mặc định 8080
EXPOSE 8080

# Lệnh khởi động ứng dụng bằng Uvicorn
# Sử dụng Gunicorn để quản lý Uvicorn workers cho production
CMD exec gunicorn main:app --bind 0.0.0.0:8080 --workers 4 --worker-class uvicorn.workers.UvicornWorker