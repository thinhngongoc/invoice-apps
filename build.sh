#!/usr/bin/env bash

echo "Setting up Rust environment for Render..."

# 1. Export CARGO_HOME and RUSTUP_HOME (đã làm, nhưng nên có trong script để đảm bảo)
export CARGO_HOME="/opt/render/project/src/.cargo"
export RUSTUP_HOME="/opt/render/project/src/.rustup"

# 2. Tạo các thư mục nếu chúng chưa tồn tại
mkdir -p $CARGO_HOME
mkdir -p $RUSTUP_HOME

# 3. Thêm Rustup/Cargo vào PATH
# Đảm bảo Cargo bin directory có trong PATH
export PATH="$CARGO_HOME/bin:$PATH"

# 4. Cài đặt Rust toolchain mặc định (nếu chưa có) và thiết lập nó
# Đây là bước quan trọng để giải quyết "rustup could not choose a version"
if [ ! -f "$RUSTUP_HOME/toolchains/stable-x86_64-unknown-linux-gnu/bin/cargo" ]; then
    echo "Installing Rust stable toolchain..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --default-toolchain stable
    echo "Rust toolchain installed."
else
    echo "Rust stable toolchain already installed."
fi

# Nguồn lại biến môi trường sau khi rustup chạy (quan trọng)
# rustup tự động thêm cargo vào PATH của shell hiện tại,
# nhưng chúng ta cần đảm bảo nó áp dụng cho script này.
source $CARGO_HOME/env || source $CARGO_HOME/bin/cargo/env || true


# 5. Chạy lệnh cài đặt Python dependencies của bạn
echo "Installing Python dependencies..."
pip install -r requirements.txt

echo "Build process completed."

# Có thể thêm các lệnh khác ở đây, ví dụ:
# python manage.py migrate
# python manage.py collectstatic --noinput