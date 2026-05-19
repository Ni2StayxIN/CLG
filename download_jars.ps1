# 创建WebClient对象
$webClient = New-Object System.Net.WebClient

# JAR文件下载列表
$jars = @(
    @{url="https://repo1.maven.org/maven2/org/apache/tomcat/embed/tomcat-embed-core/10.1.7/tomcat-embed-core-10.1.7.jar"; path="lib\\tomcat-embed-core-10.1.7.jar"},
    @{url="https://repo1.maven.org/maven2/org/apache/tomcat/embed/tomcat-embed-jasper/10.1.7/tomcat-embed-jasper-10.1.7.jar"; path="lib\\tomcat-embed-jasper-10.1.7.jar"},
    @{url="https://repo1.maven.org/maven2/org/apache/tomcat/embed/tomcat-embed-el/10.1.7/tomcat-embed-el-10.1.7.jar"; path="lib\\tomcat-embed-el-10.1.7.jar"},
    @{url="https://repo1.maven.org/maven2/mysql/mysql-connector-java/8.0.33/mysql-connector-java-8.0.33.jar"; path="lib\\mysql-connector-java-8.0.33.jar"},
    @{url="https://repo1.maven.org/maven2/jakarta/servlet/jakarta.servlet-api/6.0.0/jakarta.servlet-api-6.0.0.jar"; path="lib\\jakarta.servlet-api-6.0.0.jar"},
    @{url="https://repo1.maven.org/maven2/jakarta/servlet/jsp/jakarta.servlet.jsp-api/3.1.0/jakarta.servlet.jsp-api-3.1.0.jar"; path="lib\\jakarta.servlet.jsp-api-3.1.0.jar"},
    @{url="https://repo1.maven.org/maven2/jakarta/servlet/jsp/jstl/jakarta.servlet.jsp.jstl-api/3.0.0/jakarta.servlet.jsp.jstl-api-3.0.0.jar"; path="lib\\jakarta.servlet.jsp.jstl-api-3.0.0.jar"},
    @{url="https://repo1.maven.org/maven2/org/glassfish/web/jakarta.servlet.jsp.jstl/3.0.1/jakarta.servlet.jsp.jstl-3.0.1.jar"; path="lib\\jakarta.servlet.jsp.jstl-3.0.1.jar"},
    @{url="https://repo1.maven.org/maven2/com/fasterxml/jackson/core/jackson-databind/2.15.2/jackson-databind-2.15.2.jar"; path="lib\\jackson-databind-2.15.2.jar"},
    @{url="https://repo1.maven.org/maven2/com/fasterxml/jackson/core/jackson-core/2.15.2/jackson-core-2.15.2.jar"; path="lib\\jackson-core-2.15.2.jar"},
    @{url="https://repo1.maven.org/maven2/com/fasterxml/jackson/core/jackson-annotations/2.15.2/jackson-annotations-2.15.2.jar"; path="lib\\jackson-annotations-2.15.2.jar"}
)

# 下载JAR文件
Write-Host "开始下载必要的JAR文件..."
foreach ($jar in $jars) {
    Write-Host "正在下载: $($jar.url)"
    try {
        $webClient.DownloadFile($jar.url, $jar.path)
        Write-Host "✓ 下载完成: $($jar.path)"
    } catch {
        Write-Host "✗ 下载失败: $($jar.url)"
        Write-Host "错误: $_"
    }
}

# 显示下载结果
Write-Host ""
Write-Host "下载完成! 检查lib目录中的文件:"
Get-ChildItem -Path "lib" -Filter "*.jar" | Select-Object Name

Write-Host ""
Write-Host "接下来可以运行compile_and_run.ps1脚本来编译和启动应用。"