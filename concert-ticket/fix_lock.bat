@echo off

echo === 文件锁定问题修复工具 ===

REM 终止所有Java进程
echo 终止所有Java进程以释放文件锁定...
taskkill /F /IM java.exe >nul 2>nul

echo 操作完成！您可以尝试重新启动应用程序。
pause
