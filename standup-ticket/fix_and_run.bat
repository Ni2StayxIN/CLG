@echo off

REM 简化版修复和运行脚本
echo ========== 演唱会系统助手 ==========

REM 终止Java进程
echo 正在终止Java进程...
taskkill /F /IM java.exe >nul 2>nul

REM 等待进程释放
echo 等待资源释放...
ping -n 3 127.0.0.1 >nul

REM 显示手动编译命令
echo.  
echo 请手动运行以下命令编译代码：
echo javac -d target\classes -cp target\ticket-system\WEB-INF\lib\* src\main\java\com\fengwei\ticket\Main.java

echo.  
echo 然后运行以下命令启动应用：
echo java -cp "target\classes;target\ticket-system\WEB-INF\lib\*" com.fengwei.ticket.Main

echo.  
echo 如果遇到文件锁定问题，请再次运行此脚本。
echo =======================================
pause
