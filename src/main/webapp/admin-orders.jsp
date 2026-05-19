<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.fengwei.ticket.entity.Order" %>
<%@ page import="com.fengwei.ticket.entity.User" %>
<%@ page import="java.util.List" %>
<%
  User adminUser = (User) session.getAttribute("user");
  if (adminUser == null || !"admin".equals(adminUser.getUserType())) {
    response.sendRedirect("login.jsp");
    return;
  }

  List<Order> orders = (List<Order>) request.getAttribute("orders");
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>订单管理 - 管理员后台</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome@6.0.0/css/all.min.css" rel="stylesheet">
  <style>
    :root {
      --primary-color: #dc3545;
      --sidebar-width: 250px;
    }

    body {
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background-color: #f8f9fa;
    }

    .sidebar {
      position: fixed;
      top: 0;
      left: 0;
      width: var(--sidebar-width);
      height: 100vh;
      background: linear-gradient(135deg, #2c3e50, #34495e);
      color: white;
      z-index: 1000;
    }

    .sidebar-header {
      padding: 20px;
      background-color: rgba(0, 0, 0, 0.2);
      border-bottom: 1px solid rgba(255, 255, 255, 0.1);
    }

    .sidebar-menu {
      padding: 0;
      list-style: none;
    }

    .sidebar-menu li {
      margin: 5px 0;
    }

    .sidebar-menu a {
      color: #b3b3b3;
      text-decoration: none;
      padding: 12px 20px;
      display: block;
      transition: all 0.3s;
      border-left: 3px solid transparent;
    }

    .sidebar-menu a:hover, .sidebar-menu a.active {
      color: white;
      background-color: rgba(255, 255, 255, 0.1);
      border-left: 3px solid var(--primary-color);
    }

    .main-content {
      margin-left: var(--sidebar-width);
      padding: 20px;
    }

    .navbar-custom {
      background-color: white;
      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
      margin-bottom: 20px;
    }

    .table-container {
      background: white;
      border-radius: 10px;
      overflow: hidden;
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
    }
  </style>
</head>
<body>
<!-- 侧边栏 -->
<div class="sidebar">
  <div class="sidebar-header">
    <h4 class="text-center">锋味汉堡票务</h4>
    <p class="text-center text-muted mb-0">管理员后台</p>
  </div>

  <ul class="sidebar-menu">
    <li><a href="admin"><i class="fas fa-tachometer-alt"></i> 控制面板</a></li>
    <li><a href="admin?action=concerts"><i class="fas fa-music"></i> 演唱会管理</a></li>
    <li><a href="admin?action=orders" class="active"><i class="fas fa-ticket-alt"></i> 订单管理</a></li>
    <li><a href="admin?action=users"><i class="fas fa-users"></i> 用户管理</a></li>
    <li><a href="concerts"><i class="fas fa-home"></i> 返回前台</a></li>
    <li><a href="login?action=logout"><i class="fas fa-sign-out-alt"></i> 退出登录</a></li>
  </ul>
</div>

<div class="main-content">
  <!-- 顶部导航 -->
  <nav class="navbar navbar-expand-lg navbar-light navbar-custom">
    <div class="container-fluid">
      <span class="navbar-brand mb-0 h1">订单管理</span>

      <div class="d-flex">
        <div class="dropdown">
          <a href="#" class="d-flex align-items-center text-decoration-none dropdown-toggle" id="userDropdown" data-bs-toggle="dropdown">
            <img src="https://ui-avatars.com/api/?name=<%= adminUser.getRealName() != null ? adminUser.getRealName() : "Admin" %>&background=dc3545&color=fff"
                 alt="管理员" width="32" height="32" class="rounded-circle me-2">
            <span><%= adminUser.getRealName() != null ? adminUser.getRealName() : "管理员" %></span>
          </a>
          <ul class="dropdown-menu dropdown-menu-end">
            <li><a class="dropdown-item" href="login?action=logout"><i class="fas fa-sign-out-alt me-2"></i> 退出登录</a></li>
          </ul>
        </div>
      </div>
    </div>
  </nav>

  <div class="table-container">
    <div class="table-responsive">
      <table class="table table-hover">
        <thead>
        <tr>
          <th>订单号</th>
          <th>观众姓名</th>
          <th>学号</th>
          <th>演唱会ID</th>
          <th>数量</th>
          <th>总金额</th>
          <th>状态</th>
          <th>下单时间</th>
          <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <% if (orders != null && !orders.isEmpty()) { %>
        <% for (Order order : orders) { %>
        <tr>
          <td><%= order.getOrderNumber() %></td>
          <td><%= order.getSpectatorName() %></td>
          <td><%= order.getSpectatorStudentId() %></td>
          <td><%= order.getConcertId() %></td>
          <td><%= order.getQuantity() %></td>
          <td>¥ <%= String.format("%.2f", order.getTotalAmount()) %></td>
          <td>
                                    <span class="badge bg-<%= "SUCCESS".equals(order.getStatus()) ? "success" : "warning" %>">
                                        <%= "SUCCESS".equals(order.getStatus()) ? "已完成" : "待支付" %>
                                    </span>
          </td>
          <td><%= order.getCreateTime() %></td>
          <td>
            <button class="btn btn-sm btn-outline-info"><i class="fas fa-eye"></i></button>
            <button class="btn btn-sm btn-outline-danger"><i class="fas fa-times"></i></button>
          </td>
        </tr>
        <% } %>
        <% } else { %>
        <tr>
          <td colspan="9" class="text-center">暂无订单数据</td>
        </tr>
        <% } %>
        </tbody>
      </table>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>