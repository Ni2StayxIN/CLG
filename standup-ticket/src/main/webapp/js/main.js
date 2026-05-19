const Toast = {
    container: null,
    init() {
        if (!this.container) {
            this.container = document.createElement('div');
            this.container.className = 'toast-container';
            document.body.appendChild(this.container);
        }
    },
    show(message, type = 'info', duration = 3000) {
        this.init();
        const icons = { success: '✅', error: '❌', warning: '⚠️', info: 'ℹ️' };
        const toast = document.createElement('div');
        toast.className = `toast toast-${type}`;
        toast.innerHTML = `
            <span class="toast-icon">${icons[type] || icons.info}</span>
            <span>${message}</span>
            <button class="toast-close" onclick="Toast.remove(this.parentElement)">×</button>
            <div class="toast-progress" style="animation-duration:${duration}ms"></div>
        `;
        this.container.appendChild(toast);
        setTimeout(() => this.remove(toast), duration);
    },
    success(msg, d) { this.show(msg, 'success', d); },
    error(msg, d) { this.show(msg, 'error', d); },
    warning(msg, d) { this.show(msg, 'warning', d); },
    info(msg, d) { this.show(msg, 'info', d); },
    remove(el) {
        if (!el || !el.parentElement) return;
        el.classList.add('removing');
        setTimeout(() => el.remove(), 300);
    }
};

const Validator = {
    phone(val) {
        return val.length >= 7 && val.length <= 15;
    },
    email(val) {
        return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(val);
    },
    studentId(val) {
        return val.length >= 4 && val.length <= 20;
    },
    name(val) {
        return val.length >= 2 && val.length <= 20;
    },
    notEmpty(val) {
        return val && val.trim().length > 0;
    },
    validateField(field, rules) {
        let valid = true;
        let msg = '';
        for (const rule of rules) {
            switch (rule.type) {
                case 'phone':
                    if (!this.phone(field.value)) { valid = false; msg = rule.msg || '请输入正确的11位手机号'; }
                    break;
                case 'email':
                    if (field.value && !this.email(field.value)) { valid = false; msg = rule.msg || '请输入正确的邮箱格式'; }
                    break;
                case 'studentId':
                    if (!this.studentId(field.value)) { valid = false; msg = rule.msg || '学号格式不正确（8-12位数字）'; }
                    break;
                case 'name':
                    if (!this.name(field.value)) { valid = false; msg = rule.msg || '姓名需2-20个字符'; }
                    break;
                case 'required':
                    if (!this.notEmpty(field.value)) { valid = false; msg = rule.msg || '此项为必填项'; }
                    break;
            }
            if (!valid) break;
        }
        const wrapper = field.closest('.form-field');
        if (wrapper) {
            const errEl = wrapper.querySelector('.form-error-msg');
            if (!valid) {
                wrapper.classList.add('error');
                if (errEl) errEl.textContent = msg;
            } else {
                wrapper.classList.remove('error');
            }
        }
        return valid;
    },
    validateForm(formSelector, rulesMap) {
        const form = document.querySelector(formSelector);
        if (!form) return true;
        let allValid = true;
        for (const [name, rules] of Object.entries(rulesMap)) {
            const field = form.querySelector(`[name="${name}"]`);
            if (field && !this.validateField(field, rules)) {
                allValid = false;
            }
        }
        return allValid;
    }
};

function confetti() {
    const container = document.createElement('div');
    container.className = 'confetti-container';
    document.body.appendChild(container);
    const colors = ['#FF6B35','#9B59B6','#F7C948','#00b894','#FF4757','#0984e3'];
    const shapes = ['▮','●','▲','■','★'];
    for (let i = 0; i < 60; i++) {
        const piece = document.createElement('div');
        piece.className = 'confetti-piece';
        piece.textContent = shapes[Math.floor(Math.random() * shapes.length)];
        piece.style.left = Math.random() * 100 + '%';
        piece.style.color = colors[Math.floor(Math.random() * colors.length)];
        piece.style.fontSize = (Math.random() * 16 + 10) + 'px';
        piece.style.animationDuration = (Math.random() * 2 + 1.5) + 's';
        piece.style.animationDelay = (Math.random() * 0.5) + 's';
        container.appendChild(piece);
    }
    setTimeout(() => container.remove(), 3500);
}

function showSuccessOverlay(title, desc, redirectUrl) {
    const overlay = document.createElement('div');
    overlay.className = 'success-overlay';
    overlay.innerHTML = `
        <div class="success-overlay-content">
            <div class="success-checkmark">
                <svg viewBox="0 0 52 52"><path d="M14.1 27.2l9.1 9.1 16-24"/></svg>
            </div>
            <h3 class="success-title">${title}</h3>
            <p class="success-desc">${desc}</p>
        </div>
    `;
    document.body.appendChild(overlay);
    setTimeout(() => {
        overlay.style.opacity = '0';
        overlay.style.transition = 'opacity 0.4s';
        setTimeout(() => { overlay.remove(); if (redirectUrl) window.location.href = redirectUrl; }, 400);
    }, 2200);
}

