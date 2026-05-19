@echo off

REM 安全启动脚本 - 解决JAR文件锁定问题
echo === Concert Ticket System Safe Startup ===

REM 1. 首先终止所有运行中的Java进程，确保释放文件锁定
echo 释放Java进程锁定的文件...
taskkill /F /IM java.exe 2>nul

REM 等待1秒让进程完全终止
ping -n 2 127.0.0.1 >nul

REM 2. 设置类路径
set LIB_DIR=target\ticket-system\WEB-INF\lib
set CLASSPATH=target\classes

REM 添加所有JAR文件到类路径
for %%f in (%LIB_DIR%\*.jar) do (
    set CLASSPATH=!CLASSPATH!;%%f
)

REM 3. 尝试编译修改的文件
echo 编译修改的Servlet文件...
javac -d target\classes -cp "%CLASSPATH%" src\main\java\com\fengwei\ticket\servlet\DataInitializerServlet.java

REM 4. 启动应用
echo 启动应用程序...
echo 服务器将在: http://localhost:8081/ticket-system 运行
echo 按 Ctrl+C 停止服务器
java -cp "%CLASSPATH%" com.fengwei.ticket.Main
