import subprocess
import time

print("10秒后将远程桌面连接转移到本地...")
time.sleep(10)

cmd = 'for /f "skip=1 tokens=3" %s in (\'query user %USERNAME%\') do (tscon.exe %s /dest:console)'
subprocess.run(cmd, shell=True)

print("转移完成！")
