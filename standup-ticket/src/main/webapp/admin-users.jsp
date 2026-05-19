<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.fengwei.ticket.entity.User" %>
<%@ page import="java.util.List" %>
<%
    User adminUser = (User) session.getAttribute("user");
    if (adminUser == null || !"admin".equals(adminUser.getUserType())) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<User> users = (List<User>) request.getAttribute("users");
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>用户管理 - 管理员后台</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="css/main.css" rel="stylesheet">
    <link href="css/animations.css" rel="stylesheet">
    <link href="css/admin.css" rel="stylesheet">
</head>
<body>
<div class="sidebar" id="adminSidebar">
    <div class="sidebar-header">
        <h4>🎭 脱口秀票务</h4>
        <p>管理员控制台</p>
    </div>
    <ul class="sidebar-menu">
        <li><a href="admin"><i class="fas fa-tachometer-alt"></i> 控制面板</a></li>
        <li><a href="admin?action=shows"><i class="fas fa-microphone"></i> 演出管理</a></li>
        <li><a href="admin?action=orders"><i class="fas fa-ticket-alt"></i> 订单管理</a></li>
        <li><a href="admin?action=refunds"><i class="fas fa-undo"></i> 退票管理</a></li>
        <li><a href="admin?action=users" class="active"><i class="fas fa-users"></i> 用户管理</a></li>
        <li style="margin-top: 16px; border-top: 1px solid var(--admin-sidebar-border); padding-top: 12px;">
            <a href="shows"><i class="fas fa-home"></i> 返回前台</a>
        </li>
        <li><a href="login?action=logout"><i class="fas fa-sign-out-alt"></i> 退出登录</a></li>
    </ul>
    <div class="sidebar-footer">
        <div style="font-size: 11px; color: var(--text-secondary); text-align: center;">
            &copy; 2025 脱口秀票务系统
        </div>
    </div>
</div>

<div class="main-content">
    <nav class="navbar-custom">
        <div style="display:flex;align-items:center;gap:14px;">
            <button class="admin-hamburger" onclick="toggleSidebar()" style="display:none;background:none;border:none;font-size:20px;cursor:pointer;color:var(--text-dark);">
                <i class="fas fa-bars"></i>
            </button>
            <span class="navbar-brand">用户管理</span>
        </div>
        <div class="d-flex align-items-center gap-3">
            <div class="dropdown">
                <a href="#" class="d-flex align-items-center text-decoration-none dropdown-toggle" id="userDropdown" data-bs-toggle="dropdown"
                   style="color:var(--text-dark);font-weight:500;">
                    <img src="https://ui-avatars.com/api/?name=<%= adminUser.getRealName() != null ? adminUser.getRealName() : "Admin" %>&background=FF6B35&color=fff"
                         alt="管理员" width="32" height="32" class="rounded-circle me-2" style="border:2px solid white;box-shadow:var(--shadow-sm);">
                    <span><%= adminUser.getRealName() != null ? adminUser.getRealName() : "管理员" %></span>
                </a>
                <ul class="dropdown-menu dropdown-menu-end">
                    <li><a class="dropdown-item" href="login?action=logout"><i class="fas fa-sign-out-alt me-2"></i> 退出登录</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="table-container-admin animate-fade-in-up">
        <div class="table-responsive">
            <table class="table table-hover">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>用户名</th>
                    <th>真实姓名</th>
                    <th>学号</th>
                    <th>手机号</th>
                    <th>邮箱</th>
                    <th>用户类型</th>
                    <th>注册时间</th>
                </tr>
                </thead>
                <tbody>
<%
if (users != null && !users.isEmpty()) {
    for (User user : users) {
%>
                <tr>
                    <td><%= user.getId() %></td>
                    <td><%= user.getUsername() %></td>
                    <td><%= user.getRealName() %></td>
                    <td><%= user.getStudentId() %></td>
                    <td><%= user.getPhone() != null ? user.getPhone() : "未设置" %></td>
                    <td><%= user.getEmail() != null ? user.getEmail() : "未设置" %></td>
                    <td>
                        <span class="badge rounded-pill <%= "admin".equals(user.getUserType()) ? "bg-danger" : "bg-primary" %>">
                            <%= "admin".equals(user.getUserType()) ? "管理员" : "学生" %>
                        </span>
                    </td>
                    <td><%= user.getCreateTime() %></td>
                </tr>
<%
    }
} else {
%>
                <tr>
                    <td colspan="8" style="text-align:center;padding:40px;color:var(--text-secondary);">暂无用户数据</td>
                </tr>
<%
}
%>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="js/main.js"></script>
<script>
function toggleSidebar() {
    document.getElementById('adminSidebar').classList.toggle('open');
}
</script>
</body>
</html>
