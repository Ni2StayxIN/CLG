<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>🎤 脱口秀门票预订系统</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="css/main.css" rel="stylesheet">
    <link href="css/animations.css" rel="stylesheet">
</head>
<body>

<nav class="navbar">
    <div class="nav-container">
        <a href="shows" class="logo">
            <span class="logo-icon">🎤</span>
            脱口秀门票预订
        </a>
        <div class="hamburger"><span></span><span></span><span></span></div>
        <div class="nav-links">
            <a href="shows" class="nav-link active">脱口秀演出</a>
            <a href="shows?filter=hot" class="nav-link">热门推荐</a>
            <a href="shows?filter=soon" class="nav-link">即将开始</a>
            <a href="orders" class="nav-link">我的订单</a>
            <a href="refunds" class="nav-link">退票记录</a>
        </div>
        <div class="user-section">
            <c:choose>
                <c:when test="${not empty sessionScope.username}">
                    <div class="user-info">
                        <div class="user-avatar">${sessionScope.realName.charAt(0)}</div>
                        <span>${sessionScope.realName}</span>
                    </div>
                    <c:if test="${sessionScope.userType == 'admin'}">
                        <a href="admin" class="btn-primary-custom" style="padding: 6px 14px; font-size:12px; text-decoration:none;">⚙️ 后台</a>
                    </c:if>
                    <button class="btn-primary-custom logout-btn" onclick="doLogout()" style="padding: 6px 14px; font-size:12px;">退出</button>
                </c:when>
                <c:otherwise>
                    <a href="login.jsp" class="nav-link">登录</a>
                    <a href="register.jsp" class="btn-primary-custom" style="padding: 6px 16px; font-size:12px;">注册</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</nav>

