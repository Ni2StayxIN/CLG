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
    <title>验票核销 - 管理员后台</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="css/main.css" rel="stylesheet">
    <link href="css/animations.css" rel="stylesheet">
    <link href="css/admin.css" rel="stylesheet">
</head>
<body>

<div class="sidebar" id="adminSidebar">
    <div class="sidebar-header">
        <h4>🎭 脱口秀票务</h4>
        <p>管理员控制台</p>
    </div>

    <ul class="sidebar-menu">
        <li><a href="admin"><i class="fas fa-tachometer-alt"></i> 控制面板</a></li>
        <li><a href="admin?action=shows"><i class="fas fa-microphone"></i> 演出管理</a></li>
        <li><a href="admin?action=orders"><i class="fas fa-ticket-alt"></i> 订单管理</a></li>
        <li><a href="admin?action=refunds"><i class="fas fa-undo"></i> 退票管理</a></li>
        <li><a href="admin?action=users"><i class="fas fa-users"></i> 用户管理</a></li>
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

<div class="main-content">
    <nav class="navbar-custom">
        <div style="display:flex;align-items:center;gap:14px;">
            <button class="admin-hamburger" onclick="toggleSidebar()" style="display:none;background:none;border:none;font-size:20px;cursor:pointer;color:var(--text-dark);">
                <i class="fas fa-bars"></i>
            </button>
            <span class="navbar-brand">🎫 验票核销</span>
        </div>

        <div class="d-flex align-items-center gap-3">
            <div class="dropdown">
                <a href="#" class="d-flex align-items-center text-decoration-none dropdown-toggle" id="userDropdown" data-bs-toggle="dropdown"
                   style="color:var(--text-dark);font-weight:500;">
                    <img src="https://ui-avatars.com/api/?name=<%= adminUser.getRealName() != null ? adminUser.getRealName() : "Admin" %>&background=FF6B35&color=fff"
                         alt="管理员" width="32" height="32" class="rounded-circle me-2" style="border:2px solid white;box-shadow:var(--shadow-sm);">
                    <span><%= adminUser.getRealName() != null ? adminUser.getRealName() : "管理员" %></span>
                </a>
                <ul class="dropdown-menu dropdown-menu-end">
                    <li><a class="dropdown-item" href="login?action=logout"><i class="fas fa-sign-out-alt me-2"></i> 退出登录</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <div style="max-width:700px;margin:0 auto;">
        <div class="verify-panel animate-fade-in-up">
            <div style="margin-bottom:24px;text-align:center;">
                <div style="width:80px;height:80px;border-radius:50%;background:linear-gradient(135deg,var(--primary-start),#9B59B6);display:inline-flex;align-items:center;justify-content:center;margin-bottom:16px;box-shadow:0 8px 24px rgba(255,107,53,0.3);">
                    <i class="fas fa-qrcode" style="font-size:36px;color:white;"></i>
                </div>
                <h3 style="font-size:22px;font-weight:800;color:var(--text-dark);margin:0;">门票核销</h3>
                <p style="color:var(--text-secondary);margin:8px 0 0;font-size:14px;">输入订单号或扫描二维码进行验票</p>
            </div>

            <div class="verify-input-group">
                <input type="text" id="orderNumberInput" placeholder="请输入订单号（如：202505170001）" maxlength="20" onkeypress="if(event.key==='Enter')verifyTicket()">
                <button class="btn-primary-custom" onclick="verifyTicket()" style="padding:12px 28px;font-size:15px;" id="verifyBtn">
                    <i class="fas fa-check-circle"></i> 验票
                </button>
            </div>

            <div style="display:flex;gap:10px;justify-content:center;margin-bottom:20px;">
                <button class="btn-primary-custom" style="background:#f8f9fa;color:var(--text-dark);padding:10px 20px;" onclick="simulateScan()">
                    <i class="fas fa-camera"></i> 模拟扫码
                </button>
                <button class="btn-primary-custom" style="background:#f8f9fa;color:var(--text-dark);padding:10px 20px;" onclick="clearResult()">
                    <i class="fas fa-redo"></i> 重置
                </button>
            </div>

            <div id="verifyResult" class="verify-result"></div>
        </div>

        <div class="dashboard-section animate-fade-in-up mt-4" style="animation-delay:0.2s;">
            <h4 style="font-size:17px;font-weight:700;margin:0 0 18px;color:var(--text-dark);">
                <i class="fas fa-history me-2" style="color:var(--primary-start);"></i>今日核销记录
            </h4>
            <div id="verifyHistory" style="max-height:400px;overflow-y:auto;"></div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="js/main.js"></script>
<script>
function toggleSidebar() {
    document.getElementById('adminSidebar').classList.toggle('open');
}

const mockOrders = {
    '202505170001': { show: '脱口秀之夜', user: '张三', qty: 2, time: '2025-05-19 19:30', status: 'paid' },
    '202505170002': { show: '欢乐喜剧人', user: '李四', qty: 1, time: '2025-05-19 19:30', status: 'paid' },
    '202505170003': { show: '爆笑工坊', user: '王五', qty: 3, time: '2025-05-20 20:00', status: 'verified' },
    '202505170004': { show: '即兴喜剧秀', user: '赵六', qty: 2, time: '2025-05-21 19:00', status: 'paid' },
};

let verifyHistory = JSON.parse(localStorage.getItem('verifyHistory') || '[]');

