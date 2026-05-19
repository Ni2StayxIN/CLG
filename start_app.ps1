# 简单启动脚本
Write-Host "=== 演唱会系统启动脚本 ==="

# 设置路径变量
$projectDir = $PSScriptRoot
$outputDir = Join-Path $projectDir "target\classes"
$libDir = Join-Path $projectDir "target\ticket-system\WEB-INF\lib"

# 创建输出目录结构
Write-Host "创建目录结构..."
New-Item -ItemType Directory -Force -Path "$outputDir\com\fengwei\ticket"
New-Item -ItemType Directory -Force -Path "$outputDir\com\fengwei\ticket\dao"
New-Item -ItemType Directory -Force -Path "$outputDir\com\fengwei\ticket\entity"
New-Item -ItemType Directory -Force -Path "$outputDir\com\fengwei\ticket\filter"
New-Item -ItemType Directory -Force -Path "$outputDir\com\fengwei\ticket\listener"
New-Item -ItemType Directory -Force -Path "$outputDir\com\fengwei\ticket\service"
New-Item -ItemType Directory -Force -Path "$outputDir\com\fengwei\ticket\servlet"
New-Item -ItemType Directory -Force -Path "$outputDir\com\fengwei\ticket\util"

# 设置类路径
$classpath = $outputDir
Get-ChildItem -Path "$libDir\*.jar" | ForEach-Object {
    $classpath += ";$($_.FullName)"
}

Write-Host "类路径已配置"

# 启动应用
Write-Host "启动应用程序..."
Write-Host "服务器将在: http://localhost:8081/ticket-system"
java -cp "$classpath" com.fengwei.ticket.Main