<div class="main-container">
    <div class="page-header animate-fade-in-up">
        <h1 class="page-title">🎤 脱口秀门票预订</h1>
        <p class="page-subtitle">精选热门脱口秀演出，欢乐时光从这里开始</p>
    </div>

    <div class="filter-section animate-fade-in-up" style="animation-delay:0.1s">
        <h3 class="filter-title">筛选演出</h3>
        <div class="filter-tabs">
            <button class="filter-tab active" data-filter="all">📋 全部</button>
            <button class="filter-tab" data-filter="available">✅ 可预订</button>
            <button class="filter-tab" data-filter="soon">⏰ 即将开始</button>
            <button class="filter-tab" data-filter="soldout">❌ 已售罄</button>
        </div>
        <div class="search-box">
            <span>🔍</span>
            <input type="text" placeholder="搜索演出名称、演员或城市..." id="searchInput">
        </div>
    </div>

    <div style="display:grid; grid-template-columns:1fr 300px; gap:26px;">
        <div class="shows-grid stagger" id="showsGrid">
            <c:choose>
                <c:when test="${not empty shows && shows.size() > 0}">
                    <c:forEach var="show" items="${shows}" varStatus="status">
                    <div class="show-card" data-id="${show.id}" data-title="${show.title}" data-city="${show.city}"
                         data-available="${show.availableTickets > 0}" data-showtime="${show.showTime}"
                         data-performer="${show.performer}" data-venue="${show.venue}"
                         style="animation-delay:${status.count * 0.06}s">
                        <div class="show-image-container">
                            <img src="${show.imageUrl}" alt="${show.title}" class="show-image"
                                 onerror="this.src='data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMzEwIiBoZWlnaHQ9IjIwMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48ZGVmcz48bGluZWFyR3JhZGllbnQgaWQ9ImciIHgxPSIwJSIgeTE9IjAlIiB4Mj0iMTAwJSIgeTI9IjEwMCUiPjxzdG9wIG9mZnNldD0iMCUiIHN0b3AtY29sb3I9IiNGRjZCMzUiLz48c3RvcCBvZmZzZXQ9IjEwMCUiIHN0b3AtY29sb3I9IiM5QjU5QjYiLz48L2xpbmVhckdyYWRpZW50PjwvZGVmcz48cmVjdCB3aWR0aD0iMTAwJSIgaGVpZ2h0PSIxMDAlIiBmaWxsPSJ1cmwoI2cpIi8+PHRleHQgeD0iNTAlIiB5PSI1MCUiIGZvbnQtZmFtaWx5PSJBcmlhbCIgZm9udC1zaXplPSIxNCIgZmlsbD0id2hpdGUiIHRleHQtYW5jaG9yPSJtaWRkbGUiIGR5PSIuM2VtIj7nu4fljZXlr77lrovlrpw8L3RleHQ+PC9zdmc+'">

                            <c:choose>
                                <c:when test="${show.availableTickets == 0}">
                                    <div class="show-tag sold-out">已售罄</div>
                                </c:when>
                                <c:when test="${show.availableTickets < 100}">
                                    <div class="show-tag soon">即将售罄</div>
                                </c:when>
                                <c:otherwise>
                                    <div class="show-tag">热卖中</div>
                                </c:otherwise>
                            </c:choose>

                            <div class="countdown-badge" id="countdown-${show.id}" style="display:none;">
                                ⏱️ <span class="cd-text"></span>
                            </div>
                        </div>

                        <div class="show-info">
                            <h3 class="show-title">${show.title}</h3>
                            <c:if test="${not empty show.performer}">
                                <div class="show-performer"><span>🎭</span> 主演：${show.performer}</div>
                            </c:if>
                            <div class="show-location"><span>📍</span> ${show.city} · ${show.venue}</div>
                            <div class="show-time"><span>⏰</span> ${show.showTime}</div>
                            <div class="show-price">¥${show.price}</div>
                            <div class="show-actions">
                                <c:choose>
                                    <c:when test="${show.availableTickets > 0}">
                                        <span class="ticket-status available">剩余${show.availableTickets}张</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="ticket-status sold_out">已售罄</span>
                                    </c:otherwise>
                                </c:choose>
                                <c:choose>
                                    <c:when test="${empty sessionScope.userId}">
                                        <button class="btn-primary-custom login-required" onclick="showLoginToast()">
                                            🔒 登录购票
                                        </button>
                                    </c:when>
                                    <c:otherwise>
                                        <c:choose>
                                            <c:when test="${show.availableTickets == 0}">
                                                <button class="btn-primary-custom" disabled>❌ 已售罄</button>
                                            </c:when>
                                            <c:otherwise>
                                                <a href="show-detail?id=${show.id}" class="btn-primary-custom">🎟️ 立即购票</a>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <c:if test="${not empty dbError}">
                        <div class="empty-state" style="background:linear-gradient(135deg,rgba(247,201,72,0.15),rgba(255,165,2,0.08));border-radius:var(--radius-md);padding:40px;">
                            <svg class="empty-svg" viewBox="0 0 200 160" fill="none"><circle cx="100" cy="70" r="45" stroke="#F7C948" stroke-width="3" fill="#FFF9E6"/><path d="M85 68l10 10 20-22" stroke="#F7C948" stroke-width="4" stroke-linecap="round" stroke-linejoin="round"/><line x1="60" y1="130" x2="140" y2="130" stroke="#F7C948" stroke-width="2" stroke-linecap="round"/><text x="100" y="152" text-anchor="middle" fill="#636E72" font-size="11">${dbError}</text></svg>
                            <h3 class="empty-title" style="color:#B8860B">数据库连接失败</h3>
                            <p class="empty-desc">请确保MySQL服务已启动，并已创建 standup_comedy 数据库</p>
                        </div>
                    </c:if>
                    <c:if test="${empty dbError}">
                        <div class="empty-state">
                            <svg class="empty-svg" viewBox="0 0 200 160" fill="none"><rect x="30" y="20" width="140" height="100" rx="12" fill="#FDF8F5" stroke="#FF6B35" stroke-width="2"/><circle cx="75" cy="55" r="18" fill="none" stroke="#FF6B35" stroke-width="2"/><circle cx="125" cy="55" r="18" fill="none" stroke="#9B59B6" stroke-width="2"/><path d="M65 62l8-8 16 16M119 47l12 16" stroke-width="2" stroke-linecap="round"/><rect x="50" y="88" width="100" height="20" rx="4" fill="#EEE"/><text x="100" y="102" text-anchor="middle" fill="#999" font-size="10">暂无演出</text></svg>
                            <h3 class="empty-title">暂无演出信息</h3>
                            <p class="empty-desc">当前没有可预订的脱口秀演出，请稍后再查看</p>
                            <c:if test="${not empty errorMessage}">
                                <p style="color:var(--accent-red);margin-top:8px;font-size:13px;">${errorMessage}</p>
                            </c:if>
                        </div>
                    </c:if>
                </c:otherwise>
            </c:choose>

            <c:if test="${empty sessionScope.userId}">
                <div class="login-prompt animate-fade-in-up" style="animation-delay:0.3s">
                    <h3>登录后可进行购票操作</h3>
                    <p>请先登录系统以查看详细信息并进行购票</p>
                    <a href="login.jsp" class="btn-primary-custom" style="display:inline-block;padding:12px 32px;font-size:15px;">立即登录</a>
                    <div class="test-accounts">
                        <p><strong>💡 测试账号</strong></p>
                        <p>管理员：admin / 123456</p>
                    </div>
                </div>
            </c:if>
        </div>

        <div class="hot-rank-section animate-fade-in-up" style="animation-delay:0.2s;height:fit-content;display:none;" id="hotRankSection">
            <div class="hot-rank-header">🔥 热门排行</div>
            <div id="hotRankList"></div>
        </div>
    </div>
