@echo off

set "PROJECT_DIR=%~dp0"
set "OUTPUT_DIR=%PROJECT_DIR%target\classes"

mkdir "%OUTPUT_DIR%\com\fengwei\ticket\servlet" 2>nul

javac -d "%OUTPUT_DIR%" "%PROJECT_DIR%src\main\java\com\fengwei\ticket\servlet\DataInitializerServlet.java"

echo 编译完成