function setupRipple() {
    document.addEventListener('click', function(e) {
        const btn = e.target.closest('.btn-primary-custom, .admin-btn-primary, .login-btn, .register-btn, .submit-btn');
        if (!btn || btn.disabled) return;
        const ripple = document.createElement('span');
        const rect = btn.getBoundingClientRect();
        const size = Math.max(rect.width, rect.height);
        ripple.style.cssText = `position:absolute;border-radius:50%;background:rgba(255,255,255,0.35);width:${size}px;height:${size}px;left:${e.clientX - rect.left - size/2}px;top:${e.clientY - rect.top - size/2}px;pointer-events:none;animation:ripple 0.6s ease-out forwards;`;
        btn.style.position = 'relative';
        btn.style.overflow = 'hidden';
        btn.appendChild(ripple);
        setTimeout(() => ripple.remove(), 600);
    });
}

function setupHamburger() {
    const hamburger = document.querySelector('.hamburger');
    const navLinks = document.querySelector('.nav-links');
    if (hamburger && navLinks) {
        hamburger.addEventListener('click', () => {
            navLinks.classList.toggle('open');
            hamburger.classList.toggle('active');
        });
        document.addEventListener('click', (e) => {
            if (!hamburger.contains(e.target) && !navLinks.contains(e.target)) {
                navLinks.classList.remove('open');
                hamburger.classList.remove('active');
            }
        });
    }
}

function setupNavbarScroll() {
    const navbar = document.querySelector('.navbar');
    if (navbar) {
        window.addEventListener('scroll', () => {
            navbar.classList.toggle('scrolled', window.scrollY > 20);
        });
    }
}

function initCommon() {
    setupRipple();
    setupHamburger();
    setupNavbarScroll();
}

document.addEventListener('DOMContentLoaded', initCommon);

const Skeleton = {
    show(type = 'spinner', container = null) {
        if (container) {
            const el = typeof container === 'string' ? document.querySelector(container) : container;
            if (!el) return;
            this.hide(el);
            const overlay = document.createElement('div');
            overlay.className = 'loading-overlay';
            overlay.style.position = 'absolute';
            if (type === 'spinner') {
                overlay.innerHTML = '<div class="loading-spinner"></div>';
            } else if (type === 'dots') {
                overlay.innerHTML = `<div class="loading-dots"><div class="loading-dot"></div><div class="loading-dot"></div><div class="loading-dot"></div></div>`;
            }
            el.style.position = 'relative';
            el.appendChild(overlay);
            return overlay;
        } else {
            let existing = document.querySelector('.skeleton-global');
            if (existing) return existing;
            const overlay = document.createElement('div');
            overlay.className = 'loading-overlay skeleton-global';
            if (type === 'spinner') {
                overlay.innerHTML = '<div class="loading-spinner"></div>';
            } else if (type === 'dots') {
                overlay.innerHTML = `<div class="loading-dots"><div class="loading-dot"></div><div class="loading-dot"></div><div class="loading-dot"></div></div>`;
            }
            document.body.appendChild(overlay);
            return overlay;
        }
    },
    hide(container) {
        if (container) {
            const el = typeof container === 'string' ? document.querySelector(container) : container;
            if (el) {
                const loader = el.querySelector('.loading-overlay');
                if (loader) loader.remove();
            }
        } else {
            const global = document.querySelector('.skeleton-global');
            if (global) global.remove();
        }
    },
    generateShowCard(count = 4) {
        let html = '';
        for (let i = 0; i < count; i++) {
            html += `
            <div class="show-card skeleton-show-card" style="opacity:1;transform:none;">
                <div class="skeleton skeleton-image"></div>
                <div class="skeleton-content">
                    <div class="skeleton skeleton-title"></div>
                    <div class="skeleton skeleton-text" style="width:50%"></div>
                    <div class="skeleton skeleton-text" style="width:70%"></div>
                    <div style="display:flex;justify-content:space-between;margin-top:14px;">
                        <div class="skeleton skeleton-btn" style="width:80px;height:32px;"></div>
                        <div class="skeleton skeleton-btn" style="width:80px;height:32px;"></div>
                    </div>
                </div>
            </div>`;
        }
        return html;
    },
    generateTableRows(count = 5, cols = 6) {
        let html = '';
        for (let i = 0; i < count; i++) {
            html += '<tr class="skeleton-table-row">';
            for (let j = 0; j < cols; j++) {
                html += `<td><div class="skeleton skeleton-table-line" style="width:${40 + Math.random() * 60}%"></div></td>`;
            }
            html += '</tr>';
        }
        return html;
    },
    generateStatCards(count = 4) {
        let html = '';
        for (let i = 0; i < count; i++) {
            html += `<div class="col-xl-3 col-md-6"><div class="skeleton skeleton-stat-card"></div></div>`;
        }
        return html;
    },
    wrapWithLoader(container, callback, type = 'spinner') {
        const el = typeof container === 'string' ? document.querySelector(container) : container;
        if (!el) return Promise.reject('Container not found');
        const loader = this.show(type, el);
        return new Promise((resolve) => {
            setTimeout(() => {
                try {
                    const result = callback();
                    resolve(result);
                } catch (e) {
                    reject(e);
                } finally {
                    this.hide(el);
                }
            }, 500 + Math.random() * 300);
        });
    }
};

window.showToast = (msg, type, dur) => Toast.show(msg, type, dur);
window.showSuccess = (t, d, url) => showSuccessOverlay(t, d, url);
window.confetti = confetti;
window.Skeleton = Skeleton;
