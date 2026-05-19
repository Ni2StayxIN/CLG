<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.fengwei.ticket.entity.Refund" %>
<%@ page import="com.fengwei.ticket.entity.User" %>
<%@ page import="java.util.List" %>
<%
    User adminUser = (User) session.getAttribute("user");
    if (adminUser == null || !"admin".equals(adminUser.getUserType())) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Refund> refunds = (List<Refund>) request.getAttribute("refunds");
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>退票管理 - 管理员后台</title>
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
        <li><a href="admin?action=refunds" class="active"><i class="fas fa-undo"></i> 退票管理</a></li>
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
            <span class="navbar-brand">退票管理</span>
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

    <div class="table-container-admin animate-fade-in-up">
        <div class="table-responsive">
            <table class="table table-hover">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>订单号</th>
                    <th>演出名称</th>
                    <th>申请人</th>
                    <th>退票数量</th>
                    <th>退款金额</th>
                    <th>退票原因</th>
                    <th>状态</th>
                    <th>申请时间</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
<%
if (refunds != null && !refunds.isEmpty()) {
    for (Refund refund : refunds) {
        String statusText = "";
        if ("pending".equals(refund.getStatus())) {
            statusText = "⏳ 待审核";
        } else if ("approved".equals(refund.getStatus())) {
            statusText = "✅ 已批准";
        } else {
            statusText = "❌ 已拒绝";
        }
%>
                <tr>
                    <td><%= refund.getId() %></td>
                    <td><%= refund.getOrderNumber() != null ? refund.getOrderNumber() : "-" %></td>
                    <td><%= refund.getShowName() != null ? refund.getShowName() : "-" %></td>
                    <td><%= refund.getUserName() != null ? refund.getUserName() : "-" %></td>
                    <td><%= refund.getQuantity() %></td>
                    <td><span style="font-weight:bold;color:var(--primary-start);">¥<%= String.format("%.2f", refund.getRefundAmount()) %></span></td>
                    <td><%= refund.getReason() != null ? refund.getReason() : "-" %></td>
                    <td><%= statusText %></td>
                    <td><%= refund.getApplyTime() %></td>
                    <td>
<%
if ("pending".equals(refund.getStatus())) {
%>
                        <button class="admin-btn admin-btn-primary" onclick="openProcessModal(<%= refund.getId() %>, true)">批准</button>
                        <button class="admin-btn admin-btn-danger" onclick="openProcessModal(<%= refund.getId() %>, false)">拒绝</button>
<%
} else {
%>
                        <span style="color:var(--text-secondary);font-size:13px;">已处理</span>
<%
        if (refund.getAdminRemark() != null) {
%>
                        <br><small style="color:var(--text-secondary);">备注: <%= refund.getAdminRemark() %></small>
<%
        }
    }
%>
                    </td>
                </tr>
<%
    }
} else {
%>
                <tr>
                    <td colspan="10" style="text-align:center;padding:40px;color:var(--text-secondary);">暂无退票申请</td>
                </tr>
<%
}
%>
                </tbody>
            </table>
        </div>
    </div>
</div>

<div class="modal-overlay" id="processModal">
    <div class="modal-content">
        <h5 style="font-weight:700;margin-bottom:16px;">处理退票申请</h5>
        <form action="admin" method="post">
            <input type="hidden" name="action" value="processRefund">
            <input type="hidden" name="refundId" id="processRefundId">
            <input type="hidden" name="decision" id="processDecision">
            <div class="form-field">
                <label>处理备注</label>
                <textarea name="adminRemark" rows="3" placeholder="请输入处理备注（可选）"></textarea>
            </div>
            <div style="display:flex;justify-content:flex-end;gap:10px;margin-top:16px;">
                <button type="button" class="btn-primary-custom" style="background:#dfe6e9;color:var(--text-secondary);" onclick="closeProcessModal()">取消</button>
                <button type="submit" class="btn-primary-custom">确认</button>
            </div>
        </form>
    </div>
</div>

<style>
.modal-overlay {
    display: none;
    position: fixed;
    inset: 0;
    background: rgba(0,0,0,0.5);
    z-index: 2000;
    align-items: center;
    justify-content: center;
}
.modal-overlay.show {
    display: flex;
}
.modal-content {
    background: white;
    border-radius: var(--radius-md);
    padding: 30px;
    max-width: 500px;
    width: 90%;
    animation: fadeInUp 0.3s ease;
}
</style>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="js/main.js"></script>
<script>
function toggleSidebar() {
    document.getElementById('adminSidebar').classList.toggle('open');
}
function openProcessModal(refundId, approve) {
    document.getElementById('processRefundId').value = refundId;
    document.getElementById('processDecision').value = approve ? 'approve' : 'reject';
    document.getElementById('processModal').classList.add('show');
}
function closeProcessModal() {
    document.getElementById('processModal').classList.remove('show');
}
document.getElementById('processModal')?.addEventListener('click', function(e) {
    if (e.target === this) closeProcessModal();
});
</script>
</body>
</html>
