@echo off

setlocal enabledelayedexpansion
echo === 演唱会系统重建和启动脚本 ===

REM 终止所有Java进程
echo 终止Java进程...
taskkill /F /IM java.exe >nul 2>nul
ping -n 3 127.0.0.1 >nul

REM 设置路径变量
set "PROJECT_DIR=%~dp0"
set "SRC_DIR=%PROJECT_DIR%src\main\java"
set "OUTPUT_DIR=%PROJECT_DIR%target\classes"
set "LIB_DIR=%PROJECT_DIR%lib"

REM 创建输出目录结构
echo 创建目录结构...
mkdir "%OUTPUT_DIR%\com\fengwei\ticket" 2>nul
mkdir "%OUTPUT_DIR%\com\fengwei\ticket\dao" 2>nul
mkdir "%OUTPUT_DIR%\com\fengwei\ticket\entity" 2>nul
mkdir "%OUTPUT_DIR%\com\fengwei\ticket\filter" 2>nul
mkdir "%OUTPUT_DIR%\com\fengwei\ticket\listener" 2>nul
mkdir "%OUTPUT_DIR%\com\fengwei\ticket\service" 2>nul
mkdir "%OUTPUT_DIR%\com\fengwei\ticket\servlet" 2>nul
mkdir "%OUTPUT_DIR%\com\fengwei\ticket\util" 2>nul

REM 设置类路径
set "CLASSPATH=%OUTPUT_DIR%"
for %%f in ("%LIB_DIR%\*.jar") do (
    set "CLASSPATH=!CLASSPATH!;%%f"
)

echo 类路径已配置，包含所有lib目录下的JAR文件

REM 编译Main类
echo 编译Main类...
javac -d "%OUTPUT_DIR%" -cp "!CLASSPATH!" -encoding UTF-8 "%SRC_DIR%\com\fengwei\ticket\Main.java"

if %ERRORLEVEL% neq 0 (
    echo Main类编译失败！
    pause
    exit /b 1
)

echo Main类编译成功！

REM 编译其他必要的类
echo 编译其他关键类...
javac -d "%OUTPUT_DIR%" -cp "!CLASSPATH!" -encoding UTF-8 "%SRC_DIR%\com\fengwei\ticket\listener\*.java"
javac -d "%OUTPUT_DIR%" -cp "!CLASSPATH!" -encoding UTF-8 "%SRC_DIR%\com\fengwei\ticket\filter\*.java"

REM 启动应用
echo 启动应用程序...
echo 服务器将在: http://localhost:8081/ticket-system
java -cp "!CLASSPATH!" com.fengwei.ticket.Main
