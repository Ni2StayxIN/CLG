-- ============================================
-- 脱口秀门票预订系统 - 全新数据库
-- 数据库名: standup_comedy
-- 与原 ticket_system 数据库完全独立
-- ============================================

CREATE DATABASE IF NOT EXISTS standup_comedy DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE standup_comedy;

-- 用户表
DROP TABLE IF EXISTS refunds;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS shows;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    real_name VARCHAR(50),
    student_id VARCHAR(20),
    phone VARCHAR(20),
    email VARCHAR(100),
    user_type VARCHAR(20) DEFAULT 'user',
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 脱口秀演出表
CREATE TABLE shows (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    city VARCHAR(50) NOT NULL,
    venue VARCHAR(200) NOT NULL,
    show_time DATETIME NOT NULL,
    total_tickets INT NOT NULL,
    available_tickets INT NOT NULL,
    price DOUBLE NOT NULL,
    status VARCHAR(20) DEFAULT 'upcoming',
    image_url VARCHAR(500),
    description TEXT,
    performer VARCHAR(100),
    duration INT DEFAULT 90,
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 订单表
CREATE TABLE orders (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    show_id BIGINT NOT NULL,
    quantity INT NOT NULL,
    total_amount DOUBLE NOT NULL,
    status VARCHAR(20) DEFAULT 'pending',
    order_number VARCHAR(50) NOT NULL UNIQUE,
    spectator_name VARCHAR(50) NOT NULL,
    spectator_student_id VARCHAR(20) NOT NULL,
    spectator_phone VARCHAR(20) NOT NULL,
    seat_info VARCHAR(100),
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 退票申请表
CREATE TABLE refunds (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    order_id BIGINT NOT NULL,
    user_id BIGINT NOT NULL,
    show_id BIGINT NOT NULL,
    refund_amount DOUBLE NOT NULL,
    quantity INT NOT NULL,
    reason VARCHAR(500),
    status VARCHAR(20) DEFAULT 'pending',
    apply_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    process_time TIMESTAMP NULL,
    admin_remark VARCHAR(500),
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 插入管理员账号
INSERT INTO users (username, password, real_name, student_id, phone, email, user_type)
VALUES ('admin', '123456', '管理员', 'admin123', '13800138000', 'admin@comedy.com', 'admin');

-- 插入10场脱口秀演出数据（未来日期）
INSERT INTO shows (title, city, venue, show_time, total_tickets, available_tickets, price, status, image_url, description, performer, duration) VALUES
('李诞脱口秀专场《笑场》', '北京', '北京喜剧院', DATE_ADD(NOW(), INTERVAL 7 DAY), 500, 200, 299.0, 'upcoming', 'img/shows/show_1.jpg', '李诞全新脱口秀专场，带你领略脱口秀的魅力！爆笑不断！', '李诞', 90),
('池子脱口秀《吐槽大会》', '上海', '上海笑果工厂', DATE_ADD(NOW(), INTERVAL 14 DAY), 400, 150, 259.0, 'upcoming', 'img/shows/show_2.jpg', '池子带来最新脱口秀专场，犀利吐槽！', '池子', 90),
('王建国脱口秀《建国大业》', '广州', '广州大剧院', DATE_ADD(NOW(), INTERVAL 21 DAY), 600, 300, 199.0, 'upcoming', 'img/shows/show_3.jpg', '王建国脱口秀专场，幽默风趣！', '王建国', 90),
('呼兰脱口秀《呼兰山》', '深圳', '深圳音乐厅', DATE_ADD(NOW(), INTERVAL 10 DAY), 450, 180, 229.0, 'upcoming', 'img/shows/show_4.jpg', '呼兰脱口秀专场，独特的幽默风格！', '呼兰', 90),
('周奇墨脱口秀《不理解万岁》', '成都', '成都演艺中心', DATE_ADD(NOW(), INTERVAL 15 DAY), 550, 250, 249.0, 'upcoming', 'img/shows/show_5.jpg', '周奇墨脱口秀专场，观察式喜剧代表！', '周奇墨', 90),
('庞博脱口秀《脱口秀大会》', '杭州', '杭州剧院', DATE_ADD(NOW(), INTERVAL 20 DAY), 500, 200, 239.0, 'upcoming', 'img/shows/show_6.jpg', '庞博脱口秀专场，高智商幽默！', '庞博', 90),
('徐志胜脱口秀《志胜一筹》', '南京', '南京人民大会堂', DATE_ADD(NOW(), INTERVAL 25 DAY), 700, 350, 179.0, 'upcoming', 'img/shows/show_7.jpg', '徐志胜脱口秀专场，颜值与才华的反差萌！', '徐志胜', 90),
('何广智脱口秀《广智脱口秀》', '武汉', '武汉琴台大剧院', DATE_ADD(NOW(), INTERVAL 30 DAY), 600, 280, 189.0, 'upcoming', 'img/shows/show_8.jpg', '何广智脱口秀专场，接地气的幽默！', '何广智', 90),
('杨笠脱口秀《犀利女王》', '西安', '西安音乐厅', DATE_ADD(NOW(), INTERVAL 12 DAY), 400, 160, 219.0, 'upcoming', 'img/shows/show_9.jpg', '杨笠脱口秀专场，犀利幽默！', '杨笠', 90),
('小鹿脱口秀《小鹿乱撞》', '重庆', '重庆大剧院', DATE_ADD(NOW(), INTERVAL 18 DAY), 500, 220, 209.0, 'upcoming', 'img/shows/show_10.jpg', '小鹿脱口秀专场，清新幽默！', '小鹿', 90),
('二狗脱口秀《二狗笑传》', '长沙', '长沙梅溪湖大剧院', DATE_ADD(NOW(), INTERVAL 8 DAY), 600, 350, 159.0, 'upcoming', 'img/shows/show_11.jpg', '网红二狗首场脱口秀专场！从短视频到舞台，用最接地气的段子讲述打工人的喜怒哀乐，爆笑全场！', '二狗', 90);
