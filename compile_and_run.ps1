# 编译和运行脚本
Write-Host "=== 演唱会抢票系统 启动脚本 ==="

# 创建编译目录
Write-Host "创建编译目录..."
New-Item -ItemType Directory -Force -Path "target/classes"

# 收集所有JAR文件路径
Write-Host "收集依赖JAR文件..."
$jarFiles = Get-ChildItem -Path "target/ticket-system/WEB-INF/lib" -Filter "*.jar"
$classpath = "target/classes"

foreach ($jar in $jarFiles) {
    $classpath += ";$($jar.FullName)"
}

Write-Host "类路径设置完成，包含 $($jarFiles.Count) 个依赖文件"

# 编译Java源代码
Write-Host "开始编译Java源代码..."
try {
    javac -d "target/classes" -cp "$classpath" "src/main/java/com/fengwei/ticket/**/*.java"
    Write-Host "✓ 编译成功!"
} catch {
    Write-Host "✗ 编译失败! 错误: $_"
    exit 1
}

# 复制资源文件（如果有）
Write-Host "检查并复制资源文件..."
if (Test-Path "src/main/resources") {
    Copy-Item -Recurse "src/main/resources/*" "target/classes" -Force
    Write-Host "✓ 资源文件复制完成"
}

# 启动应用
Write-Host ""
Write-Host "=== 启动演唱会抢票系统 ==="
Write-Host "应用将在 http://localhost:8081/ticket-system 运行"
Write-Host "按 Ctrl+C 停止服务"
Write-Host ""

try {
    java -cp "$classpath" com.fengwei.ticket.Main
} catch {
    Write-Host "✗ 应用启动失败! 错误: $_"
    Write-Host "请检查数据库连接配置，确保MySQL服务正在运行且ticket_system数据库存在"
}