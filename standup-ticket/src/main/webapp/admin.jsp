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

    Integer totalUsers = (Integer) request.getAttribute("totalUsers");
    Integer totalShows = (Integer) request.getAttribute("totalShows");
    Integer totalOrders = (Integer) request.getAttribute("totalOrders");
    Double totalRevenue = (Double) request.getAttribute("totalRevenue");
    Integer pendingRefunds = (Integer) request.getAttribute("pendingRefunds");
    List<Order> recentOrders = (List<Order>) request.getAttribute("recentOrders");
    Boolean dbError = (Boolean) request.getAttribute("dbError");
    String errorMessage = (String) request.getAttribute("errorMessage");
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>脱口秀门票预订系统 - 管理员后台</title>
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
        <li><a href="admin" class="active"><i class="fas fa-tachometer-alt"></i> 控制面板</a></li>
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
            &copy; 2025 脱口秀票务系统
        </div>
    </div>
</div>

<div class="main-content">
    <nav class="navbar-custom">
        <div style="display:flex;align-items:center;gap:14px;">
            <button class="admin-hamburger" onclick="toggleSidebar()" style="display:none;background:none;border:none;font-size:20px;cursor:pointer;color:var(--text-dark);">
                <i class="fas fa-bars"></i>
            </button>
            <span class="navbar-brand">管理员控制面板</span>
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

    <% if (dbError != null && dbError) { %>
    <div class="alert alert-danger alert-dismissible fade show animate-fade-in-up" role="alert" style="border-radius:var(--radius-sm);border:none;padding:14px 20px;">
        <i class="fas fa-exclamation-triangle me-2"></i>
        <strong>数据库连接失败！</strong> <%= errorMessage != null ? errorMessage : "请检查MySQL服务是否启动，并确认数据库standup_comedy已创建" %>
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
    <% } %>

    <div class="row g-4 mb-4">
        <div class="col-xl-3 col-md-6 stat-card-wrapper" style="animation-delay:0s;">
            <div class="card stat-card text-white bg-primary animate-fade-in-up">
                <div class="card-body">
                    <div class="stat-label">总用户数</div>
                    <div class="stat-value" data-target="<%= totalUsers != null ? totalUsers : 0 %>">0</div>
                    <div class="stat-icon">👥</div>
                </div>
            </div>
        </div>
        <div class="col-xl-3 col-md-6 stat-card-wrapper" style="animation-delay:0.1s;">
            <div class="card stat-card text-white bg-success animate-fade-in-up">
                <div class="card-body">
                    <div class="stat-label">总演出数</div>
                    <div class="stat-value" data-target="<%= totalShows != null ? totalShows : 0 %>">0</div>
                    <div class="stat-icon">🎤</div>
                </div>
            </div>
        </div>
        <div class="col-xl-3 col-md-6 stat-card-wrapper" style="animation-delay:0.2s;">
            <div class="card stat-card text-white bg-warning animate-fade-in-up">
                <div class="card-body">
                    <div class="stat-label">总订单数</div>
                    <div class="stat-value" data-target="<%= totalOrders != null ? totalOrders : 0 %>">0</div>
                    <div class="stat-icon">🎫</div>
                </div>
            </div>
        </div>
        <div class="col-xl-3 col-md-6 stat-card-wrapper" style="animation-delay:0.3s;">
            <div class="card stat-card text-white bg-info animate-fade-in-up">
                <div class="card-body">
                    <div class="stat-label">总销售额</div>
                    <div class="stat-value stat-revenue" data-target="<%= totalRevenue != null ? totalRevenue : 0 %>">¥0</div>
                    <div class="stat-icon">💰</div>
                </div>
            </div>
        </div>
    </div>

    <div class="row g-4">
        <div class="col-lg-8">
            <div class="dashboard-section animate-fade-in-up" style="animation-delay:0.4s;">
                <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:20px;">
                    <h5 style="margin:0;font-weight:700;color:var(--text-dark);font-size:16px;"><i class="fas fa-clock me-2" style="color:var(--primary-start);"></i>最近订单</h5>
                    <a href="admin?action=orders" class="btn-primary-custom" style="padding:6px 14px;font-size:12px;">查看全部</a>
                </div>
                <div class="table-container-admin">
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                            <tr>
                                <th>订单号</th>
                                <th>观众姓名</th>
                                <th>演出</th>
                                <th>数量</th>
                                <th>金额</th>
                                <th>状态</th>
                                <th>下单时间</th>
                            </tr>
                            </thead>
                            <tbody>
