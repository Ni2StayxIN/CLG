-- 创建数据库
CREATE DATABASE IF NOT EXISTS ticket_system DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- 使用数据库
USE ticket_system;

-- 创建用户表
CREATE TABLE IF NOT EXISTS users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    real_name VARCHAR(50),
    student_id VARCHAR(20),
    phone VARCHAR(20),
    email VARCHAR(100),
    user_type VARCHAR(20) DEFAULT 'user', -- user 或 admin
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 创建演唱会表
CREATE TABLE IF NOT EXISTS concerts (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    city VARCHAR(50) NOT NULL,
    venue VARCHAR(200) NOT NULL,
    concert_time DATETIME NOT NULL,
    total_tickets INT NOT NULL,
    available_tickets INT NOT NULL,
    price DOUBLE NOT NULL,
    status VARCHAR(20) DEFAULT 'upcoming', -- upcoming 或 ongoing 或 ended
    image_url VARCHAR(500),
    description TEXT,
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 创建订单表
CREATE TABLE IF NOT EXISTS orders (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    concert_id BIGINT NOT NULL,
    quantity INT NOT NULL,
    total_amount DOUBLE NOT NULL,
    status VARCHAR(20) DEFAULT 'pending', -- pending 或 paid 或 cancelled
    order_number VARCHAR(50) NOT NULL UNIQUE,
    spectator_name VARCHAR(50) NOT NULL,
    spectator_student_id VARCHAR(20) NOT NULL,
    spectator_phone VARCHAR(20) NOT NULL,
    seat_info VARCHAR(100),
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (concert_id) REFERENCES concerts(id) ON DELETE CASCADE
);

-- 插入默认管理员用户
INSERT INTO users (username, password, real_name, student_id, phone, email, user_type) 
VALUES ('admin', '123456', '管理员', 'admin123', '13800138000', 'admin@example.com', 'admin') 
ON DUPLICATE KEY UPDATE username = username;

-- 插入示例演唱会数据
INSERT INTO concerts (title, city, venue, concert_time, total_tickets, available_tickets, price, status, image_url, description) 
VALUES 
('周杰伦2024演唱会', '上海', '上海体育场', '2024-12-31 19:30:00', 50000, 50000, 880.0, 'upcoming', 'https://example.com/jay.jpg', '周杰伦2024嘉年华演唱会上海站'),
('林俊杰2024演唱会', '北京', '鸟巢', '2024-11-25 20:00:00', 60000, 60000, 780.0, 'upcoming', 'https://example.com/jj.jpg', '林俊杰2024世界巡回演唱会北京站'),
('五月天2024演唱会', '广州', '广州体育馆', '2024-10-15 19:45:00', 40000, 40000, 680.0, 'upcoming', 'https://example.com/mayday.jpg', '五月天2024诺亚方舟演唱会广州站')
ON DUPLICATE KEY UPDATE title = title;
