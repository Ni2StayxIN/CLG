<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>退票记录 - 脱口秀门票预订系统</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="css/main.css" rel="stylesheet">
    <link href="css/animations.css" rel="stylesheet">
</head>
<body>
<header class="navbar">
    <div class="nav-container">
        <div class="logo"><span class="logo-icon">🎤</span><span style="font-size:20px;">脱口秀门票预订</span></div>
        <div class="hamburger"><span></span><span></span><span></span></div>
        <div class="nav-links">
            <a href="shows" class="nav-link">脱口秀演出</a>
            <a href="shows?filter=hot" class="nav-link">热门推荐</a>
            <a href="shows?filter=soon" class="nav-link">即将开始</a>
            <a href="orders" class="nav-link">我的订单</a>
            <a href="refunds" class="nav-link active">退票记录</a>
        </div>
        <div class="user-section">
            <div class="user-info"><div class="user-avatar">${sessionScope.realName.charAt(0)}</div><span>${sessionScope.realName}</span></div>
            <button class="btn-primary-custom logout-btn" onclick="doLogout()" style="padding:6px 14px;font-size:12px;">退出</button>
        </div>
    </div>
</header>

<div class="main-container">
    <div class="page-header animate-fade-in-up"><h2 class="page-title">↩️ 退票记录</h2></div>

    <c:choose>
        <c:when test="${not empty refundList && refundList.size() > 0}">
            <div class="table-responsive-wrapper stagger">
                <table class="table">
                    <thead><tr>
                        <th>ID</th><th>演出名称</th><th>数量</th><th>退款金额</th><th>退票原因</th><th>状态</th><th>申请时间</th><th>处理时间</th><th>备注</th>
                    </tr></thead>
                    <tbody>
                        <c:forEach var="refund" items="${refundList}">
                        <tr>
                            <td style="font-weight:600;color:var(--text-secondary);">${refund.id}</td>
                            <td style="font-weight:600;">${refund.showName}</td>
                            <td>${refund.quantity}</td>
                            <td><strong style="font-weight:800;background:var(--primary-gradient);-webkit-background-clip:text;-webkit-text-fill-color:transparent;background-clip:text;">¥${refund.refundAmount}</strong></td>
                            <td style="max-width:150px;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;" title="${refund.reason}">${refund.reason}</td>
                            <td>
                                <span class="badge rounded-pill font-weight:700" style="font-size:12px;padding:6px 14px;<c:choose><c:when test="${refund.status=='pending'}">background:linear-gradient(135deg,#fff3cd,#ffeaa7);color:#856404;</c:when><c:when test="${refund.status=='approved'}">background:linear-gradient(135deg,#d4edda,#c8e6c9);color:#155724;</c:when><c:otherwise>background:linear-gradient(135deg,#f8d7da,#f5c6cb);color:#721c24;</c:otherwise></c:choose>">
                                    <c:choose>
                                        <c:when test="${refund.status=='pending'}">⏳ 待审核</c:when>
                                        <c:when test="${refund.status=='approved'}">✅ 已批准</c:when>
                                        <c:otherwise>❌ 已拒绝</c:otherwise>
                                    </c:choose>
                                </span>
                            </td>
                            <td style="font-size:13px;color:var(--text-secondary);">${refund.applyTime}</td>
                            <td style="font-size:13px;color:var(--text-secondary);">${refund.processTime != null ? refund.processTime : '-'}</td>
                            <td style="font-size:13px;color:var(--text-secondary);max-width:100px;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;">${refund.adminRemark != null ? refund.adminRemark : '-'}</td>
                        </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <div class="table-scroll-hint">← 左右滑动查看更多 →</div>
            </div>
        </c:when>
        <c:otherwise>
            <div class="empty-message animate-scale-in" style="text-align:center;padding:70px 20px;background:white;border-radius:var(--radius-md);box-shadow:var(--shadow-sm);">
                <svg viewBox="0 0 200 160" style="width:150px;height:120px;margin-bottom:14px"><circle cx="100" cy="65" r="38" fill="#FDF8F5" stroke="#9B59B6" stroke-width="2"/><path d="M82 65l10 10 22-22" stroke="#9B59B6" stroke-width="3" fill="none" stroke-linecap="round"/><path d="M60 130 h80" stroke="#ddd" stroke-width="2" stroke-linecap="round"/><path d="M75 142 h50" stroke="#ddd" stroke-width="2" stroke-linecap="round"/></svg>
                <h3 style="margin-bottom:8px;color:var(--text-dark);font-weight:700;">暂无退票记录</h3>
                <p style="color:var(--text-secondary);font-size:15px;">您还没有申请过退票</p>
                <a href="orders" class="btn-primary-custom" style="display:inline-block;margin-top:18px;padding:12px 28px;">查看我的订单</a>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<script src="js/main.js"></script>
<script>
function doLogout() { if (confirm('确定要退出登录吗？')) window.location.href='login?action=logout'; }
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
