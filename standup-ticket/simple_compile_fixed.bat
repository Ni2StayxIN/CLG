@echo off

echo 编译 DataInitializerServlet.java...

REM 创建输出目录
mkdir "f:\NFU\Java程序设计\final exam\ticket-system\target\classes\com\fengwei\ticket\servlet" 2>nul

REM 编译文件，使用绝对路径
javac -d "f:\NFU\Java程序设计\final exam\ticket-system\target\classes" -cp "f:\NFU\Java程序设计\final exam\ticket-system\target\classes;f:\NFU\Java程序设计\final exam\ticket-system\lib\*" -encoding UTF-8 "f:\NFU\Java程序设计\final exam\ticket-system\src\main\java\com\fengwei\ticket\servlet\DataInitializerServlet.java"

if %ERRORLEVEL% equ 0 (
    echo 编译成功！
) else (
    echo 编译失败！
)
