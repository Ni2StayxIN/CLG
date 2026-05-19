<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.fengwei.ticket.entity.Concert" %>
<%@ page import="com.fengwei.ticket.entity.User" %>
<%@ page import="java.util.List" %>
<%
    User adminUser = (User) session.getAttribute("user");
    if (adminUser == null || !"admin".equals(adminUser.getUserType())) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Concert> concerts = (List<Concert>) request.getAttribute("concerts");
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>演唱会管理 - 管理员后台</title>
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

        .concert-image-thumb {
            width: 60px;
            height: 40px;
            object-fit: cover;
            border-radius: 4px;
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
        <li><a href="admin?action=concerts" class="active"><i class="fas fa-music"></i> 演唱会管理</a></li>
        <li><a href="admin?action=orders"><i class="fas fa-ticket-alt"></i> 订单管理</a></li>
        <li><a href="admin?action=users"><i class="fas fa-users"></i> 用户管理</a></li>
        <li><a href="concerts"><i class="fas fa-home"></i> 返回前台</a></li>
        <li><a href="login?action=logout"><i class="fas fa-sign-out-alt"></i> 退出登录</a></li>
    </ul>
</div>

<div class="main-content">
    <!-- 顶部导航 -->
    <nav class="navbar navbar-expand-lg navbar-light navbar-custom">
        <div class="container-fluid">
            <span class="navbar-brand mb-0 h1">演唱会管理</span>

            <div class="d-flex gap-2">
                <a href="admin-concert-add.jsp" class="btn btn-primary">
                    <i class="fas fa-plus"></i> 添加演唱会
                </a>
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
                    <th>ID</th>
                    <th>海报</th>
                    <th>演唱会标题</th>
                    <th>城市</th>
                    <th>场馆</th>
                    <th>时间</th>
                    <th>票价</th>
                    <th>余票</th>
                    <th>状态</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <% if (concerts != null && !concerts.isEmpty()) { %>
                <% for (Concert concert : concerts) { %>
                <tr>
                    <td><%= concert.getId() %></td>
                    <td>
                        <% if (concert.getImageUrl() != null && !concert.getImageUrl().isEmpty()) { %>
                        <img src="<%= concert.getImageUrl() %>" class="concert-image-thumb" alt="演唱会海报">
                        <% } else { %>
                        <div class="concert-image-thumb bg-light d-flex align-items-center justify-content-center">
                            <i class="fas fa-music text-muted"></i>
                        </div>
                        <% } %>
                    </td>
                    <td><%= concert.getTitle() %></td>
                    <td><%= concert.getCity() %></td>
                    <td><%= concert.getVenue() %></td>
                    <td><%= concert.getConcertTime() %></td>
                    <td>¥ <%= String.format("%.2f", concert.getPrice()) %></td>
                    <td><%= concert.getAvailableTickets() %> / <%= concert.getTotalTickets() %></td>
                    <td>
                                    <span class="badge bg-<%= "ON_SALE".equals(concert.getStatus()) ? "success" : "secondary" %>">
                                        <%= "ON_SALE".equals(concert.getStatus()) ? "售票中" : "已结束" %>
                                    </span>
                    </td>
                    <td>
                        <button class="btn btn-sm btn-outline-primary"><i class="fas fa-edit"></i></button>
                        <button class="btn btn-sm btn-outline-danger" onclick="deleteConcert(<%= concert.getId() %>)"><i class="fas fa-trash"></i></button>
                        <form id="delete-form-<%= concert.getId() %>" method="post" action="admin">
                            <input type="hidden" name="action" value="deleteConcert">
                            <input type="hidden" name="id" value="<%= concert.getId() %>">
                        </form>
                    </td>
                </tr>
                <% } %>
                <% } else { %>
                <tr>
                    <td colspan="10" class="text-center">暂无演唱会数据</td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function deleteConcert(concertId) {
        if (confirm('确定要删除这场演唱会吗？此操作不可恢复！')) {
            // 提交对应的表单
            document.getElementById('delete-form-' + concertId).submit();
        }
    }
</script>
</body>
</html>