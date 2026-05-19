<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.fengwei.ticket.entity.User" %>
<%
    User adminUser = (User) session.getAttribute("user");
    if (adminUser == null || !"admin".equals(adminUser.getUserType())) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>添加演出 - 管理员后台</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-color: #ff6b6b;
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

        .form-container {
            background: white;
            border-radius: 10px;
            padding: 30px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
        }

        .btn-primary {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
        }

        .btn-primary:hover {
            background-color: #ff5252;
            border-color: #ff5252;
        }
    </style>
</head>
<body>
<div class="sidebar">
    <div class="sidebar-header">
        <h4 class="text-center">脱口秀票务</h4>
        <p class="text-center text-muted mb-0">管理员后台</p>
    </div>

    <ul class="sidebar-menu">
        <li><a href="admin"><i class="fas fa-tachometer-alt"></i> 控制面板</a></li>
        <li><a href="admin?action=shows" class="active"><i class="fas fa-microphone"></i> 演出管理</a></li>
        <li><a href="admin?action=orders"><i class="fas fa-ticket-alt"></i> 订单管理</a></li>
        <li><a href="admin?action=refunds"><i class="fas fa-undo"></i> 退票管理</a></li>
        <li><a href="admin?action=users"><i class="fas fa-users"></i> 用户管理</a></li>
        <li><a href="shows"><i class="fas fa-home"></i> 返回前台</a></li>
        <li><a href="login?action=logout"><i class="fas fa-sign-out-alt"></i> 退出登录</a></li>
    </ul>
</div>

<div class="main-content">
    <nav class="navbar navbar-expand-lg navbar-light navbar-custom">
        <div class="container-fluid">
            <span class="navbar-brand mb-0 h1">添加脱口秀演出</span>

            <div class="d-flex">
                <div class="dropdown">
                    <a href="#" class="d-flex align-items-center text-decoration-none dropdown-toggle" id="userDropdown" data-bs-toggle="dropdown">
                        <img src="https://ui-avatars.com/api/?name=<%= adminUser.getRealName() != null ? adminUser.getRealName() : "Admin" %>&background=ff6b6b&color=fff"
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

    <div class="form-container">
        <form action="admin" method="post">
            <input type="hidden" name="action" value="addShow">

            <div class="row">
                <div class="col-md-6 mb-3">
                    <label class="form-label">演出标题 *</label>
                    <input type="text" class="form-control" name="title" required>
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label">主演</label>
                    <input type="text" class="form-control" name="performer" placeholder="例如：李诞、池子">
                </div>
            </div>

            <div class="row">
                <div class="col-md-6 mb-3">
                    <label class="form-label">城市 *</label>
                    <input type="text" class="form-control" name="city" required>
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label">场馆 *</label>
                    <input type="text" class="form-control" name="venue" required>
                </div>
            </div>

            <div class="row">
                <div class="col-md-6 mb-3">
                    <label class="form-label">演出时间 *</label>
                    <input type="datetime-local" class="form-control" name="showTime" required>
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label">演出时长（分钟）</label>
                    <input type="number" class="form-control" name="duration" value="90">
                </div>
            </div>

            <div class="row">
                <div class="col-md-4 mb-3">
                    <label class="form-label">票价（元）*</label>
                    <input type="number" class="form-control" name="price" step="0.01" required>
                </div>
                <div class="col-md-4 mb-3">
                    <label class="form-label">总票数 *</label>
                    <input type="number" class="form-control" name="totalTickets" required>
                </div>
                <div class="col-md-4 mb-3">
                    <label class="form-label">状态</label>
                    <select class="form-control" name="status">
                        <option value="upcoming">即将开始</option>
                        <option value="ongoing">进行中</option>
                        <option value="ended">已结束</option>
                    </select>
                </div>
            </div>

            <div class="mb-3">
                <label class="form-label">海报图片URL</label>
                <input type="url" class="form-control" name="imageUrl" placeholder="https://example.com/image.jpg">
            </div>

            <div class="mb-3">
                <label class="form-label">演出简介</label>
                <textarea class="form-control" name="description" rows="4" placeholder="请输入演出简介..."></textarea>
            </div>

            <div class="d-flex justify-content-end gap-2">
                <a href="admin?action=shows" class="btn btn-secondary">取消</a>
                <button type="submit" class="btn btn-primary">添加演出</button>
            </div>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
