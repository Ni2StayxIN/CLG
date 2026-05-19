@echo off
chcp 65001 >nul
echo ========================================
echo   修复 JSTL URI 并重新部署
echo ========================================
echo.

set TOMCAT=E:\apache-tomcat-10.1.7
set PROJECT=f:\NFU\项目开发实训1\ticket-system
set JAVA_HOME=E:\jdk17.0.12

echo [1/5] 停止 Tomcat...
taskkill /F /IM java.exe 2>nul
timeout /t 3 /nobreak >nul

echo [2/5] 清理旧部署...
if exist "%TOMCAT%\webapps\ticket-system" rmdir /s /q "%TOMCAT%\webapps\ticket-system"
if exist "%TOMCAT%\webapps\ticket-system.war" del /f /q "%TOMCAT%\webapps\ticket-system.war"
if exist "%TOMCAT%\work\Catalina\localhost\ticket-system" rmdir /s /q "%TOMCAT%\work\Catalina\localhost\ticket-system"

echo [3/5] 构建 WAR...
cd /d "%PROJECT%"
call mvn clean package -DskipTests -q
if not exist "target\ticket-system.war" (
    echo 构建失败！
    pause
    exit /b 1
)
echo 构建成功！

echo [4/5] 部署...
copy /y "target\ticket-system.war" "%TOMCAT%\webapps\ticket-system.war" >nul
cd /d "%TOMCAT%\webapps"
mkdir ticket-system 2>nul
cd ticket-system
"%JAVA_HOME%\bin\jar.exe" xf "..\ticket-system.war"
echo 部署完成！

echo [5/5] 启动 Tomcat...
cd /d "%TOMCAT%\bin"
call startup.bat

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
