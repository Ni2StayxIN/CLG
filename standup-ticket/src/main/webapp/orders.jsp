<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>我的订单 - 脱口秀门票预订系统</title>
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
            <a href="orders" class="nav-link active">我的订单</a>
            <a href="refunds" class="nav-link">退票记录</a>
        </div>
        <div class="user-section">
            <div class="user-info"><div class="user-avatar">${sessionScope.realName.charAt(0)}</div><span>${sessionScope.realName}</span></div>
            <button class="btn-primary-custom logout-btn" onclick="doLogout()" style="padding:6px 14px;font-size:12px;">退出</button>
        </div>
    </div>
</header>

<div class="main-container">
    <div class="page-header animate-fade-in-up"><h2 class="page-title">📋 我的订单</h2></div>

    <c:choose>
        <c:when test="${not empty orderList && orderList.size() > 0}">
            <div class="table-responsive-wrapper stagger">
                <table class="table">
                    <thead><tr>
                        <th>订单号</th><th>演出名称</th><th>场馆</th><th>时间</th><th>数量</th><th>金额</th><th>状态</th><th>下单时间</th><th>操作</th>
                    </tr></thead>
                    <tbody>
                        <c:forEach var="order" items="${orderList}">
                        <tr class="order-row" data-order-id="${order.id}" data-show-name="${order.showName}" data-amount="${order.totalAmount}">
                            <td><span class="order-id" style="font-weight:700;color:var(--primary-start);font-size:13px;cursor:pointer;" onclick="toggleOrderDetail(this)">${order.orderNumber} <i class="fas fa-chevron-down" style="font-size:10px;margin-left:4px;"></i></span></td>
                            <td><span class="show-name" style="font-weight:600;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;max-width:140px;display:inline-block;">${order.showName}</span></td>
                            <td>${order.venue}</td>
                            <td>${order.date}</td>
                            <td>${order.quantity}</td>
                            <td><span style="font-weight:800;background:var(--primary-gradient);-webkit-background-clip:text;-webkit-text-fill-color:transparent;background-clip:text;font-size:15px;">¥${order.totalAmount}</span></td>
                            <td>
                                <span class="order-status badge rounded-pill"
                                    style="<c:choose><c:when test="${order.status == 'pending'}">background:linear-gradient(135deg,#fff3cd,#ffeaa7);color:#856404;</c:when><c:when test="${order.status == 'paid'}">background:linear-gradient(135deg,#d4edda,#c8e6c9);color:#155724;</c:when><c:when test="${order.status == 'refunding'}">background:linear-gradient(135deg,#cce5ff,#b3d7ff);color:#004085;</c:when><c:when test="${order.status == 'refunded'}">background:linear-gradient(135deg,#f8d7da,#f5c6cb);color:#721c24;</c:when><c:otherwise>background:#e9ecef;color:#6c757d;</c:otherwise></c:choose>padding:6px 14px;font-size:12px;font-weight:700;">
                                    <c:choose>
                                        <c:when test="${order.status == 'pending'}">⏳ 待支付</c:when>
                                        <c:when test="${order.status == 'paid'}">✅ 已支付</c:when>
                                        <c:when test="${order.status == 'refunding'}">🔄 退票中</c:when>
                                        <c:when test="${order.status == 'refunded'}">↩ 已退款</c:when>
                                        <c:otherwise>已取消</c:otherwise>
                                    </c:choose>
                                </span>
                            </td>
                            <td style="font-size:13px;color:var(--text-secondary);">${order.createTime}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${order.status == 'paid'}">
                                        <button class="admin-btn admin-btn-primary" onclick="openRefundModal(${order.id},'${order.showName}',${order.totalAmount})">🎫 申请退票</button>
                                    </c:when>
                                    <c:when test="${order.status == 'refunding'}">
                                        <span class="admin-btn" style="background:linear-gradient(135deg,#0984e3,#74b9ff);color:white;">退票审核中</span>
                                    </c:when>
                                    <c:when test="${order.status == 'refunded'}">
                                        <span class="admin-btn" style="background:#dfe6e9;color:var(--text-secondary);">已退款</span>
                                    </c:when>
                                    <c:otherwise><span class="admin-btn" style="background:#dfe6e9;color:var(--text-secondary);">-</span></c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                        <tr class="order-detail-row" id="detail-${order.id}" style="display:none">
                            <td colspan="9" style="background:var(--bg-warm);padding:16px 20px;">
                                <div style="display:flex;gap:24px;align-items:flex-start;">
                                    <div style="width:80px;height:60px;border-radius:8px;background:var(--primary-gradient);display:flex;align-items:center;justify-content:center;color:white;font-size:24px;">🎟️</div>
                                    <div style="flex:1;">
                                        <div style="display:grid;grid-template-columns:1fr 1fr;gap:8px;font-size:13px;">
                                            <div><strong>订单号：</strong><code style="background:rgba(255,107,53,0.1);color:var(--primary-start);padding:2px 6px;border-radius:4px;">${order.orderNumber}</code></div>
                                            <div><strong>观众姓名：</strong>${order.spectatorName}</div>
                                            <div><strong>演出名称：</strong>${order.showName}</div>
                                            <div><strong>购票数量：</strong>${order.quantity} 张</div>
                                            <div><strong>订单金额：</strong><strong style="color:var(--primary-start);">¥${order.totalAmount}</strong></div>
                                            <div><strong>下单时间：</strong>${order.createTime}</div>
                                        </div>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <div class="table-scroll-hint">← 左右滑动查看更多 →</div>
            </div>
        </c:when>
        <c:otherwise>
            <div class="empty-message animate-scale-in" style="text-align:center;padding:70px 20px;background:white;border-radius:var(--radius-md);box-shadow:var(--shadow-sm);">
                <svg viewBox="0 0 200 160" style="width:150px;height:120px;margin-bottom:14px"><rect x="30" y="25" width="140" height="110" rx="10" fill="#FDF8F5" stroke="#FF6B35" stroke-width="2"/><rect x="50" y="45" width="100" height="14" rx="3" fill="#EEE"/><rect x="50" y="68" width="70" height="10" rx="3" fill="#EEE"/><rect x="50" y="85" width="85" height="10" rx="3" fill="#EEE"/><circle cx="100" cy="115" r="12" fill="none" stroke="#FF6B35" stroke-width="2"/><path d="M94 115l4 4 8-8" stroke="#FF6B35" stroke-width="2" fill="none"/></svg>
                <h3 style="margin-bottom:8px;color:var(--text-dark);font-weight:700;">暂无订单记录</h3>
                <p style="color:var(--text-secondary);font-size:15px;">您还没有购买任何门票，快去看看精彩的脱口秀演出吧！</p>
                <a href="shows" class="btn-primary-custom" style="display:inline-block;margin-top:18px;padding:12px 28px;">浏览演出</a>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<div class="refund-modal" id="refundModal" style="display:none;position:fixed;inset:0;background:rgba(0,0,0,0.55);z-index:2000;align-items:center;justify-content:center;">
    <div class="payment-modal" style="animation:modalSlideUp 0.4s ease">
        <h4 style="font-weight:700;">🎫 申请退票</h4>
        <div class="refund-policy" style="background:var(--bg-warm);padding:14px;border-radius:var(--radius-sm);margin-bottom:16px;font-size:13px;color:var(--text-secondary);border-left:3px solid var(--accent-yellow);">
            <strong style="color:var(--accent-yellow);">❗️ 退票规则</strong><br>
            &bull; 演出前72小时以上：全额退款<br>
            &bull; 演出前24-72小时：退80%<br>
            &bull; 演出前24小时内：退50%
        </div>
        <p style="font-size:14px;"><strong>演出：</strong><span id="refundShowName"></span></p>
        <p style="font-size:14px;"><strong>金额：</strong><strong style="color:var(--accent-red);" id="refundAmount"></strong></p>
        <input type="hidden" id="refundOrderId">
        <div class="form-field">
            <label class="required">退票原因</label>
            <textarea id="refundReason" placeholder="请填写退票原因（必填）" rows="3"></textarea>
            <span class="form-error-msg"></span>
        </div>
        <div style="display:flex;gap:10px;margin-top:16px;">
            <button class="btn-primary-custom" style="flex:1;background:#dfe6e9;color:var(--text-secondary);" onclick="closeRefundModal()">取消</button>
            <button class="btn-primary-custom" id="confirmRefundBtn" style="flex:1;" onclick="submitRefund()">确认申请</button>
        </div>
    </div>