<%
if (recentOrders != null && !recentOrders.isEmpty()) {
    for (Order order : recentOrders) {
%>
                            <tr class="animate-fade-in-up" style="animation-delay:0.05s;">
                                <td><code style="background:#f8f9fa;padding:2px 8px;border-radius:4px;font-size:12px;"><%= order.getOrderNumber() %></code></td>
                                <td style="font-weight:500;"><%= order.getSpectatorName() %></td>
                                <td><%= order.getShowName() != null ? order.getShowName() : "演出ID: " + order.getShowId() %></td>
                                <td><span class="badge bg-light text-dark rounded-pill"><%= order.getQuantity() %>张</span></td>
                                <td style="color:var(--primary-start);font-weight:600;">¥<%= String.format("%.2f", order.getTotalAmount()) %></td>
                                <td>
<%
String statusStyle = "";
String statusText = "";
String s = order.getStatus();
if ("paid".equals(s)) {
    statusStyle = "background:rgba(0,184,148,0.15);color:#00b894;";
    statusText = "✓ 已支付";
} else if ("refunding".equals(s)) {
    statusStyle = "background:rgba(9,132,227,0.15);color:#0984e3;";
    statusText = "⟳ 退票中";
} else if ("refunded".equals(s)) {
    statusStyle = "background:rgba(108,117,125,0.15);color:#6c757d;";
    statusText = "↩ 已退款";
} else {
    statusStyle = "background:rgba(247,201,72,0.15);color:#e17055;";
    statusText = "⏳ 待支付";
}
%>
                                    <span class="badge rounded-pill" style="<%= statusStyle %>"><%= statusText %></span>
                                </td>
                                <td style="color:var(--text-secondary);font-size:13px;"><%= order.getCreateTime() %></td>
                            </tr>
<%
    }
} else {
%>
                            <tr>
                                <td colspan="7" style="text-align:center;padding:40px;color:var(--text-secondary);">
                                    <i class="fas fa-inbox" style="font-size:32px;margin-bottom:10px;display:block;opacity:0.3;"></i>
                                    暂无订单数据
                                </td>
                            </tr>
<%
}
%>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-lg-4">
            <div class="dashboard-section animate-fade-in-up" style="animation-delay:0.5s;">
                <h5 style="margin:0 0 18px;font-weight:700;color:var(--text-dark);font-size:16px;"><i class="fas fa-tasks me-2" style="color:var(--primary-start);"></i>待处理事项</h5>
                <div class="list-group list-group-flush" style="border-radius:var(--radius-sm);overflow:hidden;">
                    <a href="admin?action=refunds" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center" style="padding:14px 16px;border-left:3px solid var(--accent-red);transition:all 0.25s;">
                        <div>
                            <div style="font-weight:600;font-size:14px;">待审核退票申请</div>
                            <div style="font-size:12px;color:var(--text-secondary);margin-top:2px;">需要及时处理</div>
                        </div>
                        <span class="badge rounded-pill" style="background:linear-gradient(135deg,var(--accent-red),#ff6b81);color:white;font-size:13px;padding:5px 12px;"><%= pendingRefunds != null ? pendingRefunds : 0 %></span>
                    </a>
                    <a href="admin?action=shows" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center" style="padding:14px 16px;border-left:3px solid #00b894;transition:all 0.25s;">
                        <div>
                            <div style="font-weight:600;font-size:14px;">管理演出信息</div>
                            <div style="font-size:12px;color:var(--text-secondary);margin-top:2px;">添加/编辑演出</div>
                        </div>
                        <i class="fas fa-chevron-right" style="color:var(--text-secondary);"></i>
                    </a>
                    <a href="admin?action=orders" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center" style="padding:14px 16px;border-left:3px solid #0984e3;transition:all 0.25s;">
                        <div>
                            <div style="font-weight:600;font-size:14px;">查看所有订单</div>
                            <div style="font-size:12px;color:var(--text-secondary);margin-top:2px;">订单详情与状态</div>
                        </div>
                        <i class="fas fa-chevron-right" style="color:var(--text-secondary);"></i>
                    </a>
                    <a href="admin?action=users" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center" style="padding:14px 16px;border-left:3px solid #F7C948;transition:all 0.25s;">
                        <div>
                            <div style="font-weight:600;font-size:14px;">管理用户账户</div>
                            <div style="font-size:12px;color:var(--text-secondary);margin-top:2px;">用户信息维护</div>
                        </div>
                        <i class="fas fa-chevron-right" style="color:var(--text-secondary);"></i>
                    </a>
                </div>
            </div>

            <div class="dashboard-section animate-fade-in-up mt-4" style="animation-delay:0.6s;">
                <h5 style="margin:0 0 16px;font-weight:700;color:var(--text-dark);font-size:16px;"><i class="fas fa-chart-line me-2" style="color:var(--primary-start);"></i>快速操作</h5>
                <div class="d-grid gap-2">
                    <a href="admin-show-add.jsp" class="btn-primary-custom" style="justify-content:center;padding:12px;width:100%;">
                        <i class="fas fa-plus-circle"></i> 添加新演出
                    </a>
                    <button class="btn-primary-custom" style="justify-content:center;padding:12px;width:100%;background:#dfe6e9;color:var(--text-secondary);" onclick="window.location.href='admin?action=verify'">
                        <i class="fas fa-qrcode"></i> 验票核销
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="js/main.js"></script>
<script>
function toggleSidebar() {
    document.getElementById('adminSidebar').classList.toggle('open');
}

function animateStats() {
    const stats = document.querySelectorAll('.stat-value');
    stats.forEach(stat => {
        const target = parseFloat(stat.dataset.target);
        const isRevenue = stat.classList.contains('stat-revenue');
        let current = 0;
        const increment = target / 60;
        const timer = setInterval(() => {
            current += increment;
            if (current >= target) {
                current = target;
                clearInterval(timer);
            }
            if (isRevenue) {
                stat.textContent = '¥' + current.toFixed(2);
            } else {
                stat.textContent = Math.floor(current).toLocaleString();
            }
        }, 25);
    });
}

document.addEventListener('DOMContentLoaded', () => {
    setTimeout(animateStats, 300);

    document.querySelectorAll('.list-group-item').forEach(item => {
        item.addEventListener('mouseenter', function() {
            this.style.transform = 'translateX(4px)';
            this.style.boxShadow = 'var(--shadow-sm)';
        });
        item.addEventListener('mouseleave', function() {
            this.style.transform = '';
            this.style.boxShadow = '';
        });
    });
});
</script>

<style>
.stat-label {
    font-size: 13px;
    font-weight: 600;
    opacity: 0.9;
    margin-bottom: 8px;
}
.stat-value {
    font-size: 28px;
    font-weight: 800;
    line-height: 1.2;
}
.stat-card .card-body {
    position: relative;
    z-index: 1;
}
.admin-hamburger:hover {
    color: var(--primary-start) !important;
}
</style>
</body>
</html>