</div>

<script src="js/main.js"></script>
<script>
function showLoginToast() { Toast.warning('请先登录系统！'); setTimeout(() => window.location.href = 'login.jsp', 800); }
function doLogout() {
    if (confirm('确定要退出登录吗？')) { window.location.href = 'login?action=logout'; }
}

document.addEventListener('DOMContentLoaded', function() {
    const filterTabs = document.querySelectorAll('.filter-tab');
    const showCards = document.querySelectorAll('.show-card');
    const searchInput = document.getElementById('searchInput');

    const urlParams = new URLSearchParams(window.location.search);
    const urlFilter = urlParams.get('filter');
    if (urlFilter) {
        filterTabs.forEach(t => { t.classList.toggle('active', t.dataset.filter === urlFilter); });
        applyFilter(urlFilter);
    }

    filterTabs.forEach(tab => tab.addEventListener('click', function() {
        filterTabs.forEach(t => t.classList.remove('active'));
        this.classList.add('active');
        applyFilter(this.dataset.filter);
    }));

    function applyFilter(filter) {
        showCards.forEach(card => {
            const avail = card.dataset.available === 'true';
            let show = true;
            if (filter === 'available') show = avail;
            else if (filter === 'soldout') show = !avail;
            else if (filter === 'soon') show = !!card.querySelector('.soon');
            card.style.display = show ? '' : 'none';
        });
    }

    let searchTimer;
    searchInput.addEventListener('input', function() {
        clearTimeout(searchTimer);
        searchTimer = setTimeout(() => {
            const q = this.value.toLowerCase().trim();
            showCards.forEach(card => {
                const title = (card.dataset.title || '').toLowerCase();
                const city = (card.dataset.city || '').toLowerCase();
                card.style.display = (!q || title.includes(q) || city.includes(q)) ? '' : 'none';
            });
        }, 250);
    });

    initCountdowns();
    buildHotRanking();

    // 点击演出卡片弹出详情弹窗
    showCards.forEach(function(card) {
        card.addEventListener('click', function(e) {
            // 如果点击的是按钮或链接，不触发弹窗
            if (e.target.closest('.btn-primary-custom, a')) return;
            showDetailModal(this);
        });
    });
});

