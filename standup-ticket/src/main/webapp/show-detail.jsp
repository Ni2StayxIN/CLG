<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.fengwei.ticket.entity.Show" %>
<%@ page import="com.fengwei.ticket.entity.User" %>
<%
    User user = (User) session.getAttribute("user");
    Show show = (Show) request.getAttribute("showDetail");
    String error = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= show != null ? show.getTitle() : "演出详情" %> - 脱口秀门票预订</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="css/main.css" rel="stylesheet">
    <link href="css/animations.css" rel="stylesheet">
</head>
<body>

<nav class="navbar">
    <div class="container-fluid" style="max-width:1200px;padding:0 24px;">
        <a class="navbar-brand" href="shows" style="display:flex;align-items:center;gap:10px;font-size:20px;">
            🎭 脱口秀票务
        </a>
        <div class="nav-links">
            <a href="shows" class="nav-link active">🏠 首页</a>
            <% if (user == null) { %>
            <a href="login.jsp" class="nav-link">👤 登录</a>
            <a href="register.jsp" class="btn-primary-custom nav-btn">注册</a>
            <% } else { %>
            <a href="orders.jsp" class="nav-link">🎫 我的订单</a>
            <a href="login?action=logout" class="nav-link">退出</a>
            <% } %>
        </div>
        <button class="hamburger"><i class="fas fa-bars"></i></button>
    </div>
</nav>

