#!/bin/bash

# --- CẤU HÌNH DATABASE CỦA BẠN ---
DB_HOST="localhost"      # Host của PostgreSQL (thường là localhost nếu trên cùng máy)
DB_PORT="5432"           # Cổng của PostgreSQL (mặc định là 5432)
DB_USER="your_db_user"   # Tên người dùng database của bạn
DB_NAME="your_db_name"   # Tên database của bạn
# QUAN TRỌNG: KHÔNG NÊN ĐẶT MẬT KHẨU TRỰC TIẾP Ở ĐÂY NẾU SCRIPT NÀY SẼ ĐƯỢC CHIA SẺ HOẶC LƯU TRỮ KHÔNG AN TOÀN.
# Xem phần "Lưu ý về mật khẩu" bên dưới.
# PGPASSWORD="your_db_password" # Chỉ thêm dòng này nếu bạn không muốn đặt biến môi trường

# --- CẤU HÌNH SAO LƯU ---
BACKUP_DIR="/path/to/your/project/db_backups" # Thay bằng đường dẫn THỰC TẾ đến thư mục db_backups
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_FILE="${DB_NAME}_${TIMESTAMP}.sql" # Định dạng file .sql
# BACKUP_FILE="${DB_NAME}_${TIMESTAMP}.tar" # Hoặc định dạng .tar (custom format) nếu muốn restore linh hoạt hơn

# --- LOGIC SAO LƯU ---
echo "Bắt đầu sao lưu database ${DB_NAME}..."

# Tạo thư mục sao lưu nếu nó chưa tồn tại
mkdir -p "${BACKUP_DIR}"

# Thực hiện lệnh pg_dump
# Lựa chọn định dạng sao lưu:
# -F p (plain text SQL script) - dễ đọc, dễ khôi phục bằng psql < file.sql
# -F c (custom) hoặc -F t (tar) - định dạng nhị phân, nhỏ gọn hơn, khôi phục bằng pg_restore
export PGPASSWORD="your_db_password" # Đặt biến môi trường PGPASSWORD tại đây (hoặc trước khi chạy script)
pg_dump -h "${DB_HOST}" -p "${DB_PORT}" -U "${DB_USER}" -F p -v -f "${BACKUP_DIR}/${BACKUP_FILE}" "${DB_NAME}"
# Nếu muốn dùng định dạng custom/tar:
# pg_dump -h "${DB_HOST}" -p "${DB_PORT}" -U "${DB_USER}" -F t -v -f "${BACKUP_DIR}/${BACKUP_FILE}" "${DB_NAME}"

if [ $? -eq 0 ]; then
    echo "Sao lưu database thành công vào ${BACKUP_DIR}/${BACKUP_FILE}"
else
    echo "LỖI: Sao lưu database thất bại!"
fi

# --- Tùy chọn: Xóa các bản sao lưu cũ hơn X ngày ---
# Ví dụ: Giữ lại bản sao lưu của 7 ngày gần nhất
# find "${BACKUP_DIR}" -type f -name "*.sql" -mtime +7 -exec rm {} \;
# echo "Đã xóa các bản sao lưu cũ hơn 7 ngày."