<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>🍔 锋味汉堡演唱会 - 抢票系统</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome@6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        /* 全局样式 */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "PingFang SC", "Microsoft YaHei", sans-serif;
            background-color: #f5f5f5;
            color: #333;
            line-height: 1.6;
        }

        /* 导航栏样式 */
        .navbar {
            background-color: white;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            padding: 15px 0;
            position: sticky;
            top: 0;
            z-index: 1000;
        }
        
        .nav-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .logo {
            text-decoration: none;
            color: #ff4757;
            font-size: 24px;
            font-weight: bold;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .logo-icon {
            font-size: 32px;
        }
        
        .nav-links {
            display: flex;
            gap: 20px;
        }
        
        .nav-link {
            text-decoration: none;
            color: #333;
            font-size: 16px;
            padding: 8px 16px;
            border-radius: 5px;
            transition: all 0.3s;
        }
        
        .nav-link:hover,
        .nav-link.active {
            color: #ff4757;
            background-color: #fff5f5;
        }
        
        .user-section {
            display: flex;
            align-items: center;
            gap: 15px;
        }
        
        .user-info {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .user-avatar {
            width: 36px;
            height: 36px;
            background-color: #ff4757;
            color: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
        }
        
        .logout-btn {
            background-color: #747d8c;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 5px;
            cursor: pointer;
            transition: background 0.3s;
        }
        
        .logout-btn:hover {
            background-color: #57606f;
        }

        /* 主内容区样式 */
        .main-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        
        .page-header {
            text-align: center;
            margin-bottom: 40px;
            padding: 40px 0;
        }
        
        .page-title {
            font-size: 36px;
            font-weight: bold;
            color: #333;
            margin-bottom: 10px;
        }
        
        .page-subtitle {
            font-size: 18px;
            color: #666;
        }

        /* 筛选栏样式 */
        .filter-section {
            background: white;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 30px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }
        
        .filter-title {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 15px;
        }
        
        .filter-tabs {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
            flex-wrap: wrap;
        }
        
        .filter-tab {
            padding: 8px 16px;
            border: 1px solid #ddd;
            background-color: white;
            border-radius: 5px;
            cursor: pointer;
            transition: all 0.3s;
        }
        
        .filter-tab:hover {
            border-color: #ff4757;
            color: #ff4757;
        }
        
        .filter-tab.active {
            background-color: #ff4757;
            color: white;
            border-color: #ff4757;
        }
        
        .search-box {
            position: relative;
        }
        
        .search-box span {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #999;
        }
        
        .search-box input {
            width: 100%;
            padding: 12px 45px;
            border: 1px solid #ddd;
            border-radius: 30px;
            font-size: 16px;
            transition: border-color 0.3s;
        }
        
        .search-box input:focus {
            outline: none;
            border-color: #ff4757;
        }

        /* 演唱会网格样式 */
        .concerts-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 30px;
        }
        
        .concert-card {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
            transition: transform 0.3s, box-shadow 0.3s;
        }
        
        .concert-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.12);
        }
        
        .concert-image-container {
            position: relative;
            height: 200px;
            overflow: hidden;
        }
        
        .concert-image {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.5s;
        }
        
        .concert-card:hover .concert-image {
            transform: scale(1.05);
        }
        
        .concert-tag {
            position: absolute;
            top: 15px;
            right: 15px;
            background-color: #ff4757;
            color: white;
            padding: 5px 15px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: bold;
        }
        
        .concert-tag.sold-out {
            background-color: #747d8c;
        }
        
        .concert-tag.soon {
            background-color: #ffa502;
        }
        
        .concert-info {
            padding: 20px;
        }
        
        .concert-title {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 10px;
            color: #333;
            overflow: hidden;
            text-overflow: ellipsis;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
        }
        
        .concert-location,
        .concert-time {
            font-size: 14px;
            color: #666;
            margin-bottom: 8px;
            display: flex;
            align-items: center;
            gap: 5px;
        }
        
        .concert-price {
            font-size: 20px;
            font-weight: bold;
            color: #ff4757;
            margin: 15px 0;
        }
        
        .concert-actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 15px;
        }
        
        .ticket-status {
            font-size: 14px;
        }
        
        .ticket-status.available {
            color: #2ed573;
            font-weight: bold;
        }
        
        .ticket-status.sold-out {
            color: #747d8c;
        }
        
        .book-btn {
            background-color: #ff4757;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 5px;
            cursor: pointer;
            transition: background 0.3s;
            text-decoration: none;
            font-size: 14px;
            display: inline-flex;
            align-items: center;
            gap: 5px;
        }
        
        .book-btn:hover {
            background-color: #ff3838;
            color: white;
        }
        
        .book-btn:disabled {
            background-color: #ccc;
            cursor: not-allowed;
        }
        
        .book-btn.login-required {
            background-color: #ffa502;
        }
        
        .book-btn.login-required:hover {
            background-color: #ff8c00;
        }

        /* 空状态样式 */
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            grid-column: 1 / -1;
        }
        
        .empty-icon {
            font-size: 64px;
            margin-bottom: 20px;
        }
        
        .empty-text {
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 10px;
            color: #333;
        }
        
        .empty-state p {
            color: #666;
            font-size: 16px;
        }

        /* 登录提示样式 */
        .login-prompt {
            background-color: #fff5f5;
            border: 2px solid #ff4757;
            border-radius: 15px;
            padding: 30px;
            text-align: center;
            grid-column: 1 / -1;
        }
        
        .login-prompt h3 {
            font-size: 24px;
            color: #333;
            margin-bottom: 10px;
        }
        
        .login-prompt p {
            color: #666;
            margin-bottom: 20px;
        }
        
        .login-btn {
            background-color: #ff4757;
            color: white;
            padding: 12px 30px;
            border-radius: 5px;
            text-decoration: none;
            font-weight: bold;
            transition: background 0.3s;
        }
        
        .login-btn:hover {
            background-color: #ff3838;
            color: white;
        }
        
        .test-accounts {
            margin-top: 20px;
            padding: 15px;
            background-color: #f8f9fa;
            border-radius: 10px;
            font-size: 14px;
            color: #666;
        }

        /* 响应式设计 */
        @media (max-width: 768px) {
            .nav-container {
                flex-direction: column;
                gap: 15px;
            }
            
            .nav-links {
                justify-content: center;
                flex-wrap: wrap;
            }
            
            .page-title {
                font-size: 28px;
            }
            
            .concerts-grid {
                grid-template-columns: 1fr;
                gap: 20px;
            }
            
            .concert-card {
                margin-bottom: 20px;
            }
        }
    </style>
