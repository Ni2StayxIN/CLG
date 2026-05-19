@echo off

REM 开启延迟环境变量扩展
setlocal enabledelayedexpansion

echo === Concert Ticket System Launcher ===

REM 使用绝对路径
set PROJECT_DIR=%~dp0
set OUTPUT_DIR=%PROJECT_DIR%target\classes
set LIB_DIR=%PROJECT_DIR%target\ticket-system\WEB-INF\lib

REM 确认目录存在
if not exist "%OUTPUT_DIR%" (
    echo Creating output directory...
    mkdir "%OUTPUT_DIR%"
)

REM 设置类路径
set CLASSPATH=%OUTPUT_DIR%

REM 添加所有JAR文件到类路径
for %%f in ("%LIB_DIR%\*.jar") do (
    set CLASSPATH=!CLASSPATH!;%%f
)

echo Classpath configured with dependencies

REM 确认Main.class文件存在
if exist "%OUTPUT_DIR%\com\fengwei\ticket\Main.class" (
    echo Main.class found, starting application...
) else (
    echo Main.class not found, attempting to compile...
    
    REM 编译所有Java文件（手动列出主要目录）
    javac -d "%OUTPUT_DIR%" -cp "!CLASSPATH!" ^
        "%PROJECT_DIR%src\main\java\com\fengwei\ticket\Main.java" ^
        "%PROJECT_DIR%src\main\java\com\fengwei\ticket\dao\*.java" ^
        "%PROJECT_DIR%src\main\java\com\fengwei\ticket\entity\*.java" ^
        "%PROJECT_DIR%src\main\java\com\fengwei\ticket\filter\*.java" ^
        "%PROJECT_DIR%src\main\java\com\fengwei\ticket\listener\*.java" ^
        "%PROJECT_DIR%src\main\java\com\fengwei\ticket\service\*.java" ^
        "%PROJECT_DIR%src\main\java\com\fengwei\ticket\servlet\*.java" ^
        "%PROJECT_DIR%src\main\java\com\fengwei\ticket\util\*.java"
    
    if %ERRORLEVEL% neq 0 (
        echo Compilation failed!
        pause
        exit /b 1
    )
    echo Compilation successful!
)

REM 启动应用
echo Starting Concert Ticket System...
echo Server will run at: http://localhost:8081/ticket-system
echo Press Ctrl+C to stop the server
java -cp "!CLASSPATH!" com.fengwei.ticket.Main