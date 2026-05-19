<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>确认订单 - 脱口秀门票预订</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="css/main.css" rel="stylesheet">
    <link href="css/animations.css" rel="stylesheet">
    <style>
        body { background: var(--bg-warm); }
        .header {
            background: var(--primary-gradient);
            color: white;
            padding: 24px;
            text-align: center;
            position: relative;
            overflow: hidden;
        }
        .header::before { content:'';position:absolute;top:-50%;right:-20%;width:300px;height:300px;border-radius:50%;background:rgba(255,255,255,0.08);}
        .order-container { max-width: 780px; margin: 30px auto; padding: 0 20px; }
        .order-card {
            background: white;
            border-radius: var(--radius-md);
            padding: 32px;
            box-shadow: var(--shadow-md);
            animation: fadeInUp 0.5s ease;
        }
        .show-image { width: 200px; height: 150px; border-radius: var(--radius-sm); object-fit: cover; }
        .show-title { font-size: 20px; font-weight: 700; color: var(--text-dark); }
        .show-performer { color: var(--primary-start); font-size: 15px; font-weight: 600; }
        .show-detail { color: var(--text-secondary); margin: 4px 0; font-size: 14px; }
        .show-price { font-size: 20px; font-weight: 800; background: var(--primary-gradient); -webkit-background-clip:text; -webkit-text-fill-color:transparent; background-clip:text; }
        .notice-box { padding: 16px; background: var(--bg-warm); border-radius: var(--radius-sm); font-size: 13px; color: var(--text-secondary); border-left: 3px solid var(--primary-start); }
        .notice-box p { margin: 4px 0; }
        .back-btn { display:inline-block; padding:10px 20px; background:#dfe6e9;color:var(--text-secondary);border:none;border-radius:25px;text-decoration:none;font-weight:600;transition:all 0.3s; }
        .back-btn:hover { background:#b2bec3; color:white; }
    </style>
</head>
<body>
<div class="header animate-fade-in">
    <h1 style="font-size:24px;font-weight:800;">🎟️ 确认订单</h1>
</div>

<div class="order-container">
    <div class="order-card">
        <c:if test="${not empty show}">
            <div style="display:flex;margin-bottom:28px;padding-bottom:20px;border-bottom:1px solid var(--border-light);">
                <img src="${show.imageUrl}" alt="${show.title}" class="show-image"
                     onerror="this.src='data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjAwIiBoZWlnaHQ9IjE1MCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48ZGVmcz48bGluZWFyR3JhZGllbnQgaWQ9ImciIHgxPSIwJSIgeTE9IjAlIiB4Mj0iMTAwJSIgeTI9IjEwMCUiPjxzdG9wIG9mZnNldD0iMCUiIHN0b3AtY29sb3I9IiNGRjZCMzUiLz48c3RvcCBvZmZzZXQ9IjEwMCUiIHN0b3AtY29sb3I9IiM5QjU5QjYiLz48L2xpbmVhckdyYWRpZW50PjwvZGVmcz48cmVjdCB3aWR0aD0iMTAwJSIgaGVpZ2h0PSIxMDAlIiBmaWxsPSJ1cmwoI2cpIi8+PHRleHQgeD0iNTAlIiB5PSI1MCUiIGZvbnQtZmFtaWx5PSJBcmlhbCIgZm9udC1zaXplPSIxNCIgZmlsbD0id2hpdGUiIHRleHQtYW5jaG9yPSJtaWRkbGUiIGR5PSIuM2VtIj7nu4fljZXlr77lrovlrpw8L3RleHQ+PC9zdmc+">
                <div style="flex:1;padding-left:20px;">
                    <div class="show-title">${show.title}</div>
                    <c:if test="${not empty show.performer}"><div class="show-performer">🎭 主演：${show.performer}</div></c:if>
                    <div class="show-detail">📍 ${show.city} · ${show.venue}</div>
                    <div class="show-detail">⏰ ${show.showTime}</div>
                    <c:if test="${show.duration > 0}"><div class="show-detail">⏱ 时长：${show.duration}分钟</div></c:if>
                    <div class="show-price" style="margin-top:8px;">💰 ¥${show.price}</div>
                </div>
            </div>

            <form id="orderForm">
                <input type="hidden" name="showId" value="${show.id}">
                <input type="hidden" name="quantity" value="1">
                <h3 style="margin-bottom:20px;color:var(--text-dark);font-weight:700;">填写观众信息</h3>
                <div class="form-row">
                    <div class="form-field">
                        <label class="required">🙁 观众姓名</label>
                        <input type="text" name="spectatorName" required value="${sessionScope.realName}" placeholder="真实姓名" data-validate="name">
                        <span class="form-error-msg"></span>
                    </div>
                    <div class="form-field">
                        <label class="required">🎗 观众学号</label>
                        <input type="text" name="spectatorStudentId" required value="${sessionScope.studentId}" placeholder="学号" data-validate="studentId">
                        <span class="form-error-msg"></span>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-field">
                        <label>📞 联系电话</label>
                        <input type="tel" name="spectatorPhone" value="${sessionScope.phone}" placeholder="手机号" data-validate="phone">
                        <span class="form-error-msg"></span>
                    </div>
                    <div class="form-field">
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
                <div class="form-field">
                    <label>📋 购票须知</label>
                    <div class="notice-box">
                        <p>1. 每人限购1张门票，请确保信息准确</p>
                        <p>2. 演出前24小时可申请全额退款</p>
                        <p>3. 请携带有效身份证件入场</p>
                        <p>4. 演出前30分钟开始检票</p>
                    </div>
                </div>
                <button type="button" class="btn-primary-custom submit-btn" onclick="submitOrder()" style="width:100%;padding:15px;font-size:17px;">🎟️ 立即支付 ¥${show.price}</button>
            </form>
        </c:if>
        <c:if test="${empty show}">
            <div style="text-align:center;padding:40px;animation:fadeInUp 0.5s ease">
                <svg viewBox="0 0 200 160" style="width:140px;height:120px;margin-bottom:12px"><rect x="40" y="30" width="120" height="90" rx="10" fill="#FDF8F5" stroke="#FF6B35" stroke-width="2"/><line x1="70" y1="60" x2="130" y2="60" stroke="#ddd"/><line x1="70" y1="80" x2="110" y2="80" stroke="#ddd"/><circle cx="100" cy="105" r="12" fill="none" stroke="#FF6B35" stroke-width="2"/></svg>
                <p style="color:var(--text-secondary);font-size:15px;">演出信息不存在或已下架</p>
                <a href="shows" class="back-btn">← 返回演出列表</a>
            </div>
        </c:if>
    </div>
</div>

<div class="payment-modal-overlay" id="payModal" style="display:none">
    <div class="payment-modal">
        <h4 style="font-weight:700;margin-bottom:4px;">💰 选择支付方式</h4>
        <p style="color:var(--text-secondary);font-size:14px;margin-bottom:4px;">订单金额：<strong style="color:var(--primary-start);font-size:18px;">¥${show.price}</strong></p>
        <div class="payment-methods">
            <div class="payment-method selected" data-pay="wechat"><div class="payment-method-icon">💳</div><div class="payment-method-name">微信支付</div></div>
            <div class="payment-method" data-pay="alipay"><div class="payment-method-icon">💳</div><div class="payment-method-name">支付宝</div></div>
            <div class="payment-method" data-pay="mock"><div class="payment-method-icon">🎭</div><div class="payment-method-name">模拟支付</div></div>
        </div>
        <div id="paySpinner" style="display:none"><div class="payment-spinner"></div><p style="text-align:center;color:var(--text-secondary);font-size:14px;">正在处理支付...</p></div>
        <div style="display:flex;gap:10px;margin-top:20px;">
            <button class="btn-primary-custom" style="flex:1;padding:12px;background:#dfe6e9;color:var(--text-secondary);" onclick="closePayModal()">取消</button>
            <button class="btn-primary-custom" id="confirmPayBtn" style="flex:1;padding:12px;" onclick="doPay()">确认支付</button>
        </div>
    </div>
</div>

<script src="js/main.js"></script>
<script>
let selectedPay = 'wechat';
document.querySelectorAll('.payment-method').forEach(m => m.addEventListener('click', function() {
    document.querySelectorAll('.payment-method').forEach(x => x.classList.remove('selected'));
    this.classList.add('selected');
    selectedPay = this.dataset.pay;
}));

function closePayModal() { document.getElementById('payModal').style.display='none'; }

function submitOrder() {
    const form = document.getElementById('orderForm');
    const rules = {
        spectatorName: [{type:'name',msg:'姓名需2-20个字符'}],
        spectatorStudentId: [{type:'studentId',msg:'请输入学号'}],
        spectatorPhone: [{type:'phone',msg:'请输入正确的手机号'}]
    };
    if (!Validator.validateForm('#orderForm', rules)) return;

    document.getElementById('payModal').style.display='';
}

function doPay() {
    const btn = document.getElementById('confirmPayBtn');
    btn.disabled = true;
    document.getElementById('paySpinner').style.display='';

    setTimeout(() => {
        const form = document.getElementById('orderForm');
        fetch('create-order', {
            method:'POST',
            headers:{'Content-Type':'application/x-www-form-urlencoded'},
            body:new URLSearchParams(new FormData(form))
        })
        .then(r => r.json())
        .then(result => {
            closePayModal();
            if (result.success) {
                confetti();
                showSuccessOverlay('购票成功！', result.message || '您的订单已创建，祝您观演愉快！', 'orders');
            } else {
                Toast.error(result.message || '购票失败');
                btn.disabled = false;
                document.getElementById('paySpinner').style.display='none';
            }
        })
        .catch(() => {
            Toast.error('网络错误，请重试');
            btn.disabled = false;
            document.getElementById('paySpinner').style.display='none';
        });
    }, 1500);
}
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