</div>

<script src="js/main.js"></script>
<script>
function doLogout() { if (confirm('确定要退出登录吗？')) window.location.href='login?action=logout'; }

function toggleOrderDetail(el) {
    const row = el.closest('tr');
    const orderId = row.dataset.orderId;
    const detailRow = document.getElementById('detail-' + orderId);
    if (detailRow) {
        const icon = el.querySelector('i');
        detailRow.style.display = detailRow.style.display === 'none' ? '' : 'none';
        icon.classList.toggle('fa-chevron-down');
        icon.classList.toggle('fa-chevron-up');
    }
}

function openRefundModal(id, name, amt) {
    document.getElementById('refundOrderId').value = id;
    document.getElementById('refundShowName').textContent = name;
    document.getElementById('refundAmount').textContent = '¥' + amt;
    document.getElementById('refundReason').value = '';
    document.getElementById('refundModal').style.display = 'flex';
}
function closeRefundModal() { document.getElementById('refundModal').style.display = 'none'; }

function submitRefund() {
    const reason = document.getElementById('refundReason').value.trim();
    if (!reason) { Toast.error('请填写退票原因'); return; }
    const btn = document.getElementById('confirmRefundBtn');
    btn.disabled = true;

    fetch('apply-refund', {
        method:'POST',
        headers:{'Content-Type':'application/x-www-form-urlencoded'},
        body:'orderId='+document.getElementById('refundOrderId').value+'&reason='+encodeURIComponent(reason)
    })
    .then(r => r.json())
    .then(result => {
        Toast[result.success ? 'success' : 'error'](result.message);
        if (result.success) setTimeout(() => window.location.reload(), 1200);
        else btn.disabled = false;
    })
    .catch(() => { Toast.error('网络错误，请重试'); btn.disabled = false; });
}

document.getElementById('refundModal')?.addEventListener('click', function(e) { if (e.target === this) closeRefundModal(); });
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
