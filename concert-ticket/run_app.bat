@echo off

REM 简单的启动脚本 - Simple startup script
echo === Concert Ticket System Startup ===

REM Set classpath with all required JARs
set LIB_DIR=target\ticket-system\WEB-INF\lib
set CLASSPATH=target\classes

REM Add all JAR files to classpath
for %%f in (%LIB_DIR%\*.jar) do (
    set CLASSPATH=!CLASSPATH!;%%f
)

REM Compile Java files
echo Compiling Java source files...
javac -d target\classes -cp "!CLASSPATH!" src\main\java\com\fengwei\ticket\*.java src\main\java\com\fengwei\ticket\*\*.java

if %ERRORLEVEL% neq 0 (
    echo Compilation failed! Please check your code.
    pause
    exit /b 1
)

echo Compilation successful!

REM Start the application
echo Starting application...
echo Server will be available at: http://localhost:8081/ticket-system
echo Press Ctrl+C to stop the server
java -cp "!CLASSPATH!" com.fengwei.ticket.Main
