<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>用户注册 - 脱口秀门票预订系统</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="css/main.css" rel="stylesheet">
    <link href="css/animations.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
        }
        .register-container {
            background: white;
            padding: 36px;
            border-radius: var(--radius-lg);
            box-shadow: var(--shadow-lg);
            width: 100%;
            max-width: 540px;
            animation: scaleIn 0.5s ease;
        }
        .register-title { text-align: center; margin-bottom: 24px; color: var(--text-dark); font-size: 22px; font-weight: 800; }
        .logo { text-align: center; margin-bottom: 18px; font-size: 26px; font-weight: 900; background: var(--primary-gradient); -webkit-background-clip:text; -webkit-text-fill-color:transparent; background-clip:text; }
        .form-row { display: flex; gap: 12px; }
        .form-row .form-field { flex: 1; }
        .msg-box { text-align: center; margin-bottom: 14px; padding: 10px 16px; border-radius: var(--radius-sm); font-size: 13px; font-weight: 500; }
        .msg-error { background: linear-gradient(135deg, rgba(255,71,87,0.1), rgba(255,107,129,0.05)); color: var(--accent-red); border:1px solid rgba(255,71,87,0.2); }
        .msg-success { background: linear-gradient(135deg, rgba(0,184,148,0.1), rgba(85,239,196,0.05)); color: #00b894; border:1px solid rgba(0,184,148,0.2); }
        .login-link { text-align: center; margin-top: 18px; }
        .test-info { margin-top: 16px; padding: 14px; background: var(--bg-warm); border-radius: var(--radius-sm); font-size: 13px; color: var(--text-secondary); }
    </style>
</head>
<body>
<div class="register-container">
    <div class="logo">🎤 脱口秀门票预订</div>
    <h2 class="register-title">学生信息注册</h2>

    <% if (request.getAttribute("error") != null) { %>
    <div class="msg-box msg-error"><i class="fas fa-exclamation-circle"></i> <%= request.getAttribute("error") %></div>
    <% } %>
    <% if (request.getAttribute("success") != null) { %>
    <div class="msg-box msg-success"><i class="fas fa-check-circle"></i> <%= request.getAttribute("success") %></div>
    <% } %>

    <form action="register" method="post" id="regForm">
        <div class="form-row">
            <div class="form-field">
                <label class="required">👤 用户名</label>
                <input type="text" name="username" required placeholder="设置登录用户名">
                <span class="form-error-msg"></span>
            </div>
            <div class="form-field">
                <label class="required">🔒 密码</label>
                <input type="password" name="password" required placeholder="设置登录密码">
                <span class="form-error-msg"></span>
            </div>
        </div>
        <div class="form-row">
            <div class="form-field">
                <label class="required">📝 真实姓名</label>
                <input type="text" name="realName" required placeholder="请输入真实姓名" data-validate="name">
                <span class="form-error-msg"></span>
            </div>
            <div class="form-field">
                <label class="required">🎓 学号</label>
                <input type="text" name="studentId" required placeholder="请输入学号（8-12位数字）" data-validate="studentId">
                <span class="form-error-msg"></span>
            </div>
        </div>
        <div class="form-row">
            <div class="form-field">
                <label class="required">📞 手机号</label>
                <input type="tel" name="phone" required placeholder="11位手机号" data-validate="phone">
                <span class="form-error-msg"></span>
            </div>
            <div class="form-field">
                <label>📧 邮箱</label>
                <input type="email" name="email" placeholder="选填" data-validate="email">
                <span class="form-error-msg"></span>
            </div>
        </div>
        <button type="submit" class="btn-primary-custom register-btn" style="width:100%;padding:14px;font-size:16px;margin-top:8px;">✨ 立即注册</button>
    </form>

    <div class="login-link">
        <p>已有账号？<a href="login" style="font-weight:700;background:var(--primary-gradient);-webkit-background-clip:text;-webkit-text-fill-color:transparent;background-clip:text;">立即登录</a></p>
    </div>
    <div class="test-info">
        <p style="text-align:center;font-weight:600;margin-bottom:8px;">测试账号</p>
        <div style="display:flex;justify-content:space-between;font-size:12px;">
            <div>张三: zhangsan / 123456</div><div>李四: lisi / 123456</div>
        </div>
        <div style="display:flex;justify-content:space-between;font-size:12px;">
            <div>王五: wangwu / 123456</div><div>管理员: admin / 123456</div>
        </div>
    </div>
</div>

<script src="js/main.js"></script>
<script>
document.getElementById('regForm').addEventListener('submit', function(e) {
    const rules = {
        realName: [{type:'name',msg:'姓名需2-20个字符'}],
        studentId: [{type:'studentId',msg:'学号格式不正确'}],
        phone: [{type:'phone',msg:'手机号格式不正确'}],
        email: [{type:'email',msg:'邮箱格式不正确'}]
    };
    if (!Validator.validateForm('#regForm', rules)) e.preventDefault();
});
document.querySelectorAll('#regForm input[data-validate]').forEach(input => {
    input.addEventListener('blur', function() {
        const type = this.dataset.validate;
        const ruleMap = { name:[{type:'name'}], studentId:[{type:'studentId'}], phone:[{type:'phone'}], email:[{type:'email'}] };
        if (ruleMap[type]) Validator.validateField(this, ruleMap[type]);
    });
});
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
