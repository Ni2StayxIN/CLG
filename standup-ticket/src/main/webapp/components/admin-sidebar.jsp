<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.fengwei.ticket.entity.User" %>
<%
    User adminUser = (User) session.getAttribute("user");
    String activePage = request.getParameter("active") != null ? request.getParameter("active") : "dashboard";
%>
<div class="sidebar" id="adminSidebar">
    <div class="sidebar-header">
        <h4>🎭 脱口秀票务</h4>
        <p>管理员控制台</p>
    </div>

    <ul class="sidebar-menu">
        <li><a href="admin" class="<%= "dashboard".equals(activePage) ? "active" : "" %>"><i class="fas fa-tachometer-alt"></i> 控制面板</a></li>
        <li><a href="admin?action=shows" class="<%= "shows".equals(activePage) ? "active" : "" %>"><i class="fas fa-microphone"></i> 演出管理</a></li>
        <li><a href="admin?action=orders" class="<%= "orders".equals(activePage) ? "active" : "" %>"><i class="fas fa-ticket-alt"></i> 订单管理</a></li>
        <li><a href="admin?action=refunds" class="<%= "refunds".equals(activePage) ? "active" : "" %>"><i class="fas fa-undo"></i> 退票管理</a></li>
        <li><a href="admin?action=users" class="<%= "users".equals(activePage) ? "active" : "" %>"><i class="fas fa-users"></i> 用户管理</a></li>
        <li style="margin-top: 16px; border-top: 1px solid var(--admin-sidebar-border); padding-top: 12px;">
            <a href="shows"><i class="fas fa-home"></i> 返回前台</a>
        </li>
        <li><a href="login?action=logout"><i class="fas fa-sign-out-alt"></i> 退出登录</a></li>
    </ul>

    <div class="sidebar-footer">
        <div style="font-size: 11px; color: var(--text-secondary); text-align: center;">
            © 2025 脱口秀票务系统
        </div>
    </div>
</div>