<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.fengwei.ticket.entity.Order" %>
<%@ page import="com.fengwei.ticket.entity.User" %>
<%@ page import="java.util.List" %>
<%
  // 检查管理员权限
  User adminUser = (User) session.getAttribute("user");
  if (adminUser == null || !"admin".equals(adminUser.getUserType())) {
    response.sendRedirect("login.jsp");
    return;
  }

  Integer totalUsers = (Integer) request.getAttribute("totalUsers");
  Integer totalConcerts = (Integer) request.getAttribute("totalConcerts");
  Integer totalOrders = (Integer) request.getAttribute("totalOrders");
  Double totalRevenue = (Double) request.getAttribute("totalRevenue");
  List<Order> recentOrders = (List<Order>) request.getAttribute("recentOrders");
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>锋味汉堡票务系统 - 管理员后台</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
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

    .stat-card {
      border-radius: 10px;
      overflow: hidden;
      margin-bottom: 20px;
      transition: transform 0.3s;
      border: none;
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    }

    .stat-card:hover {
      transform: translateY(-5px);
    }

    .stat-icon {
      font-size: 2.5rem;
      opacity: 0.7;
      float: right;
    }

    .dashboard-section {
      background: white;
      border-radius: 10px;
      padding: 25px;
      margin-bottom: 25px;
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
    }

    .navbar-custom {
      background-color: white;
      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
      margin-bottom: 20px;
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
    <li><a href="admin" class="active"><i class="fas fa-tachometer-alt"></i> 控制面板</a></li>
    <li><a href="admin?action=concerts"><i class="fas fa-music"></i> 演唱会管理</a></li>
    <li><a href="admin?action=orders"><i class="fas fa-ticket-alt"></i> 订单管理</a></li>
    <li><a href="admin?action=users"><i class="fas fa-users"></i> 用户管理</a></li>
    <li><a href="concerts"><i class="fas fa-home"></i> 返回前台</a></li>
    <li><a href="login?action=logout"><i class="fas fa-sign-out-alt"></i> 退出登录</a></li>
  </ul>
</div>

<!-- 主内容区 -->
<div class="main-content">
  <!-- 顶部导航 -->
  <nav class="navbar navbar-expand-lg navbar-light navbar-custom">
    <div class="container-fluid">
      <span class="navbar-brand mb-0 h1">管理员控制面板</span>

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

  <!-- 统计卡片 -->
  <div class="row">
    <div class="col-md-3">
      <div class="card stat-card text-white bg-primary">
        <div class="card-body">
          <h5 class="card-title">总用户数</h5>
          <h2 class="card-text"><%= totalUsers != null ? totalUsers : 0 %></h2>
          <i class="fas fa-users stat-icon"></i>
        </div>
      </div>
    </div>
    <div class="col-md-3">
      <div class="card stat-card text-white bg-success">
        <div class="card-body">
          <h5 class="card-title">总演唱会</h5>
          <h2 class="card-text"><%= totalConcerts != null ? totalConcerts : 0 %></h2>
          <i class="fas fa-music stat-icon"></i>
        </div>
      </div>
    </div>
    <div class="col-md-3">
      <div class="card stat-card text-white bg-warning">
        <div class="card-body">
          <h5 class="card-title">总订单数</h5>
          <h2 class="card-text"><%= totalOrders != null ? totalOrders : 0 %></h2>
          <i class="fas fa-ticket-alt stat-icon"></i>
        </div>
      </div>
    </div>
    <div class="col-md-3">
      <div class="card stat-card text-white bg-info">
        <div class="card-body">
          <h5 class="card-title">总销售额</h5>
          <h2 class="card-text">¥ <%= totalRevenue != null ? String.format("%.2f", totalRevenue) : "0.00" %></h2>
          <i class="fas fa-yen-sign stat-icon"></i>
        </div>
      </div>
    </div>
  </div>

  <!-- 最近订单 -->
  <div class="row">
    <div class="col-12">
      <div class="dashboard-section">
        <h4>最近订单</h4>
        <div class="table-responsive">
          <table class="table table-hover">
            <thead>
            <tr>
              <th>订单号</th>
              <th>观众姓名</th>
              <th>演唱会</th>
              <th>数量</th>
              <th>金额</th>
              <th>状态</th>
              <th>下单时间</th>
            </tr>
            </thead>
            <tbody>
            <% if (recentOrders != null && !recentOrders.isEmpty()) { %>
            <% for (Order order : recentOrders) { %>
            <tr>
              <td><%= order.getOrderNumber() %></td>
              <td><%= order.getSpectatorName() %></td>
              <td>演唱会ID: <%= order.getConcertId() %></td>
              <td><%= order.getQuantity() %></td>
              <td>¥ <%= String.format("%.2f", order.getTotalAmount()) %></td>
              <td>
                                            <span class="badge bg-<%= "SUCCESS".equals(order.getStatus()) ? "success" : "warning" %>">
                                                <%= "SUCCESS".equals(order.getStatus()) ? "已完成" : "待支付" %>
                                            </span>
              </td>
              <td><%= order.getCreateTime() %></td>
            </tr>
            <% } %>
            <% } else { %>
            <tr>
              <td colspan="7" class="text-center">暂无订单数据</td>
            </tr>
            <% } %>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>