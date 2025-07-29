@echo off
REM Di chuyển đến thư mục gốc của project FastAPI của bạn
REM ĐẢM BẢO ĐƯỜNG DẪN NÀY CHÍNH XÁC
cd /d "D:\invoices_app\invoices_final"

echo Khởi động FastAPI server...

REM Ghi log ra file để kiểm tra lỗi nếu server không chạy
REM File log sẽ được tạo trong thư mục project của bạn
echo %date% %time% - Starting FastAPI server... >> server_startup.log 2>&1

REM Gọi trực tiếp python.exe trong môi trường ảo để chạy uvicorn
REM Đây là cách đáng tin cậy hơn khi chạy qua Task Scheduler
"D:\invoices_app\invoices_final\venv\Scripts\python.exe" -m uvicorn backend.main:app --host 0.0.0.0 --port 8000 >> server_startup.log 2>&1

echo %date% %time% - FastAPI server process exited. >> server_startup.log 2>&1

REM Bỏ dòng 'pause' hoặc 'exit' nếu bạn muốn script chạy hoàn toàn trong nền và không hiển thị cửa sổ CMD
REM Nếu bạn muốn cửa sổ CMD vẫn mở để xem log trực tiếp (chỉ khi chạy thủ công), hãy bỏ dòng này
REM exit
