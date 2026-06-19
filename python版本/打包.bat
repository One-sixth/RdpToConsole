@echo off
chcp 65001 >nul
echo === Python 打包工具 ===
echo.

set PYTHON=D:\Software\miniconda3\envs\normal\python.exe

if not exist "%PYTHON%" (
    echo 错误：找不到 normal 环境的 Python
    echo 路径：%PYTHON%
    exit /b 1
)

set SRCFILE=转移远程桌面连接到本地
set SRCPATH=%~dp0%SRCFILE%.py

if not exist "%SRCPATH%" (
    echo 错误：找不到源文件 "%SRCPATH%"
    exit /b 1
)

echo 使用 Python: %PYTHON%
echo 源文件: %SRCPATH%
echo.

%PYTHON% -m PyInstaller ^
    --onefile ^
    --name "%SRCFILE%" ^
    --clean ^
    --uac-admin ^
    --distpath "." ^
    "%SRCPATH%"

if errorlevel 1 (
    echo.
    echo ❌ 打包失败！
    exit /b 1
)

echo.
echo ✅ 打包成功！
echo    输出: %SRCFILE%.exe (已申请管理员权限 + UPX 压缩)
echo.
