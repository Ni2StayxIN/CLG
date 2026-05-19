@echo off

REM 完整编译脚本 - 编译所有Java文件
echo === 编译所有Java文件 ===

REM 终止所有Java进程
taskkill /F /IM java.exe >nul 2>nul

REM 设置路径变量
set "PROJECT_DIR=%~dp0"
set "SRC_DIR=%PROJECT_DIR%src\main\java"
set "OUTPUT_DIR=%PROJECT_DIR%target\classes"
set "LIB_DIR=%PROJECT_DIR%target\ticket-system\WEB-INF\lib"

REM 创建输出目录
mkdir "%OUTPUT_DIR%" 2>nul

REM 设置类路径
set "CLASSPATH=%OUTPUT_DIR%"
for %%f in ("%LIB_DIR%\*.jar") do (
    set "CLASSPATH=!CLASSPATH!;%%f"
)

REM 编译所有Java文件
echo 开始编译...
javac -d "%OUTPUT_DIR%" -cp "!CLASSPATH!" -encoding UTF-8 "%SRC_DIR%\com\fengwei\ticket\Main.java"
javac -d "%OUTPUT_DIR%" -cp "!CLASSPATH!" -encoding UTF-8 "%SRC_DIR%\com\fengwei\ticket\**\*.java"

if %ERRORLEVEL% equ 0 (
    echo ✓ 编译成功！
    echo 可以运行 restart_app.bat 启动应用
) else (
    echo ✗ 编译失败！
)