function showDetailModal(card) {
    var id = card.dataset.id;
    var title = card.dataset.title;
    var performer = card.dataset.performer || '待公布';
    var city = card.dataset.city;
    var venue = card.dataset.venue || '';
    var timeEl = card.querySelector('.show-time');
    var time = timeEl ? timeEl.textContent.replace('⏰', '').trim() : '';
    var priceEl = card.querySelector('.show-price');
    var price = priceEl ? priceEl.textContent : '';
    var imgEl = card.querySelector('.show-image');
    var img = imgEl ? imgEl.src : '';
    var statusEl = card.querySelector('.ticket-status');
    var tickets = statusEl ? statusEl.textContent : '';

    document.getElementById('modalImage').src = img;
    document.getElementById('modalTitle').textContent = title;
    document.getElementById('modalPerformer').textContent = '🎭 主演：' + performer;
    document.getElementById('modalLocation').textContent = '📍 ' + city + (venue ? ' · ' + venue : '');
    document.getElementById('modalTime').textContent = '⏰ ' + time;
    document.getElementById('modalPrice').textContent = price;
    document.getElementById('modalTickets').textContent = tickets;
    document.getElementById('modalBuyBtn').onclick = function() {
        var loginBtn = card.querySelector('.login-required');
        var buyLink = card.querySelector('a[href*="show-detail"]');
        if (loginBtn) {
            showLoginToast();
        } else if (buyLink) {
            window.location.href = buyLink.getAttribute('href');
        }
        closeDetailModal();
    };
    document.getElementById('detailModal').style.display = 'flex';
}

function closeDetailModal() {
    document.getElementById('detailModal').style.display = 'none';
}

function initCountdowns() {
    const cards = document.querySelectorAll('.show-card[data-showtime]');
    const now = new Date().getTime();
    cards.forEach(card => {
        const timeStr = card.dataset.showtime;
        if (!timeStr) return;
        const showTime = new Date(timeStr.replace(/-/g, '/')).getTime();
        if (isNaN(showTime)) return;
        const diffHours = (showTime - now) / (1000 * 60 * 60);
        if (diffHours > 0 && diffHours <= 72) {
            const badge = card.querySelector('#countdown-' + card.dataset.id);
            if (badge) {
                badge.style.display = '';
                updateCountdown(badge, showTime);
                setInterval(() => updateCountdown(badge, showTime), 1000);
            }
        }
    });
}

function updateCountdown(el, target) {
    const diff = target - new Date().getTime();
    if (diff <= 0) { el.innerHTML = '⏰ 已开始'; el.style.background = '#00b894'; return; }
    const d = Math.floor(diff / 86400000), h = Math.floor((diff % 86400000) / 3600000);
    const m = Math.floor((diff % 3600000) / 60000), s = Math.floor((diff % 60000) / 1000);
    el.querySelector('.cd-text').textContent =
        (d > 0 ? d + '天 ' : '') + String(h).padStart(2,'0') + ':' + String(m).padStart(2,'0') + ':' + String(s).padStart(2,'0');
}