</head>
<body>
<!-- 顶部导航栏 -->
<nav class="navbar">
    <div class="nav-container">
        <a href="concerts" class="logo">
            <span class="logo-icon"></span>
            🍔 锋味汉堡演唱会
        </a>

        <div class="nav-links">
            <a href="concerts" class="nav-link">演唱会</a>
            <a href="concerts?filter=hot" class="nav-link">热门推荐</a>
            <a href="concerts?filter=soon" class="nav-link">即将开始</a>
            <a href="concerts?filter=orders" class="nav-link">我的订单</a>
        </div>

        <div class="user-section">
            <c:choose>
                <c:when test="${not empty sessionScope.username}">
                    <div class="user-info">
                        <div class="user-avatar">${sessionScope.realName.charAt(0)}</div>
                        <span>${sessionScope.realName}</span>
                    </div>
                    <button class="logout-btn" onclick="logout()">退出</button>
                </c:when>
                <c:otherwise>
                    <a href="login" class="nav-link">登录</a>
                    <a href="register" class="book-btn" style="padding: 8px 16px;">注册</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</nav>

<!-- 主内容区 -->
<div class="main-container">
    <!-- 页面标题 -->
    <div class="page-header">
        <h1 class="page-title">🍔 锋味汉堡演唱会</h1>
        <p class="page-subtitle">精选全球热门演唱会，提供便捷订票服务</p>
    </div>

    <!-- 筛选栏 -->
    <div class="filter-section">
        <h3 class="filter-title">筛选演唱会</h3>

        <div class="filter-tabs">
            <button class="filter-tab active" data-filter="all">全部</button>
            <button class="filter-tab" data-filter="available">可预订</button>
            <button class="filter-tab" data-filter="soon">即将开始</button>
            <button class="filter-tab" data-filter="soldout">已售罄</button>
        </div>

        <div class="search-box">
            <span>🔍</span>
            <input type="text" placeholder="搜索演唱会名称或城市..." id="searchInput">
        </div>
    </div>

    <!-- 演唱会列表 -->
    <div class="concerts-grid">
        <c:choose>
            <c:when test="${not empty concerts && concerts.size() > 0}">
                <c:forEach var="concert" items="${concerts}" varStatus="status">
                    <div class="concert-card" data-id="${concert.id}" data-title="${concert.title}" data-city="${concert.city}" data-available="${concert.availableTickets > 0}">
                        <div class="concert-image-container">
                            <img src="${concert.imageUrl}" alt="${concert.title}" class="concert-image"
                                 onerror="this.src='data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjgwIiBoZWlnaHQ9IjE4MCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48cmVjdCB3aWR0aD0iMTAwJSIgaGVpZ2h0PSIxMDAlIiBmaWxsPSIjZGRkIi8+PHRleHQgeD0iNTAlIiB5PSI1MCUiIGZvbnQtZmFtaWx5PSJBcmlhbCIgZm9udC1zaXplPSIxNCIgZmlsbD0iIzk5OSIgdGV4dC1hbmNob3I9Im1pZGRsZSIgZHk9Ii4zZW0iPuWbvueJh+Wkp+WtpjwvdGV4dD48L3N2Zz4='">

                            <c:choose>
                                <c:when test="${concert.availableTickets == 0}">
                                    <div class="concert-tag sold-out">已售罄</div>
                                </c:when>
                                <c:when test="${concert.availableTickets < 100}">
                                    <div class="concert-tag soon">即将售罄</div>
                                </c:when>
                                <c:otherwise>
                                    <div class="concert-tag">热卖中</div>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <div class="concert-info">
                            <h3 class="concert-title">${concert.title}</h3>

                            <div class="concert-location">
                                <span>📍</span>
                                <span>${concert.city} · ${concert.venue}</span>
                            </div>

                            <div class="concert-time">
                                <span>⏰</span>
                                <span>${concert.concertTime}</span>
                            </div>

                            <div class="concert-price">¥${concert.price}</div>

                            <div class="concert-actions">
                                <c:choose>
                                    <c:when test="${concert.availableTickets > 0}">
                                        <span class="ticket-status available">剩余${concert.availableTickets}张</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="ticket-status sold-out">已售罄</span>
                                    </c:otherwise>
                                </c:choose>

                                <c:choose>
                                    <c:when test="${empty sessionScope.userId}">
                                        <button class="book-btn login-required" onclick="showLoginAlert()">
                                            <span>🔒</span>
                                            登录购票
                                        </button>
                                    </c:when>
                                    <c:when test="${sessionScope.userType eq 'student'}">
                                        <c:choose>
                                            <c:when test="${concert.availableTickets == 0}">
                                                <button class="book-btn" disabled>
                                                    <span>❌</span>
                                                    已售罄
                                                </button>
                                            </c:when>
                                            <c:otherwise>
                                                <a href="concert-detail?id=${concert.id}" class="book-btn">
                                                    <span>🎟️</span>
                                                    立即购票
                                                </a>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:when>
                                    <c:when test="${sessionScope.userType eq 'admin'}">
                                        <button class="book-btn" style="background: #3498db;">
                                            <span>⚙️</span>
                                            管理
                                        </button>
                                    </c:when>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="empty-state">
                    <div class="empty-icon">🍔</div>
                    <h3 class="empty-text">暂无演唱会信息</h3>
                    <p>当前没有可预订的演唱会，请稍后再查看</p>
                </div>
            </c:otherwise>
        </c:choose>

        <c:if test="${empty sessionScope.userId}">
            <div class="login-prompt">
                <h3>登录后可进行购票操作</h3>
                <p>请先登录系统以查看详细信息并进行购票</p>
                <a href="login" class="login-btn">立即登录</a>
                <div class="test-accounts">
                    <p>测试账号：张三(zhangsan/123456) 李四(lisi/123456) 王五(wangwu/123456)</p>
                </div>
            </div>
        </c:if>
    </div>
