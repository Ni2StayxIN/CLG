@echo off
setlocal enabledelayedexpansion

set PROJECT_DIR=%~dp0
set OUTPUT_DIR=%PROJECT_DIR%target\classes
set LIB_DIR=%PROJECT_DIR%target\ticket-system\WEB-INF\lib
set CLASSPATH=%OUTPUT_DIR%

for %%f in ("%LIB_DIR%\*.jar") do (
    set CLASSPATH=!CLASSPATH!;%%f
)

echo 编译 DataInitializerServlet.java...
javac -d "%OUTPUT_DIR%" -cp "!CLASSPATH!" "%PROJECT_DIR%src\main\java\com\fengwei\ticket\servlet\DataInitializerServlet.java"

if %ERRORLEVEL% equ 0 (
    echo 编译成功！
) else (
    echo 编译失败！
)
