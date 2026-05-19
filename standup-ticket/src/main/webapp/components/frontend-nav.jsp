<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.fengwei.ticket.entity.User" %>
<%
    User user = (User) session.getAttribute("user");
    String activeNav = request.getParameter("active") != null ? request.getParameter("active") : "home";
%>
<nav class="navbar">
    <div class="container-fluid" style="max-width:1200px;padding:0 24px;">
        <a class="navbar-brand" href="shows" style="display:flex;align-items:center;gap:10px;font-size:20px;">
            🎭 脱口秀票务
        </a>
        <div class="nav-links">
            <a href="shows" class="nav-link <%= "home".equals(activeNav) ? "active" : "" %>">🏠 首页</a>
            <% if (user == null) { %>
            <a href="login.jsp" class="nav-link <%= "login".equals(activeNav) ? "active" : "" %>">👤 登录</a>
            <a href="register.jsp" class="btn-primary-custom nav-btn">注册</a>
            <% } else { %>
            <a href="orders.jsp" class="nav-link <%= "orders".equals(activeNav) ? "active" : "" %>">🎫 我的订单</a>
            <span style="color:var(--text-secondary);font-size:13px;margin:0 8px;">|</span>
            <span style="font-weight:600;font-size:14px;color:var(--primary-start);">👋 <%= user.getRealName() != null ? user.getRealName() : "用户" %></span>
            <a href="login?action=logout" class="nav-link" style="margin-left:8px;">退出</a>
            <% } %>
        </div>
        <button class="hamburger"><i class="fas fa-bars"></i></button>
    </div>
</nav>