<div style="max-width:1100px;margin:30px auto;padding:0 24px;">

    <% if (error != null || show == null) { %>
    <div class="empty-state animate-fade-in-up" style="padding:60px 20px;text-align:center;">
        <svg class="empty-svg" viewBox="0 0 200 160" fill="none" style="width:200px;height:160px;margin-bottom:20px;">
            <rect x="30" y="20" width="140" height="100" rx="12" fill="#FDF8F5" stroke="#FF6B35" stroke-width="2"/>
            <circle cx="75" cy="55" r="18" fill="none" stroke="#FF6B35" stroke-width="2"/>
            <circle cx="125" cy="55" r="18" fill="none" stroke="#9B59B6" stroke-width="2"/>
            <path d="M65 62l8-8 16 16M119 47l12 16" stroke-width="2" stroke-linecap="round"/>
            <rect x="50" y="88" width="100" height="20" rx="4" fill="#EEE"/>
            <text x="100" y="102" text-anchor="middle" fill="#999" font-size="10">未找到</text>
        </svg>
        <h3 class="empty-title">演出不存在或已下架</h3>
        <p class="empty-desc">该演出可能已被删除或暂不可用</p>
        <a href="shows" class="btn-primary-custom" style="margin-top:12px;">返回首页</a>
    </div>
    <% return; } %>

    <div class="animate-fade-in-up">
        <nav aria-label="breadcrumb" style="margin-bottom:20px;">
            <ol class="breadcrumb" style="background:none;padding:0;margin:0;font-size:14px;">
                <li class="breadcrumb-item"><a href="shows" style="color:var(--text-secondary);text-decoration:none;">首页</a></li>
                <li class="breadcrumb-item active" style="color:var(--primary-start);font-weight:600;"><%= show.getTitle() %></li>
            </ol>
        </nav>
    </div>

    <div style="display:grid;grid-template-columns:1fr 380px;gap:28px;" id="detailGrid">

        <div class="detail-left animate-fade-in-up" style="animation-delay:0.1s;">
            <div class="detail-hero-image" style="position:relative;border-radius:var(--radius-lg);overflow:hidden;box-shadow:var(--shadow-lg);margin-bottom:24px;">
                <img src="<%= show.getImageUrl() %>" alt="<%= show.getTitle() %>"
                     style="width:100%;height:420px;object-fit:cover;display:block;"
                     onerror="this.src='data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iODAwIiBoZWlnaHQ9IjQyMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48ZGVmcz48bGluZWFyR3JhZGllbnQgaWQ9ImciIHgxPSIwJSIgeTE9IjAlIiB4Mj0iMTAwJSIgeTI9IjEwMCUiPjxzdG9wIG9mZnNldD0iMCUiIHN0b3AtY29sb3I9IiNGRjZCMzUiLz48c3RvcCBvZmZzZXQ9IjEwMCUiIHN0b3AtY29sb3I9IiM5QjU5QjYiLz48L2xpbmVhckdyYWRpZW50PjwvZGVmcz48cmVjdCB3aWR0aD0iMTAwJSIgaGVpZ2h0PSIxMDAlIiBmaWxsPSJ1cmwoI2cpIi8+PHRleHQgeD0iNTAlIiB5PSI1MCUiIGZvbnQtZmFtaWx5PSJBcmlhbCIgZm9udC1zaXplPSIyNCIgZmlsbD0id2hpdGUiIHRleHQtYW5jaG9yPSJtaWRkbGUiIGR5PSIuM2VtIj7nu4fljZXlr77lrovlrpw8L3RleHQ+PC9zdmc+'">
                <div class="countdown-badge" id="mainCountdown" style="position:absolute;top:16px;left:16px;background:rgba(0,0,0,0.65);backdrop-filter:blur(8px);color:white;padding:10px 18px;border-radius:25px;font-size:14px;font-weight:600;display:none;">
                    ⏱️ <span class="cd-text"></span>
                </div>
                <div style="position:absolute;top:16px;right:16px;display:flex;gap:8px;">
                    <button onclick="shareShow()" style="background:rgba(255,255,255,0.9);border:none;width:40px;height:40px;border-radius:50%;cursor:pointer;font-size:16px;display:flex;align-items:center;justify-content:center;transition:all 0.25s;" onmouseover="this.style.transform='scale(1.1)'" onmouseout="this.style.transform=''">📤</button>
                    <button onclick="toggleFavorite(this)" style="background:rgba(255,255,255,0.9);border:none;width:40px;height:40px;border-radius:50%;cursor:pointer;font-size:16px;display:flex;align-items:center;justify-content:center;transition:all 0.25s;" onmouseover="this.style.transform='scale(1.1)'" onmouseout="this.style.transform=''">❤️</button>
                </div>
            </div>

            <div class="dashboard-section" style="border-radius:var(--radius-md);padding:28px;margin-bottom:24px;">
                <h1 style="font-size:26px;font-weight:800;color:var(--text-dark);margin:0 0 16px;line-height:1.3;"><%= show.getTitle() %></h1>

                <div style="display:grid;grid-template-columns:repeat(auto-fit,minmax(180px,1fr));gap:14px;margin-bottom:24px;">
                    <div style="display:flex;align-items:center;gap:10px;padding:12px;background:#f8f9fa;border-radius:var(--radius-sm);">
                        <span style="font-size:22px;">🎭</span>
                        <div><div style="font-size:11px;color:var(--text-secondary);">主演</div><div style="font-weight:600;font-size:14px;"><%= show.getPerformer() != null ? show.getPerformer() : "待公布" %></div></div>
                    </div>
                    <div style="display:flex;align-items:center;gap:10px;padding:12px;background:#f8f9fa;border-radius:var(--radius-sm);">
                        <span style="font-size:22px;">📍</span>
                        <div><div style="font-size:11px;color:var(--text-secondary);">场馆</div><div style="font-weight:600;font-size:14px;"><%= show.getCity() %> · <%= show.getVenue() %></div></div>
                    </div>
                    <div style="display:flex;align-items:center;gap:10px;padding:12px;background:#f8f9fa;border-radius:var(--radius-sm);">
                        <span style="font-size:22px;">⏰</span>
                        <div><div style="font-size:11px;color:var(--text-secondary);">演出时间</div><div style="font-weight:600;font-size:14px;"><%= show.getShowTime() %></div></div>
                    </div>
                    <div style="display:flex;align-items:center;gap:10px;padding:12px;background:#f8f9fa;border-radius:var(--radius-sm);">
                        <span style="font-size:22px;">🎫</span>
                        <div><div style="font-size:11px;color:var(--text-secondary);">剩余票数</div><div style="font-weight:600;font-size:14px;color:<%= show.getAvailableTickets() > 50 ? "#00b894" : show.getAvailableTickets() > 10 ? "#e17055" : "#FF4757" %>;"><%= show.getAvailableTickets() %> / <%= show.getTotalTickets() %> 张</div></div>
                    </div>
                </div>

                <h3 style="font-size:17px;font-weight:700;margin:0 0 12px;color:var(--text-dark);">📋 演出介绍</h3>
                <div style="color:var(--text-dark);line-height:1.8;font-size:15px;">
                    <%= show.getDescription() != null ? show.getDescription().replace("\n", "<br/>") : "一场精彩绝伦的脱口秀演出，带给你欢声笑语和难忘的回忆。知名喜剧演员倾情献演，用幽默诙谐的方式讲述生活中的点滴故事，让你在欢笑中释放压力，感受脱口秀的独特魅力。" %>
                </div>
            </div>

            <div class="dashboard-section" style="border-radius:var(--radius-md);padding:28px;">
                <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:18px;">
                    <h3 style="font-size:17px;font-weight:700;margin:0;color:var(--text-dark);">💬 观众评价</h3>
                    <div style="display:flex;align-items:center;gap:8px;">
                        <span id="avgRating" style="font-size:24px;font-weight:800;color:#F7C948;">0</span>
                        <span style="color:var(--text-secondary);font-size:14px;">(<span id="reviewCount">0</span>条评价)</span>
                    </div>
                </div>

                <% if (user != null) { %>
                <div style="background:#f8f9fa;border-radius:var(--radius-md);padding:20px;margin-bottom:24px;">
                    <h4 style="font-size:15px;font-weight:600;margin:0 0 14px;">发表评价</h4>
                    <div style="margin-bottom:12px;">
                        <label style="display:block;font-size:13px;font-weight:600;margin-bottom:6px;color:var(--text-dark);">评分</label>
                        <div id="starRating" style="display:flex;gap:6px;" data-rating="0">
                            <span class="star" data-value="1" onclick="setStar(1)" style="font-size:26px;cursor:pointer;transition:transform 0.2s;color:#ddd;">★</span>
                            <span class="star" data-value="2" onclick="setStar(2)" style="font-size:26px;cursor:pointer;transition:transform 0.2s;color:#ddd;">★</span>
                            <span class="star" data-value="3" onclick="setStar(3)" style="font-size:26px;cursor:pointer;transition:transform 0.2s;color:#ddd;">★</span>
                            <span class="star" data-value="4" onclick="setStar(4)" style="font-size:26px;cursor:pointer;transition:transform 0.2s;color:#ddd;">★</span>
                            <span class="star" data-value="5" onclick="setStar(5)" style="font-size:26px;cursor:pointer;transition:transform 0.2s;color:#ddd;">★</span>
                        </div>
                    </div>
                    <div class="form-field" style="margin-bottom:12px;">
                        <textarea id="reviewContent" rows="3" placeholder="分享您的观演体验..." style="resize:none;"></textarea>
                    </div>
                    <button class="btn-primary-custom" onclick="submitReview()" style="padding:10px 24px;">
                        <i class="fas fa-paper-plane"></i> 发布评价
                    </button>
                </div>
                <% } else { %>
                <div style="background:#f8f9fa;border-radius:var(--radius-sm);padding:16px;text-align:center;margin-bottom:24px;">
                    <p style="margin:0;color:var(--text-secondary);font-size:14px;">
                        <a href="login.jsp?redirect=show-detail?id=<%= show.getId() %>" style="color:var(--primary-start);font-weight:600;text-decoration:none;">登录</a> 后即可发表评价
                    </p>
                </div>
                <% } %>

                <div id="reviewsList"></div>
            </div>
        </div>

        <div class="detail-right animate-fade-in-up" style="animation-delay:0.2s;">
            <div class="dashboard-section" style="border-radius:var(--radius-md);padding:24px;position:sticky;top:80px;">
                <div style="text-align:center;margin-bottom:20px;padding:20px;background:linear-gradient(135deg,rgba(255,107,53,0.08),rgba(155,89,182,0.08));border-radius:var(--radius-md);">
                    <div style="font-size:13px;color:var(--text-secondary);margin-bottom:4px;">票价</div>
                    <div style="font-size:38px;font-weight:800;color:var(--primary-start);">¥<%= show.getPrice() %></div>
                    <div style="font-size:12px;color:var(--text-secondary);margin-top:4px;">每张</div>
                </div>

                <div class="form-field" style="margin-bottom:16px;">
                    <label>购票数量</label>
                    <div style="display:flex;align-items:center;gap:12px;">
                        <button onclick="changeQty(-1)" style="width:42px;height:42px;border:2px solid var(--border-light);background:white;border-radius:var(--radius-sm);cursor:pointer;font-size:18px;font-weight:700;transition:all 0.25s;" onmouseover="this.style.borderColor='var(--primary-start)'" onmouseout="this.style.borderColor='var(--border-light)'">−</button>
                        <input type="number" id="ticketQty" value="1" min="1" max="<%= Math.min(show.getAvailableTickets(), 6) %>" style="flex:1;height:42px;text-align:center;border:2px solid var(--border-light);border-radius:var(--radius-sm);font-size:18px;font-weight:700;">
                        <button onclick="changeQty(1)" style="width:42px;height:42px;border:2px solid var(--border-light);background:white;border-radius:var(--radius-sm);cursor:pointer;font-size:18px;font-weight:700;transition:all 0.25s;" onmouseover="this.style.borderColor='var(--primary-start)'" onmouseout="this.style.borderColor='var(--border-light)'">+</button>
                    </div>
                </div>

                <div style="background:#f8f9fa;padding:14px;border-radius:var(--radius-sm);margin-bottom:20px;">
                    <div style="display:flex;justify-content:space-between;margin-bottom:6px;font-size:14px;">
                        <span style="color:var(--text-secondary);">票价 × <span id="qtyLabel">1</span>张</span>
                        <span>¥<%= show.getPrice() %></span>
                    </div>
                    <div style="display:flex;justify-content:space-between;padding-top:10px;border-top:1px solid #e0e0e0;font-size:16px;font-weight:700;">
                        <span>合计</span>
                        <span style="color:var(--primary-start);" id="totalPrice">¥<%= show.getPrice() %></span>
                    </div>
                </div>

                <% if (show.getAvailableTickets() > 0) { %>
                <% if (user != null) { %>
                <button class="btn-primary-custom" style="width:100%;justify-content:center;padding:14px;font-size:16px;" onclick="goToBook()">
                    <i class="fas fa-ticket-alt"></i> 立即预订
                </button>
                <% } else { %>
                <a href="login.jsp?redirect=show-detail?id=<%= show.getId() %>" class="btn-primary-custom" style="width:100%;justify-content:center;padding:14px;font-size:16px;">
                    <i class="fas fa-sign-in-alt"></i> 登录后预订
                </a>
                <% } %>
                <% } else { %>
                <button disabled style="width:100%;padding:14px;background:#dfe6e9;color:var(--text-secondary);border:none;border-radius:25px;font-size:16px;font-weight:600;cursor:not-allowed;">
                    <i class="fas fa-ban"></i> 已售罄
                </button>
                <% } %>

                <div style="margin-top:18px;padding-top:18px;border-top:1px solid var(--border-light);">
                    <div style="font-size:12px;color:var(--text-secondary);line-height:1.8;">
                        <p style="margin:4px 0;">✅ 电子票，无需取票</p>
                        <p style="margin:4px 0;">✅ 开演前可申请退票</p>
                        <p style="margin:4px 0;">✅ 票品一经售出概不换座</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="js/main.js"></script>