</div>

<script>
    // 显示登录提示
    function showLoginAlert() {
        alert('请先登录系统！');
        window.location.href = 'login';
    }

    // 退出登录
    function logout() {
        if (confirm('确定要退出登录吗？')) {
            // 注意：这里需要添加 action=logout 参数
            window.location.href = 'login?action=logout';
        }
    }

    // 筛选功能
    document.addEventListener('DOMContentLoaded', function() {
        const filterTabs = document.querySelectorAll('.filter-tab');
        const concertCards = document.querySelectorAll('.concert-card');
        const searchInput = document.getElementById('searchInput');
        
        // 获取URL参数
        const urlParams = new URLSearchParams(window.location.search);
        const filterParam = urlParams.get('filter');
        
        // 根据URL参数设置筛选
        if (filterParam) {
            handleFilterParam(filterParam);
        } else {
            // 默认选择第一个标签
            filterTabs[0].classList.add('active');
        }

        // 处理URL筛选参数
        function handleFilterParam(param) {
            // 移除所有标签的active类
            filterTabs.forEach(t => t.classList.remove('active'));
            
            // 根据不同参数执行不同操作
            switch(param) {
                case 'hot':
                    // 热门推荐 - 显示剩余票数少的演唱会
                    filterConcerts('hot');
                    // 添加active类到相应的导航链接
                    document.querySelectorAll('.nav-link')[1].classList.add('active');
                    break;
                case 'soon':
                    // 即将开始 - 显示即将开始的演唱会
                    filterTabs[2].classList.add('active'); // 选中"即将开始"标签
                    filterConcerts('soon');
                    // 添加active类到相应的导航链接
                    document.querySelectorAll('.nav-link')[2].classList.add('active');
                    break;
                case 'orders':
                    // 我的订单 - 检查用户是否登录
                    var isLoggedIn = ${empty sessionScope.userId ? 'false' : 'true'};
                    var userType = '${sessionScope.userType != null ? sessionScope.userType : ''}';
                    
                    if (!isLoggedIn) {
                        alert('请先登录！');
                        window.location.href = 'login';
                    } else if (userType == 'student') {
                        // 学生用户跳转到订单列表页面
                        window.location.href = 'orders';
                    } else if (userType == 'admin') {
                        // 管理员跳转到管理订单页面
                        window.location.href = 'admin-orders';
                    }
                    break;
                default:
                    // 默认显示全部
                    filterTabs[0].classList.add('active');
                    filterConcerts('all');
            }
        }
        
        // 筛选标签点击事件
        filterTabs.forEach(tab => {
            tab.addEventListener('click', function() {
                // 移除所有标签的active类
                filterTabs.forEach(t => t.classList.remove('active'));
                // 给当前点击的标签添加active类
                this.classList.add('active');

                const filter = this.getAttribute('data-filter');
                filterConcerts(filter);
            });
        });

        // 搜索功能
        searchInput.addEventListener('input', function() {
            const searchTerm = this.value.toLowerCase();
            filterConcerts('search', searchTerm);
        });

        // 筛选演唱会函数
        function filterConcerts(filter, searchTerm = '') {
            concertCards.forEach(card => {
                const title = card.getAttribute('data-title').toLowerCase();
                const city = card.getAttribute('data-city').toLowerCase();
                const isAvailable = card.getAttribute('data-available') === 'true';
                const hasSoonTag = card.querySelector('.concert-tag.soon') !== null;
                const ticketStatus = card.querySelector('.ticket-status')?.textContent || '';
                
                let showCard = true;

                if (filter === 'search') {
                    showCard = title.includes(searchTerm) || city.includes(searchTerm);
                } else if (filter === 'available') {
                    showCard = isAvailable;
                } else if (filter === 'soon') {
                    // 过滤出即将开始的演唱会
                    showCard = hasSoonTag;
                } else if (filter === 'soldout') {
                    showCard = !isAvailable;
                } else if (filter === 'hot') {
                    // 热门推荐 - 模拟逻辑：剩余票数少的演唱会被认为是热门
                    const remainingTicketsMatch = ticketStatus.match(/剩余(\d+)张/);
                    if (remainingTicketsMatch) {
                        const remainingCount = parseInt(remainingTicketsMatch[1]);
                        // 剩余票数少于200的为热门
                        showCard = remainingCount < 200 && isAvailable;
                    } else {
                        showCard = false;
                    }
                }
                // 'all' 筛选器显示所有卡片

                card.style.display = showCard ? 'block' : 'none';
            });
        }
    });

    // 添加退出功能
    // const urlParams = new URLSearchParams(window.location.search);
    // if (urlParams.get('action') === 'logout') {
    //     fetch('login?action=logout', { method: 'POST' })
    //         .then(() => window.location.href = 'login');
    // }
</script>
</body>
</html>