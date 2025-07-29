import os
import sys
from sqlmodel import SQLModel
from logging.config import fileConfig

from sqlalchemy import engine_from_config
from sqlalchemy import pool

from alembic import context

# --- THÊM CÁC DÒNG NÀY ĐỂ IMPORT MODELS CỦA BẠN ---
# Cấu hình để Alembic có thể tìm thấy các module của dự án
# Giả sử thư mục backend nằm ở cùng cấp với thư mục alembic
sys.path.append(os.getcwd())
# Hoặc cụ thể hơn nếu backend ở trong D:\invoices_app\invoices_final_v3
# sys.path.append("D:\\invoices_app\\invoices_final_v3") # Hoặc đường dẫn gốc của dự án nếu cần

# Import tất cả các model của bạn để Alembic có thể phát hiện chúng
# THAY THẾ 'your_app.models' BẰNG ĐƯỜNG DẪN THỰC TẾ ĐẾN FILE models.py CỦA BẠN
# Ví dụ, nếu models.py của bạn nằm trong thư mục 'backend':
from backend.models import * # <--- THÊM DÒNG NÀY (hoặc import từng model cụ thể)
# --- KẾT THÚC PHẦN THÊM ---

# this is the Alembic Config object, which provides
# access to the values within the .ini file in use.
config = context.config

# Interpret the config file for Python logging.
# This line sets up loggers basically.
if config.config_file_name is not None:
    fileConfig(config.config_file_name)

# add your model's MetaData object here
# for 'autogenerate' support
# from myapp import mymodel
# target_metadata = mymodel.Base.metadata
target_metadata = SQLModel.metadata # <--- Đã đúng

# other values from the config, defined by the needs of env.py,
# can be acquired:
# my_important_option = config.get_main_option("my_important_option")
# ... etc.


def run_migrations_offline() -> None:
    """Run migrations in 'offline' mode.

    This configures the context with just a URL
    and not an Engine, though an Engine is acceptable
    here as well.  By skipping the Engine creation
    we don't even need a DBAPI to be available.

    Calls to context.execute() here emit the given string to the
    script output.

    """
    url = config.get_main_option("sqlalchemy.url")
    context.configure(
        url=url,
        target_metadata=target_metadata,
        literal_binds=True,
        dialect_opts={"paramstyle": "named"},
    )

    with context.begin_transaction():
        context.run_migrations()


def run_migrations_online() -> None:
    """Run migrations in 'online' mode.

    In this scenario we need to create an Engine
    and associate a connection with the context.

    """
    connectable = engine_from_config(
        config.get_section(config.config_ini_section, {}),
        prefix="sqlalchemy.",
        poolclass=pool.NullPool,
    )

    with connectable.connect() as connection:
        context.configure(
            connection=connection, target_metadata=target_metadata # <--- Đã đúng
        )

        with context.begin_transaction():
            context.run_migrations()


if context.is_offline_mode():
    run_migrations_offline()
else:
    run_migrations_online()