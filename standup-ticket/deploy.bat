@echo off
chcp 65001 >nul
echo ========================================
echo   脱口秀门票系统 - 一键部署
echo ========================================
echo.

REM 设置路径
set JAVA_HOME=E:\jdk17.0.12
set TOMCAT_HOME=E:\apache-tomcat-10.1.7
set PROJECT_DIR=f:\NFU\项目开发实训1\ticket-system

echo [1/6] 停止 Tomcat...
taskkill /F /IM java.exe 2>nul
timeout /t 3 /nobreak >nul

echo [2/6] 清理旧部署...
if exist "%TOMCAT_HOME%\webapps\ticket-system" rmdir /s /q "%TOMCAT_HOME%\webapps\ticket-system"
if exist "%TOMCAT_HOME%\webapps\ticket-system.war" del /f /q "%TOMCAT_HOME%\webapps\ticket-system.war"
if exist "%TOMCAT_HOME%\work\Catalina\localhost\ticket-system" rmdir /s /q "%TOMCAT_HOME%\work\Catalina\localhost\ticket-system"

echo [3/6] 构建 WAR...
cd /d "%PROJECT_DIR%"
call mvn clean package -DskipTests -q
if not exist "target\ticket-system.war" (
    echo 构建失败！
    pause
    exit /b 1
)

echo [4/6] 部署 WAR...
copy /y "target\ticket-system.war" "%TOMCAT_HOME%\webapps\ticket-system.war" >nul

REM 解压 WAR
cd /d "%TOMCAT_HOME%\webapps"
mkdir ticket-system 2>nul
cd ticket-system
"%JAVA_HOME%\bin\jar.exe" xf "..\ticket-system.war"

echo [5/6] 启动 Tomcat...
cd /d "%TOMCAT_HOME%\bin"
call startup.bat

echo [6/6] 等待启动...
timeout /t 15 /nobreak >nul

echo.
echo ========================================
echo   部署完成！
echo   访问: http://localhost:8081/ticket-system/shows
echo ========================================
echo.
echo 按任意键打开浏览器...
pause >nul
start http://localhost:8081/ticket-system/shows
