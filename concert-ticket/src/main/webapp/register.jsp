<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>用户注册 - 锋味汉堡演唱会系统</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome@6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Microsoft YaHei', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
        }
        .register-container {
            background: white;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
            width: 100%;
            max-width: 500px;
        }
        .register-title {
            text-align: center;
            margin-bottom: 30px;
            color: #333;
            font-size: 24px;
            font-weight: bold;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #555;
            font-weight: bold;
        }
        .form-group input {
            width: 100%;
            padding: 12px;
            border: 2px solid #ddd;
            border-radius: 8px;
            font-size: 16px;
            transition: border-color 0.3s;
        }
        .form-group input:focus {
            border-color: #667eea;
            outline: none;
        }
        .register-btn {
            width: 100%;
            padding: 12px;
            background: #667eea;
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 16px;
            font-weight: bold;
            transition: background 0.3s;
            margin-top: 10px;
        }
        .register-btn:hover {
            background: #5a6fd8;
        }
        .error {
            color: #e74c3c;
            text-align: center;
            margin-bottom: 15px;
            padding: 10px;
            background: #ffeaea;
            border-radius: 5px;
        }
        .success {
            color: #27ae60;
            text-align: center;
            margin-bottom: 15px;
            padding: 10px;
            background: #e8f6ef;
            border-radius: 5px;
        }
        .login-link {
            text-align: center;
            margin-top: 20px;
        }
        .logo {
            text-align: center;
            margin-bottom: 20px;
            color: #667eea;
            font-size: 28px;
            font-weight: bold;
        }
        .form-row {
            display: flex;
            gap: 15px;
        }
        .form-row .form-group {
            flex: 1;
        }
    </style>
</head>
<body>
<div class="register-container">
    <div class="logo">🍔 锋味汉堡演唱会</div>
    <h2 class="register-title">学生信息注册</h2>

    <% if (request.getAttribute("error") != null) { %>
    <div class="error"><%= request.getAttribute("error") %></div>
    <% } %>

    <% if (request.getAttribute("success") != null) { %>
    <div class="success"><%= request.getAttribute("success") %></div>
    <% } %>

    <form action="register" method="post">
        <div class="form-row">
            <div class="form-group">
                <label>👤 用户名：</label>
                <input type="text" name="username" required placeholder="设置登录用户名">
            </div>
            <div class="form-group">
                <label>🔒 密码：</label>
                <input type="password" name="password" required placeholder="设置登录密码">
            </div>
        </div>

        <div class="form-row">
            <div class="form-group">
                <label>📝 真实姓名：</label>
                <input type="text" name="realName" required placeholder="请输入真实姓名">
            </div>
            <div class="form-group">
                <label>🎓 学号：</label>
                <input type="text" name="studentId" required placeholder="请输入学号">
            </div>
        </div>

        <div class="form-row">
            <div class="form-group">
                <label>📞 手机号：</label>
                <input type="tel" name="phone" required placeholder="请输入手机号">
            </div>
            <div class="form-group">
                <label>📧 邮箱：</label>
                <input type="email" name="email" placeholder="请输入邮箱（选填）">
            </div>
        </div>

        <button type="submit" class="register-btn">立即注册</button>
    </form>

    <div class="login-link">
        <p>已有账号？<a href="login" style="color: #667eea; text-decoration: none; font-weight: bold;">立即登录</a></p>
    </div>

    <div style="margin-top: 20px; padding: 15px; background: #f8f9fa; border-radius: 8px;">
        <p style="text-align: center; margin-bottom: 10px; font-weight: bold;">测试账号</p>
        <div style="display: flex; justify-content: space-between; font-size: 14px;">
            <div>
                <p>张三: zhangsan / 123456</p>
                <p>李四: lisi / 123456</p>
            </div>
            <div>
                <p>王五: wangwu / 123456</p>
                <p>管理员: admin / 123456</p>
            </div>
        </div>
    </div>
</div>
</body>
</html>