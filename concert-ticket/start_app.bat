@echo off

echo === Concert Ticket System Startup ===

REM Set classpath with all required JARs
set LIB_DIR=target\ticket-system\WEB-INF\lib
set CLASSPATH=target\classes

REM Add all JAR files to classpath
for %%f in (%LIB_DIR%\*.jar) do (
    set CLASSPATH=!CLASSPATH!;%%f
)

REM Verify classpath
REM echo Classpath: !CLASSPATH!

REM Start the application
echo Starting application using pre-compiled classes...
echo Server will be available at: http://localhost:8081/ticket-system
echo Press Ctrl+C to stop the server
java -cp "!CLASSPATH!" com.fengwei.ticket.Main
