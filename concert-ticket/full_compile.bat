@echo off

echo ========== 完整编译脚本 ==========

REM 创建必要的目录结构
mkdir "f:\NFU\Java程序设计\final exam\ticket-system\target\classes\com\fengwei\ticket\entity" 2>nul
mkdir "f:\NFU\Java程序设计\final exam\ticket-system\target\classes\com\fengwei\ticket\dao" 2>nul
mkdir "f:\NFU\Java程序设计\final exam\ticket-system\target\classes\com\fengwei\ticket\servlet" 2>nul

REM 编译实体类和DAO类
echo 编译基础类...
javac -d "f:\NFU\Java程序设计\final exam\ticket-system\target\classes" -cp "f:\NFU\Java程序设计\final exam\ticket-system\lib\*" -encoding UTF-8 src\main\java\com\fengwei\ticket\entity\Concert.java
javac -d "f:\NFU\Java程序设计\final exam\ticket-system\target\classes" -cp "f:\NFU\Java程序设计\final exam\ticket-system\target\classes;f:\NFU\Java程序设计\final exam\ticket-system\lib\*" -encoding UTF-8 src\main\java\com\fengwei\ticket\dao\ConcertDAO.java

if %ERRORLEVEL% equ 0 (
    echo 基础类编译成功！
    
    REM 编译DataInitializerServlet
echo 编译DataInitializerServlet...
javac -d "f:\NFU\Java程序设计\final exam\ticket-system\target\classes" -cp "f:\NFU\Java程序设计\final exam\ticket-system\target\classes;f:\NFU\Java程序设计\final exam\ticket-system\lib\*" -encoding UTF-8 src\main\java\com\fengwei\ticket\servlet\DataInitializerServlet.java

    if %ERRORLEVEL% equ 0 (
        echo DataInitializerServlet编译成功！
    ) else (
        echo DataInitializerServlet编译失败！
    )
) else (
    echo 基础类编译失败！
)

echo ============================
