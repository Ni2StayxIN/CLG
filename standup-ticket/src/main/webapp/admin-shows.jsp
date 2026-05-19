<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.fengwei.ticket.entity.Show" %>
<%@ page import="com.fengwei.ticket.entity.User" %>
<%@ page import="java.util.List" %>
<%
    User adminUser = (User) session.getAttribute("user");
    if (adminUser == null || !"admin".equals(adminUser.getUserType())) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Show> shows = (List<Show>) request.getAttribute("shows");
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>脱口秀演出管理 - 管理员后台</title>
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
        <li><a href="admin?action=shows" class="active"><i class="fas fa-microphone"></i> 演出管理</a></li>
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
            <span class="navbar-brand">🎤 脱口秀演出管理</span>
        </div>

        <div class="d-flex align-items-center gap-3">
            <a href="admin-show-add.jsp" class="btn-primary-custom">
                <i class="fas fa-plus-circle"></i> 添加演出
            </a>
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
                    <th>海报</th>
                    <th>演出标题</th>
                    <th>主演</th>
                    <th>城市</th>
                    <th>场馆</th>
                    <th>演出时间</th>
                    <th>票价</th>
                    <th>剩余票数</th>
                    <th>状态</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
<%
if (shows != null && !shows.isEmpty()) {
    for (Show show : shows) {
        String statusStyle = "";
        String statusText = "";
        if ("upcoming".equals(show.getStatus())) {
            statusStyle = "background:rgba(0,184,148,0.15);color:#00b894;";
            statusText = "✓ 即将开始";
        } else {
            statusStyle = "background:rgba(108,117,125,0.15);color:#6c757d;";
            statusText = "已结束";
        }
%>
                <tr class="animate-fade-in-up" style="animation-delay:0.03s;">
                    <td><code style="background:#f8f9fa;padding:2px 8px;border-radius:4px;font-size:12px;"><%= show.getId() %></code></td>
                    <td>
                        <img src="<%= show.getImageUrl() %>" alt="演出海报" style="width:60px;height:40px;object-fit:cover;border-radius:6px;"
                             onerror="this.src='data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iNjAiIGhlaWdodD0iNDAiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+PGRlZnM+PGxpbmVhckdyYWRpZW50IGlkPSJnIiB4MT0iMCUiIHkxPSIwJSIgeDI9IjEwMCUiIHkyPSIxMDAlIj48c3RvcCBvZmZzZXQ9IjAlIiBzdG9wLWNvbG9yPSIjRkY2QjM1Ii8+PHN0b3Agb2Zmc2V0PSIxMDAlIiBzdG9wLWNvbG9yPSIjOUI1OUI2Ii8+PC9saW5lYXJHcmFkaWVudD48L2RlZnM+PHJlY3Qgd2lkdGg9IjEwMCUiIGhlaWdodD0iMTAwJSIgZmlsbD0idXJsKCNnKSIvPjx0ZXh0IHg9IjUwJSIgeT0iNTAlIiBmb250LWZhbWlseT0iQXJpYWwiIGZvbnQtc2l6ZT0iOCIgZmlsbD0id2hpdGUiIHRleHQtYW5jaG9yPSJtaWRkbGUiIGR5PSIuM2VtIj7nu4fljZXlr77lrovlrpw8L3RleHQ+PC9zdmc+">
                    </td>
                    <td style="font-weight:600;"><%= show.getTitle() %></td>
                    <td><%= show.getPerformer() != null ? show.getPerformer() : "-" %></td>
                    <td><span class="badge bg-light text-dark rounded-pill"><%= show.getCity() %></span></td>
                    <td style="font-size:13px;"><%= show.getVenue() %></td>
                    <td style="white-space:nowrap;"><%= show.getShowTime() %></td>
                    <td style="color:var(--primary-start);font-weight:600;">¥<%= show.getPrice() %></td>
                    <td>
                        <span class="badge rounded-pill <%= show.getAvailableTickets() > 50 ? "bg-success" : show.getAvailableTickets() > 10 ? "bg-warning text-dark" : "bg-danger" %>">
                            <%= show.getAvailableTickets() %>/<%= show.getTotalTickets() %>
                        </span>
                    </td>
                    <td>
                        <span class="badge rounded-pill" style="<%= statusStyle %>"><%= statusText %></span>
                    </td>
                    <td>
                        <form action="admin" method="post" style="display:inline;">
                            <input type="hidden" name="action" value="deleteShow">
                            <input type="hidden" name="id" value="<%= show.getId() %>">
                            <button type="submit" class="admin-btn admin-btn-danger" onclick="return confirm('确定要删除「<%= show.getTitle() %>」吗？此操作不可撤销！')">
                                <i class="fas fa-trash-alt"></i> 删除
                            </button>
                        </form>
                    </td>
                </tr>
<%
    }
} else {
%>
                <tr>
                    <td colspan="11" style="text-align:center;padding:40px;color:var(--text-secondary);">
                        <i class="fas fa-theater-masks" style="font-size:32px;margin-bottom:10px;display:block;opacity:0.3;"></i>
                        暂无演出数据，点击右上角添加新演出
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

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="js/main.js"></script>
<script>
function toggleSidebar() {
    document.getElementById('adminSidebar').classList.toggle('open');
}
</script>
</body>
</html>
