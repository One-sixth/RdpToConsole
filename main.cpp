#include <windows.h>

// 延迟时间（秒），编译时通过 /DDELAY_SECONDS=N 指定
#ifndef DELAY_SECONDS
#define DELAY_SECONDS 10
#endif

#define STRINGIFY(x) #x
#define TOSTRING(x) STRINGIFY(x)
#define WIDE(x) L ## x
#define TOWIDE(x) WIDE(x)

#define TIMEOUT_CMD "timeout /t " TOSTRING(DELAY_SECONDS) " /nobreak >nul"

// 宽字符提示：L "60" L"秒后..." → L"60秒后..."
#define MSG_START TOWIDE(TOSTRING(DELAY_SECONDS)) L"秒后将远程桌面连接转移到本地...\n"
#define MSG_DONE  L"转移完成！\n"

void PrintW(const wchar_t* msg) {
    DWORD n;
    WriteConsoleW(GetStdHandle(STD_OUTPUT_HANDLE), msg, lstrlenW(msg), &n, NULL);
}

int main() {
    system("chcp 65001 >nul");
    PrintW(MSG_START);
    system(TIMEOUT_CMD);
    system("for /f \"skip=1 tokens=3\" %s in ('query user %USERNAME%') do tscon.exe %s /dest:console");
    PrintW(MSG_DONE);
    return 0;
}