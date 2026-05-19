# Concert Ticket System (演唱会售票系统)

Java Web 演唱会售票管理系统，支持用户注册登录、演唱会浏览、在线购票、订单管理及后台管理等功能。

## 环境要求

| 环境 | 版本 |
|------|------|
| JDK | 17.0.12 |
| Apache Maven | 3.x |
| MySQL | 8.x |
| Tomcat (嵌入式) | 10.1.7（已内嵌在项目中，无需单独安装） |

## 快速开始

### 1. 初始化数据库

执行 `init_database.sql` 创建数据库和表：

```bash
mysql -u root -p < init_database.sql
```

### 2. 修改数据库配置

在 `src/main/java/com/fengwei/ticket/dao/DatabaseUtil.java` 中修改数据库连接信息（用户名、密码等）。

### 3. 编译运行

```bash
# 编译打包
mvn clean package

# 直接启动（嵌入式 Tomcat）
mvn exec:java -Dexec.mainClass="com.fengwei.ticket.Main"

# 或编译后直接运行
mvn compile
mvn exec:java -Dexec.mainClass="com.fengwei.ticket.Main"
```

或者使用项目提供的脚本：

```bash
# 一键编译运行
compile_and_run.ps1    # PowerShell
full_compile.bat       # CMD

# 如果只需要启动（已编译好）
run_app.bat
start_app.bat
```

### 4. 访问系统

启动后打开浏览器访问：

```
http://localhost:8081/ticket-system/
```

## 项目结构

```
ticket-system/
├── src/
│   ├── main/
│   │   ├── java/com/fengwei/ticket/
│   │   │   ├── dao/          # 数据访问层
│   │   │   ├── entity/       # 实体类
│   │   │   ├── filter/       # 过滤器
│   │   │   ├── listener/     # 监听器
│   │   │   ├── service/      # 业务逻辑层
│   │   │   ├── servlet/      # Servlet 控制器
│   │   │   ├── util/         # 工具类
│   │   │   └── Main.java     # 启动入口（嵌入式 Tomcat）
│   │   └── webapp/           # JSP 页面
│   ├── init_database.sql     # 数据库初始化脚本
│   ├── pom.xml               # Maven 配置
│   └── *.bat / *.ps1         # 运行脚本
```

## 功能

- **用户端**：注册登录、浏览演唱会、购票、查看订单
- **管理员端**：管理演唱会、管理订单、管理用户