<script>
const SHOW_ID = '<%= show.getId() %>';
const PRICE = <%= show.getPrice() %>;
const MAX_QTY = <%= Math.min(show.getAvailableTickets(), 6) %>;
const SHOW_TIME = '<%= show.getShowTime() %>';

function changeQty(delta) {
    const input = document.getElementById('ticketQty');
    let val = parseInt(input.value) + delta;
    if (val < 1) val = 1;
    if (val > MAX_QTY) {
        Toast.warning(`最多可购买${MAX_QTY}张`);
        val = MAX_QTY;
    }
    input.value = val;
    updateTotal();
}

function updateTotal() {
    const qty = parseInt(document.getElementById('ticketQty').value);
    document.getElementById('qtyLabel').textContent = qty;
    document.getElementById('totalPrice').textContent = '¥' + (PRICE * qty).toFixed(2);
}

document.getElementById('ticketQty').addEventListener('input', updateTotal);

function goToBook() {
    const qty = parseInt(document.getElementById('ticketQty').value);
    window.location.href = `order.jsp?id=${SHOW_ID}&qty=${qty}`;
}

function shareShow() {
    if (navigator.share) {
        navigator.share({
            title: '<%= show.getTitle() %>',
            text: '来看看这场精彩的脱口秀演出！',
            url: window.location.href
        });
    } else {
        navigator.clipboard.writeText(window.location.href).then(() => {
            Toast.success('链接已复制到剪贴板');
        });
    }
}