function buildHotRanking() {
    var cards = Array.from(document.querySelectorAll('.show-card'));
    if (cards.length === 0) return;
    // 二狗(id=11)置顶，再随机取4个
    var ergou = null;
    var others = [];
    cards.forEach(function(c) {
        if (c.dataset.id === '11') {
            ergou = c;
        } else {
            others.push(c);
        }
    });
    // 随机打乱并取前4个
    others.sort(function() { return Math.random() - 0.5; });
    var picked = others.slice(0, 4);
    if (ergou) picked.unshift(ergou);
    var ranked = picked.map(function(c) {
        var statusEl = c.querySelector('.ticket-status');
        var match = statusEl ? statusEl.textContent.match(/\d+/) : null;
        return {
            el: c,
            title: c.dataset.title || '',
            total: match ? parseInt(match[0]) : 999,
            price: c.querySelector('.show-price') ? c.querySelector('.show-price').textContent : '',
            img: c.querySelector('.show-image') ? c.querySelector('.show-image').src : ''
        };
    });

    const section = document.getElementById('hotRankSection');
    const list = document.getElementById('hotRankList');
    section.style.display = '';
    list.innerHTML = '';
    ranked.forEach(function(item, i) {
        const numClass = i === 0 ? 'top1' : i === 1 ? 'top2' : i === 2 ? 'top3' : 'normal';
        const numText = i + 1;
        const div = document.createElement('div');
        div.className = 'hot-rank-item';
        div.innerHTML = '<div class="hot-rank-num ' + numClass + '">' + numText + '</div>' +
            '<img class="hot-rank-thumb" src="' + item.img + '" alt="" onerror="this.style.background=\'linear-gradient(135deg,#FF6B35,#9B59B6)\'">' +
            '<div class="hot-rank-info"><div class="hot-rank-name">' + item.title + '</div><div class="hot-rank-meta">' + item.price + '</div></div>' +
            '<span class="hot-rank-score">🔥' + (5 - i) + '.0</span>';
        div.onclick = function() { item.el.scrollIntoView({ behavior:'smooth', block:'center' }); };
        div.style.animation = 'fadeInUp 0.35s ease ' + (i * 0.08) + 's forwards';
        div.style.opacity = '0';
        list.appendChild(div);
    });
}
</script>
<!-- 演出详情弹窗 -->
<div class="modal-overlay" id="detailModal" onclick="if(event.target===this)closeDetailModal()">
    <div class="modal-content detail-modal-content">
        <button class="modal-close" onclick="closeDetailModal()">&times;</button>
        <div class="detail-modal-body">
            <div class="detail-modal-image">
                <img id="modalImage" src="" alt="">
            </div>
            <div class="detail-modal-info">
                <h2 id="modalTitle" class="detail-modal-title"></h2>
                <div id="modalPerformer" class="detail-modal-field"></div>
                <div id="modalLocation" class="detail-modal-field"></div>
                <div id="modalTime" class="detail-modal-field"></div>
                <div class="detail-modal-row">
                    <span id="modalPrice" class="detail-modal-price"></span>
                    <span id="modalTickets" class="detail-modal-tickets"></span>
                </div>
                <button id="modalBuyBtn" class="btn-primary-custom detail-modal-btn">立即购票</button>
            </div>
        </div>
    </div>
</div>

<style>
.modal-overlay {
    display: none; position: fixed; inset: 0; background: rgba(0,0,0,0.6);
    z-index: 2000; align-items: center; justify-content: center;
    animation: fadeIn 0.2s ease;
}
.detail-modal-content {
    background: white; border-radius: var(--radius-lg); max-width: 700px;
    width: 92%; max-height: 85vh; overflow-y: auto; position: relative;
    animation: scaleIn 0.3s ease;
}
.modal-close {
    position: absolute; top: 12px; right: 16px; font-size: 28px; cursor: pointer;
    background: none; border: none; color: var(--text-secondary); z-index: 10;
    width: 36px; height: 36px; display: flex; align-items: center; justify-content: center;
    border-radius: 50%; transition: all 0.2s;
}
.modal-close:hover { background: var(--bg-warm); color: var(--text-dark); }
.detail-modal-body { display: flex; }
.detail-modal-image { width: 40%; flex-shrink: 0; }
.detail-modal-image img { width: 100%; height: 100%; object-fit: cover; display: block; }
.detail-modal-info { padding: 28px; flex: 1; }
.detail-modal-title { font-size: 22px; font-weight: 800; color: var(--text-dark); margin-bottom: 16px; line-height: 1.3; }
.detail-modal-field { font-size: 15px; color: var(--text-secondary); margin-bottom: 10px; }
.detail-modal-row { display: flex; align-items: center; justify-content: space-between; margin: 18px 0; }
.detail-modal-price { font-size: 26px; font-weight: 800; background: var(--primary-gradient); -webkit-background-clip: text; -webkit-text-fill-color: transparent; background-clip: text; }
.detail-modal-tickets { font-size: 14px; font-weight: 600; color: #00b894; }
.detail-modal-btn { width: 100%; padding: 14px; font-size: 16px; justify-content: center; }
@media (max-width: 600px) {
    .detail-modal-body { flex-direction: column; }
    .detail-modal-image { width: 100%; max-height: 200px; }
}
</style>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