function verifyTicket() {
    const input = document.getElementById('orderNumberInput');
    const orderNo = input.value.trim();
    if (!orderNo) {
        Toast.warning('请输入订单号');
        return;
    }

    const btn = document.getElementById('verifyBtn');
    btn.disabled = true;
    btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> 验证中...';

    setTimeout(() => {
        const resultEl = document.getElementById('verifyResult');
        const order = mockOrders[orderNo];

        if (!order) {
            resultEl.className = 'verify-result fail';
            resultEl.innerHTML = `
                <div style="font-size:48px;margin-bottom:12px;">❌</div>
                <h4 style="color:#FF4757;margin:0 0 8px;">未找到订单</h4>
                <p style="margin:0;color:#666;font-size:14px;">订单号 ${orderNo} 不存在，请检查后重试</p>`;
            Toast.error('未找到该订单');
        } else if (order.status === 'verified') {
            resultEl.className = 'verify-result fail';
            resultEl.innerHTML = `
                <div style="font-size:48px;margin-bottom:12px;">⚠️</div>
                <h4 style="color:#e17055;margin:0 0 8px;">已核销</h4>
                <p style="margin:0;color:#666;font-size:14px;">该订单已于之前核销，请勿重复使用</p>
                <div style="margin-top:12px;padding:12px;background:white;border-radius:8px;font-size:13px;">
                    <strong>${order.show}</strong> - ${order.user} (${order.qty}张)
                </div>`;
            Toast.warning('此订单已核销');
        } else {
            order.status = 'verified';
            resultEl.className = 'verify-result success';
            resultEl.innerHTML = `
                <div style="font-size:48px;margin-bottom:12px;">✅</div>
                <h4 style="color:#00b894;margin:0 0 8px;">核销成功</h4>
                <p style="margin:0;color:#666;font-size:14px;">欢迎观演！祝您度过愉快的时光 🎉</p>
                <div style="margin-top:16px;padding:16px;background:white;border-radius:8px;text-align:left;">
                    <div style="display:flex;justify-content:space-between;padding:6px 0;border-bottom:1px solid #eee;"><span style="color:#999;">演出名称</span><strong>${order.show}</strong></div>
                    <div style="display:flex;justify-content:space-between;padding:6px 0;border-bottom:1px solid #eee;"><span style="color:#999;">观众姓名</span><strong>${order.user}</strong></div>
                    <div style="display:flex;justify-content:space-between;padding:6px 0;border-bottom:1px solid #eee;"><span style="color:#999;">票数</span><strong>${order.qty} 张</strong></div>
                    <div style="display:flex;justify-content:space-between;padding:6px 0;"><span style="color:#999;">演出时间</span><strong>${order.time}</strong></div>
                </div>`;
            Toast.success('核销成功！');
            addVerifyRecord(orderNo, order);
            confetti && confetti();
        }

        btn.disabled = false;
        btn.innerHTML = '<i class="fas fa-check-circle"></i> 验票';
    }, 1200);
}

function simulateScan() {
    const orders = Object.keys(mockOrders).filter(k => mockOrders[k].status === 'paid');
    if (orders.length > 0) {
        const randomOrder = orders[Math.floor(Math.random() * orders.length)];
        document.getElementById('orderNumberInput').value = randomOrder;
        verifyTicket();
    } else {
        Toast.info('没有可用的测试订单');
    }
}

function addVerifyRecord(orderNo, order) {
    const record = {
        orderNo,
        show: order.show,
        user: order.user,
        qty: order.qty,
        time: new Date().toLocaleString(),
        operator: '<%= adminUser.getRealName() != null ? adminUser.getRealName() : "Admin" %>'
    };
    verifyHistory.unshift(record);
    if (verifyHistory.length > 50) verifyHistory.pop();
    localStorage.setItem('verifyHistory', JSON.stringify(verifyHistory));
    renderHistory();
}

function renderHistory() {
    const container = document.getElementById('verifyHistory');
    if (verifyHistory.length === 0) {
        container.innerHTML = `<div style="text-align:center;padding:40px;color:var(--text-secondary);">
            <i class="fas fa-clipboard-list" style="font-size:32px;opacity:0.3;margin-bottom:10px;display:block;"></i>
            今日暂无核销记录
        </div>`;
        return;
    }

    container.innerHTML = `<table class="table table-hover" style="margin:0;">
        <thead><tr>
            <th style="width:140px;">时间</th>
            <th>订单号</th>
            <th>演出</th>
            <th>观众</th>
            <th style="width:60px;">票数</th>
            <th style="width:100px;">操作人</th>
        </tr></thead>
        <tbody>
            ${verifyHistory.map(r => `
                <tr style="animation:fadeInUp 0.3s ease;">
                    <td style="font-size:13px;color:var(--text-secondary);">${r.time}</td>
                    <td><code style="font-size:12px;">${r.orderNo}</code></td>
                    <td style="font-weight:500;">${r.show}</td>
                    <td>${r.user}</td>
                    <td><span class="badge bg-light text-dark rounded-pill">${r.qty}张</span></td>
                    <td style="font-size:13px;">${r.operator}</td>
                </tr>`).join('')}
        </tbody>
    </table>`;
}

function clearResult() {
    document.getElementById('orderNumberInput').value = '';
    document.getElementById('verifyResult').className = 'verify-result';
    document.getElementById('verifyResult').innerHTML = '';
}

document.addEventListener('DOMContentLoaded', () => {
    renderHistory();
});
</script>
</body>
</html>