function toggleFavorite(btn) {
    btn.classList.toggle('favorited');
    if (btn.classList.contains('favorited')) {
        btn.innerHTML = '🧡';
        Toast.success('已添加到收藏');
    } else {
        btn.innerHTML = '❤️';
        Toast.info('已取消收藏');
    }
}

function initCountdown() {
    if (!SHOW_TIME) return;
    const targetTime = new Date(SHOW_TIME.replace(/-/g, '/')).getTime();
    if (isNaN(targetTime)) return;
    const now = new Date().getTime();
    const diffHours = (targetTime - now) / (1000 * 60 * 60);
    if (diffHours > 0 && diffHours <= 72) {
        const badge = document.getElementById('mainCountdown');
        badge.style.display = '';
        setInterval(() => updateCountdown(badge, targetTime), 1000);
        updateCountdown(badge, targetTime);
    }
}

function updateCountdown(el, target) {
    const now = new Date().getTime();
    const diff = target - now;
    if (diff <= 0) {
        el.querySelector('.cd-text').textContent = '已开始';
        return;
    }
    const h = Math.floor(diff / (1000 * 60 * 60));
    const m = Math.floor((diff % (1000 * 60 * 60)) / (1000 * 60));
    const s = Math.floor((diff % (1000 * 60)) / 1000);
    el.querySelector('.cd-text').textContent = `${h.toString().padStart(2,'0')}:${m.toString().padStart(2,'0')}:${s.toString().padStart(2,'0')} 后开演`;
}

