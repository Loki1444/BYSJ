-- 创建数据库
CREATE DATABASE IF NOT EXISTS hotel_management CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE hotel_management;

-- 用户表（管理员）
CREATE TABLE IF NOT EXISTS users (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE COMMENT '用户名',
    password VARCHAR(255) NOT NULL COMMENT '密码',
    real_name VARCHAR(50) NOT NULL COMMENT '真实姓名',
    phone VARCHAR(20) COMMENT '电话号码',
    email VARCHAR(100) COMMENT '邮箱',
    role ENUM('ADMIN', 'MANAGER', 'STAFF') DEFAULT 'STAFF' COMMENT '角色',
    status TINYINT DEFAULT 1 COMMENT '状态：1-启用，0-禁用',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
) COMMENT '用户表';

-- 房型表
CREATE TABLE IF NOT EXISTS room_types (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    type_name VARCHAR(50) NOT NULL COMMENT '房型名称',
    description TEXT COMMENT '房型描述',
    base_price DECIMAL(10,2) NOT NULL COMMENT '基础价格',
    max_occupancy INT DEFAULT 2 COMMENT '最大入住人数',
    amenities TEXT COMMENT '房间设施（JSON格式）',
    image_url VARCHAR(255) COMMENT '房型图片URL',
    status TINYINT DEFAULT 1 COMMENT '状态：1-启用，0-禁用',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
) COMMENT '房型表';

-- 房间表
CREATE TABLE IF NOT EXISTS rooms (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    room_number VARCHAR(20) NOT NULL UNIQUE COMMENT '房间号',
    room_type_id BIGINT NOT NULL COMMENT '房型ID',
    floor INT COMMENT '楼层',
    status ENUM('AVAILABLE', 'OCCUPIED', 'MAINTENANCE', 'CLEANING') DEFAULT 'AVAILABLE' COMMENT '房间状态',
    description TEXT COMMENT '房间描述',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    FOREIGN KEY (room_type_id) REFERENCES room_types(id) ON DELETE RESTRICT
) COMMENT '房间表';

-- 客户表
CREATE TABLE IF NOT EXISTS customers (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL COMMENT '客户姓名',
    phone VARCHAR(20) NOT NULL COMMENT '电话号码',
    id_card VARCHAR(20) COMMENT '身份证号',
    email VARCHAR(100) COMMENT '邮箱',
    address TEXT COMMENT '地址',
    gender ENUM('MALE', 'FEMALE', 'OTHER') COMMENT '性别',
    birth_date DATE COMMENT '出生日期',
    vip_level ENUM('NORMAL', 'SILVER', 'GOLD', 'PLATINUM') DEFAULT 'NORMAL' COMMENT 'VIP等级',
    total_consumption DECIMAL(10,2) DEFAULT 0.00 COMMENT '总消费金额',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    INDEX idx_phone (phone),
    INDEX idx_id_card (id_card)
) COMMENT '客户表';

-- 订单表
CREATE TABLE IF NOT EXISTS orders (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    order_number VARCHAR(50) NOT NULL UNIQUE COMMENT '订单号',
    customer_id BIGINT NOT NULL COMMENT '客户ID',
    room_id BIGINT NOT NULL COMMENT '房间ID',
    check_in_date DATE NOT NULL COMMENT '入住日期',
    check_out_date DATE NOT NULL COMMENT '退房日期',
    actual_check_in TIMESTAMP NULL COMMENT '实际入住时间',
    actual_check_out TIMESTAMP NULL COMMENT '实际退房时间',
    adults INT DEFAULT 1 COMMENT '成人数量',
    children INT DEFAULT 0 COMMENT '儿童数量',
    total_amount DECIMAL(10,2) NOT NULL COMMENT '订单总金额',
    paid_amount DECIMAL(10,2) DEFAULT 0.00 COMMENT '已付金额',
    status ENUM('PENDING', 'CONFIRMED', 'CHECKED_IN', 'CHECKED_OUT', 'CANCELLED') DEFAULT 'PENDING' COMMENT '订单状态',
    payment_status ENUM('UNPAID', 'PARTIAL', 'PAID', 'REFUNDED') DEFAULT 'UNPAID' COMMENT '支付状态',
    notes TEXT COMMENT '备注',
    created_by BIGINT COMMENT '创建人ID',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE RESTRICT,
    FOREIGN KEY (room_id) REFERENCES rooms(id) ON DELETE RESTRICT,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
    INDEX idx_order_number (order_number),
    INDEX idx_customer_id (customer_id),
    INDEX idx_check_in_date (check_in_date),
    INDEX idx_status (status)
) COMMENT '订单表';

-- 订单详情表（用于记录每日房费等详细信息）
CREATE TABLE IF NOT EXISTS order_details (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    order_id BIGINT NOT NULL COMMENT '订单ID',
    date DATE NOT NULL COMMENT '日期',
    room_price DECIMAL(10,2) NOT NULL COMMENT '房间价格',
    discount_amount DECIMAL(10,2) DEFAULT 0.00 COMMENT '折扣金额',
    extra_charges DECIMAL(10,2) DEFAULT 0.00 COMMENT '额外费用',
    description VARCHAR(255) COMMENT '费用说明',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    INDEX idx_order_id (order_id),
    INDEX idx_date (date)
) COMMENT '订单详情表';

-- 支付记录表
CREATE TABLE IF NOT EXISTS payments (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    order_id BIGINT NOT NULL COMMENT '订单ID',
    payment_method ENUM('CASH', 'CARD', 'ALIPAY', 'WECHAT', 'BANK_TRANSFER') NOT NULL COMMENT '支付方式',
    amount DECIMAL(10,2) NOT NULL COMMENT '支付金额',
    transaction_id VARCHAR(100) COMMENT '交易流水号',
    payment_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '支付时间',
    status ENUM('SUCCESS', 'FAILED', 'PENDING') DEFAULT 'SUCCESS' COMMENT '支付状态',
    notes TEXT COMMENT '备注',
    created_by BIGINT COMMENT '操作人ID',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
    INDEX idx_order_id (order_id),
    INDEX idx_payment_time (payment_time)
) COMMENT '支付记录表';