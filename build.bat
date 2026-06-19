@echo off
chcp 65001 >nul
echo === Build All Versions ===
echo.

call "%ProgramFiles%\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvarsall.bat" x64 >nul 2>&1
where cl >nul 2>&1 || (echo ERROR: cl not found & exit /b 1)

if not exist "%~dp0bin" mkdir "%~dp0bin"

setlocal enabledelayedexpansion

call :build 10  "转移远程桌面连接到本地_10秒.exe"
call :build 30  "转移远程桌面连接到本地_30秒.exe"
call :build 60  "转移远程桌面连接到本地_1分钟.exe"
call :build 120 "转移远程桌面连接到本地_2分钟.exe"
call :build 300 "转移远程桌面连接到本地_5分钟.exe"

echo === All done ===
goto :eof

:build
set "SECS=%~1"
set "OUTNAME=%~2"
set "OUTPATH=%~dp0bin\%OUTNAME%"

echo [Build] %OUTNAME% (%SECS%s)
cl /MT /O1 /GL /GS- /utf-8 /DDELAY_SECONDS=%SECS% /EHsc /Fe:"!OUTPATH!" "%~dp0main.cpp" /link /SUBSYSTEM:CONSOLE /MANIFEST:EMBED /MANIFESTUAC:level='requireAdministrator' /HEAP:0x1000,0x1000 /STACK:0x10000 /OPT:REF /OPT:ICF /LTCG
if errorlevel 1 (
    echo   FAILED!
) else (
    echo   OK
)
del /q "%~dp0main.obj" 2>nul
echo.
goto :eof