document.addEventListener('DOMContentLoaded', () => {
    initCountdown();
    loadReviews();
});

let currentRating = 0;

function setStar(value) {
    currentRating = value;
    document.getElementById('starRating').dataset.rating = value;
    document.querySelectorAll('#starRating .star').forEach((star, idx) => {
        star.style.color = idx < value ? '#F7C948' : '#ddd';
        if (idx < value) star.style.transform = 'scale(1.2)';
        else star.style.transform = 'scale(1)';
    });
}

function submitReview() {
    const content = document.getElementById('reviewContent').value.trim();
    if (currentRating === 0) {
        Toast.warning('请选择评分');
        return;
    }
    if (content.length < 5) {
        Toast.warning('评价内容至少5个字');
        return;
    }

    const reviews = JSON.parse(localStorage.getItem(`reviews_${SHOW_ID}`) || '[]');
    const review = {
        id: Date.now(),
        showId: SHOW_ID,
        user: '<%= user != null ? user.getRealName() : "匿名用户" %>',
        rating: currentRating,
        content: content,
        time: new Date().toLocaleString(),
        avatar: '<%= user != null ? user.getRealName().charAt(0) : "?" %>'
    };
    reviews.unshift(review);
    localStorage.setItem(`reviews_${SHOW_ID}`, JSON.stringify(reviews));

    Toast.success('评价发布成功！');
    document.getElementById('reviewContent').value = '';
    setStar(0);
    renderReviews();
}

function loadReviews() {
    renderReviews();
}

function renderReviews() {
    const reviews = JSON.parse(localStorage.getItem(`reviews_${SHOW_ID}`) || '[]');
    const list = document.getElementById('reviewsList');
    const countEl = document.getElementById('reviewCount');
    const avgEl = document.getElementById('avgRating');

    countEl.textContent = reviews.length;

    if (reviews.length > 0) {
        const avg = reviews.reduce((sum, r) => sum + r.rating, 0) / reviews.length;
        avgEl.textContent = avg.toFixed(1);
    } else {
        avgEl.textContent = '0';
    }

    if (reviews.length === 0) {
        list.innerHTML = `
            <div style="text-align:center;padding:30px;color:var(--text-secondary);">
                <i class="fas fa-comments" style="font-size:36px;opacity:0.3;margin-bottom:10px;display:block;"></i>
                <p>暂无评价，成为第一个评价的人吧！</p>
            </div>`;
        return;
    }

    list.innerHTML = reviews.map((r, i) => `
        <div style="padding:16px;border-bottom:1px solid #f0f0f0;animation:fadeInUp 0.3s ease ${i * 0.05}s forwards;opacity:0;">
            <div style="display:flex;align-items:center;gap:12px;margin-bottom:10px;">
                <div style="width:40px;height:40px;border-radius:50%;background:var(--primary-gradient);color:white;display:flex;align-items:center;justify-content:center;font-weight:700;font-size:16px;">${r.avatar}</div>
                <div style="flex:1;">
                    <div style="font-weight:600;font-size:14px;">${r.user}</div>
                    <div style="font-size:11px;color:var(--text-secondary);">${r.time}</div>
                </div>
                <div style="display:flex;gap:2px;">
                    ${Array(5).fill(0).map((_, idx) => `<span style="${idx < r.rating ? 'color:#F7C948' : 'color:#ddd'}">★</span>`).join('')}
                </div>
            </div>
            <p style="margin:0;color:var(--text-dark);line-height:1.7;font-size:14px;padding-left:52px;">${r.content}</p>
        </div>
    `).join('');
}
</script>

<style>
.favorited { animation: heartBeat 0.4s ease; }
@keyframes heartBeat {
    0% { transform: scale(1); }
    50% { transform: scale(1.3); }
    100% { transform: scale(1); }
}
@media (max-width: 900px) {
    #detailGrid { grid-template-columns: 1fr !important; }
    .detail-right { position: static !important; }
}
</style>
</body>
</html>