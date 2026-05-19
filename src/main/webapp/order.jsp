<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <c:choose>
        <c:when test="${not empty order}">
            <title>订单详情 - 演唱会门票系统</title>
        </c:when>
        <c:otherwise>
            <title>🍔 锋味汉堡演唱会 - 确认订单</title>
        </c:otherwise>
    </c:choose>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Microsoft YaHei', sans-serif;
            background: #f8f9fa;
        }
        .header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 20px;
            text-align: center;
            position: relative;
        }
        .order-container {
            max-width: 800px;
            margin: 30px auto;
            padding: 0 20px;
        }
        .order-card {
            background: white;
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }
        .concert-info {
            display: flex;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 1px solid #eee;
        }
        .concert-image {
            width: 200px;
            height: 150px;
            border-radius: 10px;
            margin-right: 20px;
            object-fit: cover;
        }
        .concert-details {
            flex: 1;
        }
        .concert-title {
            color: #333;
            font-size: 20px;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .concert-detail {
            color: #666;
            margin: 5px 0;
        }
        .concert-price {
            color: #e74c3c;
            font-size: 18px;
            font-weight: bold;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #555;
            font-weight: bold;
        }
        .form-group input, .form-group select {
            width: 100%;
            padding: 12px;
            border: 2px solid #ddd;
            border-radius: 8px;
            font-size: 16px;
            transition: border-color 0.3s;
        }
        .form-group input:focus, .form-group select:focus {
            border-color: #667eea;
            outline: none;
        }
        .form-row {
            display: flex;
            gap: 15px;
        }
        .form-row .form-group {
            flex: 1;
        }
        .submit-btn {
            width: 100%;
            padding: 15px;
            background: linear-gradient(135deg, #e74c3c 0%, #c0392b 100%);
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 18px;
            font-weight: bold;
            transition: all 0.3s;
            margin-top: 20px;
        }
        .submit-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 18px rgba(231, 76, 60, 0.4);
        }
        .submit-btn:disabled {
            background: #95a5a6;
            cursor: not-allowed;
            transform: none;
            box-shadow: none;
        }
        .required::after {
            content: " *";
            color: #e74c3c;
        }
        /* 订单详情页面样式 */
        .order-info-section {
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 1px solid #eee;
        }
        .order-info-title {
            color: #333;
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 15px;
        }
        .order-info-item {
            display: flex;
            justify-content: space-between;
            margin: 10px 0;
            padding: 10px;
            background-color: #f9f9f9;
            border-radius: 5px;
        }
        .order-info-label {
            color: #666;
            font-weight: 500;
        }
        .order-info-value {
            color: #333;
            font-weight: bold;
        }
        .back-btn {
            display: inline-block;
            padding: 10px 20px;
            background: #6c757d;
            color: white;
            border: none;
            border-radius: 5px;
            text-decoration: none;
            margin-top: 20px;
            transition: background 0.3s;
        }
        .back-btn:hover {
            background: #5a6268;
            color: white;
        }
        .order-status {
            display: inline-block;
            padding: 5px 15px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: bold;
        }
        .status-pending {
            background-color: #fff3cd;
            color: #856404;
        }
        .status-success {
            background-color: #d4edda;
            color: #155724;
        }
        .status-cancelled {
            background-color: #f8d7da;
            color: #721c24;
        }
    </style>
</head>
<body>
<div class="header">
    <c:choose>
        <c:when test="${not empty order}">
            <h1>订单详情</h1>
        </c:when>
        <c:otherwise>
            <h1>🍔 锋味汉堡演唱会 - 确认订单</h1>
        </c:otherwise>
    </c:choose>
</div>

<div class="order-container">
    <div class="order-card">
        <!-- 订单详情视图 -->
        <c:if test="${not empty order}">
            <!-- 订单状态 -->
            <div class="order-info-section">
                <div class="order-info-title">订单状态</div>
                <div class="order-info-item">
                    <span class="order-info-label">订单号</span>
                    <span class="order-info-value">${order.orderNumber}</span>
                </div>
                <div class="order-info-item">
                    <span class="order-info-label">状态</span>
                    <span class="order-status 
                        <c:choose>
                            <c:when test="${order.status == 'PENDING'}">status-pending</c:when>
                            <c:when test="${order.status == 'SUCCESS'}">status-success</c:when>
                            <c:when test="${order.status == 'CANCELLED'}">status-cancelled</c:when>
                            <c:otherwise>status-pending</c:otherwise>
                        </c:choose>">
                        <c:choose>
                            <c:when test="${order.status == 'PENDING'}">待支付</c:when>
                            <c:when test="${order.status == 'SUCCESS'}">已完成</c:when>
                            <c:when test="${order.status == 'CANCELLED'}">已取消</c:when>
                            <c:otherwise>未知状态</c:otherwise>
                        </c:choose>
                    </span>
                </div>
                <div class="order-info-item">
                    <span class="order-info-label">下单时间</span>
                    <span class="order-info-value">${order.createTime}</span>
                </div>
            </div>

            <!-- 演唱会信息 -->
            <div class="concert-info">
                <img src="https://picsum.photos/400/300" alt="${order.concertName}" class="concert-image">
                <div class="concert-details">
                    <div class="concert-title">${order.concertName}</div>
                    <div class="concert-detail">🏟️ 场馆：${order.venue}</div>
                    <div class="concert-detail">⏰ 时间：${order.date}</div>
                    <div class="concert-detail">🎫 数量：${order.quantity}张</div>
                    <div class="concert-price">💰 总价：¥${order.totalAmount}</div>
                </div>
            </div>

            <!-- 观众信息 -->
            <div class="order-info-section">
                <div class="order-info-title">观众信息</div>
                <div class="order-info-item">
                    <span class="order-info-label">观众姓名</span>
                    <span class="order-info-value">${order.spectatorName}</span>
                </div>
                <div class="order-info-item">
                    <span class="order-info-label">学号</span>
                    <span class="order-info-value">${order.spectatorStudentId}</span>
                </div>
                <div class="order-info-item">
                    <span class="order-info-label">联系电话</span>
                    <span class="order-info-value">${order.spectatorPhone}</span>
                </div>
                <div class="order-info-item">
                    <span class="order-info-label">座位信息</span>
                    <span class="order-info-value">${order.seatInfo}</span>
                </div>
            </div>

            <a href="orders" class="back-btn">
                <i class="fas fa-arrow-left"></i> 返回订单列表
            </a>
        </c:if>

        <!-- 订单创建表单 -->
        <c:if test="${not empty concert && empty order}">
            <div class="concert-info">
                <img src="${concert.imageUrl}" alt="${concert.title}" class="concert-image">
                <div class="concert-details">
                    <div class="concert-title">${concert.title}</div>
                    <div class="concert-detail">📍 城市：${concert.city}</div>
                    <div class="concert-detail">🏟️ 场馆：${concert.venue}</div>
                    <div class="concert-detail">⏰ 时间：${concert.concertTime}</div>
                    <div class="concert-price">💰 票价：¥${concert.price}</div>
                </div>
            </div>

            <form id="orderForm">
                <input type="hidden" name="concertId" value="${concert.id}">
                <input type="hidden" name="quantity" value="1">

                <h3 style="margin-bottom: 20px; color: #333;">填写观众信息</h3>

                <div class="form-row">
                    <div class="form-group">
                        <label class="required">👤 观众姓名</label>
                        <input type="text" name="spectatorName" required
                               value="${user.realName}" placeholder="请输入观众真实姓名">
                    </div>
                    <div class="form-group">
                        <label class="required">🎓 观众学号</label>
                        <input type="text" name="spectatorStudentId" required
                               value="${user.studentId}" placeholder="请输入观众学号">
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label>📞 联系电话</label>
                        <input type="tel" name="spectatorPhone"
                               value="${user.phone}" placeholder="请输入联系电话">
                    </div>
                    <div class="form-group">
                        <label>💺 座位偏好</label>
                        <select name="seatInfo">
                            <option value="">随机分配</option>
                            <option value="前排">前排区域</option>
                            <option value="中间">中间区域</option>
                            <option value="后排">后排区域</option>
                            <option value="VIP">VIP区域</option>
                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <label>📋 购票须知</label>
                    <div style="padding: 15px; background: #f8f9fa; border-radius: 8px; font-size: 14px; color: #666;">
                        <p>1. 每人限购1张门票，请确保信息填写准确</p>
                        <p>2. 门票一经售出，概不退换</p>
                        <p>3. 请携带身份证件入场</p>
                        <p>4. 演出前30分钟开始检票，请合理安排时间</p>
                    </div>
                </div>

                <button type="button" class="submit-btn" onclick="submitOrder()">🎟️ 立即支付 ¥${concert.price}</button>
            </form>
        </c:if>
    </div>
</div>

<script>
    function submitOrder() {
        const form = document.getElementById('orderForm');
        const formData = new FormData(form);
        const button = document.querySelector('.submit-btn');

        // 验证必填字段
        const spectatorName = formData.get('spectatorName');
        const spectatorStudentId = formData.get('spectatorStudentId');

        if (!spectatorName || !spectatorStudentId) {
            alert('请填写完整的观众信息');
            return;
        }

        button.textContent = '支付中...';
        button.disabled = true;

        fetch('create-order', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: new URLSearchParams(formData)
        })
            .then(response => response.json())
            .then(result => {
                if (result.success) {
                    alert(result.message);
                    window.location.href = 'concerts';
                } else {
                    alert(result.message);
                    button.textContent = '🎟️ 立即支付 ¥${concert.price}';
                    button.disabled = false;
                }
            })
            .catch(error => {
                alert('网络错误，请重试');
                button.textContent = '🎟️ 立即支付 ¥${concert.price}';
                button.disabled = false;
            });
    }
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>