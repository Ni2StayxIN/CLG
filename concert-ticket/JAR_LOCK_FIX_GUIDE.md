# JAR文件锁定问题解决指南

## 问题说明
遇到错误 `Failed to delete F:\NFU\Java程序设计\final exam\ticket-system\target\ticket-system\WEB-INF\lib\tomcat-embed-jasper-10.1.7.jar` 表示该JAR文件被进程锁定，无法删除或修改。

## 解决方案（按优先顺序）

### 1. 已经执行：终止所有Java进程
✅ 已成功执行 `taskkill /F /IM java.exe` 命令

### 2. 检查并关闭可能锁定文件的程序
- **IDE进程**：如果您使用IDEA、Eclipse等IDE，请完全关闭它们
- **命令行窗口**：关闭所有可能运行Java程序的命令行窗口
- **文件管理器**：关闭可能正在访问该文件的文件资源管理器窗口

### 3. 手动删除文件（如果上述方法无效）
1. 打开命令提示符（以管理员身份运行）
2. 执行：`del "F:\NFU\Java程序设计\final exam\ticket-system\target\ticket-system\WEB-INF\lib\tomcat-embed-jasper-10.1.7.jar" /F`

### 4. 使用Process Explorer查找锁定进程（高级方法）
如果文件仍然被锁定，可以使用微软的Process Explorer工具查找哪个进程在使用该文件：
1. 下载Process Explorer: https://docs.microsoft.com/en-us/sysinternals/downloads/process-explorer
2. 运行后按Ctrl+F，输入文件名搜索
3. 找到锁定进程后，右键选择"Kill Process Tree"

### 5. 修改启动脚本以避免锁定问题
我们已经创建了 `fix_lock.bat` 工具，每次启动应用前可以先运行它。

## 建议的工作流程
1. 修改代码
2. 运行 `fix_lock.bat` 或手动终止Java进程
3. 等待几秒钟让进程完全释放资源
4. 然后启动应用程序

## 永久解决方案
如果这个问题频繁发生，考虑修改项目配置，使用Maven或Gradle的正确清理命令：
- Maven: `mvn clean package`
- 确保在pom.xml中正确配置了资源处理

## 注意事项
- 在Windows系统上，文件锁定是比较常见的问题
- 确保不要在多个地方同时运行相同的应用
- 当应用程序异常终止时，文件锁定可能会持续存在
- 有时可能需要重启计算机来完全释放锁定