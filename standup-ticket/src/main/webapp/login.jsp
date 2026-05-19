<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>用户登录 - 脱口秀门票预订系统</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="css/main.css" rel="stylesheet">
    <link href="css/animations.css" rel="stylesheet">
    <style>
        body {
            background: var(--primary-gradient);
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
        }
        .login-container {
            background: white;
            padding: 40px;
            border-radius: var(--radius-lg);
            box-shadow: var(--shadow-lg);
            width: 100%;
            max-width: 420px;
            animation: scaleIn 0.5s ease;
        }
        .login-title { text-align: center; margin-bottom: 28px; color: var(--text-dark); font-size: 22px; font-weight: 800; }
        .logo { text-align: center; margin-bottom: 24px; font-size: 28px; font-weight: 900; background: var(--primary-gradient); -webkit-background-clip:text; -webkit-text-fill-color:transparent; background-clip:text; }
        .error-msg {
            color: white;
            text-align: center;
            margin-bottom: 16px;
            padding: 12px 16px;
            border-radius: var(--radius-sm);
            background: linear-gradient(135deg, var(--accent-red), #ff6b81);
            font-size: 14px;
            font-weight: 500;
            animation: shake 0.4s ease;
        }
        @keyframes shake { 0%,100%{transform:translateX(0)} 25%{transform:translateX(-6px)} 75%{transform:translateX(6px)} }
        .test-account {
            text-align: center;
            margin-top: 20px;
            padding: 16px;
            background: var(--bg-warm);
            border-radius: var(--radius-sm);
            font-size: 13px;
            color: var(--text-secondary);
            border-left: 3px solid var(--primary-start);
        }
    </style>
</head>
<body>
<div class="login-container">
    <div class="logo">🎤 脱口秀门票预订</div>
    <h2 class="login-title">用户登录</h2>

    <% if (request.getAttribute("error") != null) { %>
    <div class="error-msg"><i class="fas fa-exclamation-circle"></i> <%= request.getAttribute("error") %></div>
    <% } %>

    <form action="login" method="post" id="loginForm">
        <div class="form-field">
            <label>👤 用户名</label>
            <input type="text" name="username" required value="admin" placeholder="请输入用户名">
            <span class="form-error-msg"></span>
        </div>
        <div class="form-field">
            <label>🔒 密码</label>
            <input type="password" name="password" required value="123456" placeholder="请输入密码">
            <span class="form-error-msg"></span>
        </div>
        <button type="submit" class="btn-primary-custom login-btn" style="width:100%;padding:14px;font-size:16px;">🚀 登录系统</button>
    </form>

    <div class="test-account">
        <p><strong>💡 测试账号信息</strong></p>
        <p>📝 用户名: admin &nbsp;&nbsp; 🔑 密码: 123456</p>
    </div>
</div>

<script src="js/main.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
