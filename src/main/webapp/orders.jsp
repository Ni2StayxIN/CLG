<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>我的订单 - 演唱会门票系统</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "PingFang SC", "Microsoft YaHei", sans-serif;
            background-color: #f5f5f5;
            color: #333;
            line-height: 1.6;
        }
        .header {
            background-color: white;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            padding: 15px 0;
            position: sticky;
            top: 0;
            z-index: 1000;
        }
        .header-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: nowrap;
        }
        .logo {
            margin-right: 40px;
        }
        .logo h1 {
            margin: 0;
            font-size: 24px;
            color: #ff4757;
        }
        .nav-links {
            flex: 1;
            display: flex;
            justify-content: center;
        }
        .nav-links a {
            color: #333;
            text-decoration: none;
            margin: 0 12px;
            padding: 10px 20px;
            border-radius: 5px;
            font-size: 16px;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        .nav-links a:hover, .nav-links a.active {
            color: #ff4757;
            background-color: #fff5f5;
            transform: translateY(-1px);
        }
        .user-info {
            margin-left: 40px;
            display: flex;
            align-items: center;
            gap: 15px;
        }
        .user-info span {
            font-weight: bold;
        }
        .logout-btn {
            background-color: #ff4757;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .logout-btn:hover {
            background-color: #e83241;
        }
        .main-container {
            max-width: 1200px;
            margin: 30px auto;
            padding: 0 20px;
        }
        .page-header {
            margin-bottom: 20px;
        }
        .page-title {
            color: #333;
            font-size: 28px;
            font-weight: bold;
        }
        .table-container {
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            overflow: hidden;
        }
        .table {
            width: 100%;
            border-collapse: collapse;
        }
        .table th {
            background-color: #f8f9fa;
            color: #555;
            font-weight: 600;
            text-align: center;
            padding: 15px 12px;
            border-bottom: 2px solid #dee2e6;
            font-size: 14px;
        }
        .table td {
            padding: 15px 12px;
            border-bottom: 1px solid #dee2e6;
            text-align: center;
            vertical-align: middle;
            font-size: 14px;
        }
        .table tbody tr:hover {
            background-color: #f8f9fa;
        }
        .table tbody tr:last-child td {
            border-bottom: none;
        }
        .order-id {
            font-weight: bold;
            color: #ff4757;
        }
        .order-status {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: bold;
            display: inline-flex;
            align-items: center;
            gap: 4px;
        }
        .status-pending {
            background-color: #fff3cd;
            color: #856404;
        }
        .status-confirmed {
            background-color: #d4edda;
            color: #155724;
        }
        .status-cancelled {
            background-color: #f8d7da;
            color: #721c24;
        }
        .concert-name {
            font-weight: 600;
            color: #333;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            max-width: 150px;
        }
        .order-price {
            font-weight: bold;
            color: #ff4757;
            font-size: 16px;
        }
        .action-btn {
            padding: 6px 16px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
            font-size: 12px;
            font-weight: 500;
            transition: all 0.3s;
            display: inline-flex;
            align-items: center;
            gap: 4px;
        }
        .btn-cancel {
            background-color: #ff4757;
            color: white;
        }
        .btn-cancel:hover {
            background-color: #e83241;
            color: white;
        }
        .btn-disabled {
            cursor: default;
            opacity: 0.7;
        }
        .btn-confirmed {
            background-color: #28a745;
            color: white;
        }
        .btn-cancelled {
            background-color: #6c757d;
            color: white;
        }
        .empty-message {
            text-align: center;
            padding: 80px 20px;
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            color: #999;
        }
        .empty-message h3 {
            margin-bottom: 10px;
            color: #666;
        }
        .empty-message p {
            font-size: 16px;
        }
        .btn-browse {
            margin-top: 20px;
            background-color: #ff4757;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 25px;
            text-decoration: none;
            font-weight: bold;
            transition: transform 0.3s;
        }
        .btn-browse:hover {
            transform: scale(1.05);
            background-color: #e83241;
            color: white;
        }
        /* 响应式设计优化 */
        @media (max-width: 1024px) {
            .header-container {
                padding: 0 15px;
            }
            .logo {
                margin-right: 20px;
            }
            .logo h1 {
                font-size: 20px;
            }
            .nav-links a {
                margin: 0 8px;
                padding: 8px 16px;
                font-size: 14px;
            }
            .user-info {
                margin-left: 20px;
            }
        }
        
        @media (max-width: 768px) {
            .header-container {
                flex-wrap: wrap;
                justify-content: center;
                gap: 15px;
                padding: 10px 15px;
            }
            .logo {
                margin-right: 0;
                order: 1;
            }
            .nav-links {
                order: 3;
                width: 100%;
                justify-content: center;
                margin: 10px 0;
            }
            .user-info {
                margin-left: 0;
                order: 2;
            }
            .table-container {
                overflow-x: auto;
            }
            .table {
                min-width: 650px;
            }
            .concert-name {
                max-width: 100px;
            }
        }
    </style>
</head>
<body>
    <header class="header">
        <div class="header-container">
            <div class="logo">
                <h1>🍔 锋味汉堡演唱会</h1>
            </div>
            <div class="nav-links">
                <a href="concerts" class="nav-link">演唱会</a>
                <a href="concerts?filter=hot" class="nav-link">热门推荐</a>
                <a href="concerts?filter=soon" class="nav-link">即将开始</a>
                <a href="orders" class="nav-link active">我的订单</a>
            </div>
            <div class="user-info">
                <span>欢迎, ${sessionScope.username}</span>
                <a href="login?action=logout" class="logout-btn">退出</a>
            </div>
        </div>
    </header>
    
    <div class="main-container">
        <div class="page-header">
            <h2 class="page-title">我的订单</h2>
        </div>
        
        <!-- 错误信息显示 -->
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <strong>加载失败:</strong> ${errorMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>
        
        <c:choose>
            <c:when test="${empty orderList}">
                <div class="empty-message">
                    <h3><i class="fas fa-ticket-alt"></i> 暂无订单</h3>
                    <p>您还没有任何订单记录，快去浏览精彩的演唱会吧！</p>
                    <a href="concerts" class="btn-browse">浏览演唱会</a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="table-container">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>订单号</th>
                                <th>演唱会名称</th>
                                <th>时间</th>
                                <th>地点</th>
                                <th>票数</th>
                                <th>总价</th>
                                <th>状态</th>
                                <th>操作</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="order" items="${orderList}">
                                <tr>
                                    <td><span class="order-id">${order.orderId}</span></td>
                                    <td><span class="concert-name">${order.concertName}</span></td>
                                    <td>${order.date} ${order.time}</td>
                                    <td>${order.venue}</td>
                                    <td>${order.quantity}张</td>
                                    <td><span class="order-price">¥${order.totalAmount}</span></td>
                                    <td>
                                        <span class="order-status 
                                            <c:choose>
                                                <c:when test="${order.status == 'pending'}">status-pending</c:when>
                                                <c:when test="${order.status == 'confirmed'}">status-confirmed</c:when>
                                                <c:when test="${order.status == 'cancelled'}">status-cancelled</c:when>
                                            </c:choose>">
                                            <i class="fas 
                                                <c:choose>
                                                    <c:when test="${order.status == 'pending'}">fa-clock</c:when>
                                                    <c:when test="${order.status == 'confirmed'}">fa-check-circle</c:when>
                                                    <c:when test="${order.status == 'cancelled'}">fa-times-circle</c:when>
                                                </c:choose>"></i>
                                            <c:choose>
                                                <c:when test="${order.status == 'pending'}">待支付</c:when>
                                                <c:when test="${order.status == 'confirmed'}">已确认</c:when>
                                                <c:when test="${order.status == 'cancelled'}">已取消</c:when>
                                            </c:choose>
                                        </span>
                                    </td>
                                    <td>
                                        <c:if test="${order.status == 'pending'}">
                                            <a href="cancel-order?id=${order.orderId}" class="action-btn btn-cancel" onclick="return confirm('确定要取消订单吗？');">
                                                <i class="fas fa-times"></i> 取消订单
                                            </a>
                                        </c:if>
                                        <c:if test="${order.status == 'confirmed'}">
                                            <button class="action-btn btn-confirmed btn-disabled">
                                                <i class="fas fa-check"></i> 已确认
                                            </button>
                                        </c:if>
                                        <c:if test="${order.status == 'cancelled'}">
                                            <button class="action-btn btn-cancelled btn-disabled">
                                                <i class="fas fa-ban"></i> 已取消
                                            </button>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>