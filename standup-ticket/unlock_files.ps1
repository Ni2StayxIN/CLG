# 解锁被锁定的JAR文件脚本
Write-Host "=== 解锁文件脚本 ==="

# 1. 终止所有Java进程
Write-Host "正在终止所有Java进程..."
Get-Process -Name java -ErrorAction SilentlyContinue | Stop-Process -Force

# 2. 等待几秒钟让进程完全终止
Write-Host "等待进程终止..."
Start-Sleep -Seconds 3

# 3. 尝试删除锁定的JAR文件（可选）
$jarPath = "$PSScriptRoot\target\ticket-system\WEB-INF\lib\tomcat-embed-jasper-10.1.7.jar"
if (Test-Path $jarPath) {
    Write-Host "尝试删除锁定的JAR文件..."
    try {
        Remove-Item $jarPath -Force
        Write-Host "✓ 文件删除成功"
    } catch {
        Write-Host "✗ 文件仍被锁定: $_"
        Write-Host "提示: 可能需要重启计算机或关闭所有可能使用该文件的程序"
    }
} else {
    Write-Host "文件不存在，可能已经被删除"
}

Write-Host "=== 解锁操作完成 ==="
