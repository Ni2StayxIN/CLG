@echo off

REM 简单重启脚本 - 先终止进程再启动
echo === 重启演唱会系统 ===

REM 终止所有Java进程
echo 终止Java进程...
taskkill /F /IM java.exe >nul 2>nul

REM 等待2秒让进程完全终止
echo 等待资源释放...
ping -n 3 127.0.0.1 >nul

REM 设置类路径
echo 设置类路径...
set "CLASSPATH=target\classes;target\ticket-system\WEB-INF\lib\*"

REM 启动应用
echo 启动应用程序...
echo 服务器将在: http://localhost:8081/ticket-system
echo 按 Ctrl+C 停止
java -cp "%CLASSPATH%" com.fengwei.ticket.Main
