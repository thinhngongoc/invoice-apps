@echo off
chcp 437 > nul

REM Set PGPASSFILE to explicitly point to the .pgpass file location
REM This ensures pg_dump finds the password file.
SET PGPASSFILE=%APPDATA%\postgresql\.pgpass

REM --- DATABASE CONFIGURATION ---
SET DB_HOST=localhost
SET DB_PORT=5432
SET DB_USER=admin
SET DB_NAME=invoices
REM PGPASSWORD is handled by the .pgpass file for security and reliability.

REM --- BACKUP CONFIGURATION ---
SET BACKUP_DIR=D:\invoices_app\invoices_final\db_backups
REM Ensure this path is correct and exists or will be created.

REM Get current date and time in YYYYMMDD_HHMMSS format
for /f "tokens=1-4 delims=/ " %%a in ('date /t') do (set date_dd=%%a& set date_mm=%%b& set date_yyyy=%%c)
for /f "tokens=1-4 delims=:." %%a in ('time /t') do (set time_hh=%%a& set time_mm=%%b& set time_ss=%%c)

REM Format to YYYYMMDD_HHMMSS (assuming DD/MM/YYYY date format based on your locale)
REM Adjust if your system uses MM/DD/YYYY or YYYY-MM-DD
SET CURRENT_DATE_TIME=%date_yyyy%%date_mm%%date_dd%_%time_hh%%time_mm%%time_ss%
SET BACKUP_FILE=invoices_%CURRENT_DATE_TIME%.sql

REM --- BACKUP LOGIC ---
ECHO Starting database backup for %DB_NAME%...

REM Create backup directory if it does not exist
IF NOT EXIST "%BACKUP_DIR%" MKDIR "%BACKUP_DIR%"

REM Execute pg_dump command. It will use the .pgpass file for authentication.
"C:\Program Files\PostgreSQL\17\bin\pg_dump.exe" -h %DB_HOST% -p %DB_PORT% -U %DB_USER% -F p -v -f "%BACKUP_DIR%\%BACKUP_FILE%" %DB_NAME%

IF %ERRORLEVEL% NEQ 0 (
    ECHO Error: Database backup failed!
    ECHO Please check .pgpass file content, permissions, or database configuration.
) ELSE (
    ECHO Database backup successful to "%BACKUP_DIR%\%BACKUP_FILE%"
)

REM --- Optional: Delete old backups (e.g., older than X days) ---
REM For example: Delete .sql files older than 7 days (keeps the last 7 days of backups)
REM forfiles /p "%BACKUP_DIR%" /s /m *.sql /d -7 /c "cmd /c del @file"
REM ECHO Old backups deleted (older than 7 days).