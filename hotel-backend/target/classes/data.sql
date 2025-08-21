-- 插入初始用户数据（密码为123456的MD5加密）
INSERT INTO users (username, password, real_name, phone, email, role) VALUES
('admin', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', '系统管理员', '13800138000', 'admin@hotel.com', 'ADMIN'),
('manager', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', '酒店经理', '13800138001', 'manager@hotel.com', 'MANAGER'),
('staff', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', '前台员工', '13800138002', 'staff@hotel.com', 'STAFF');

-- 插入房型数据
INSERT INTO room_types (type_name, description, base_price, max_occupancy, amenities) VALUES
('标准单人间', '舒适的单人间，配备基础设施', 188.00, 1, '["空调", "电视", "WiFi", "独立卫浴"]'),
('标准双人间', '宽敞的双人间，适合情侣或朋友', 268.00, 2, '["空调", "电视", "WiFi", "独立卫浴", "双人床"]'),
('豪华套房', '豪华套房，享受尊贵体验', 588.00, 4, '["空调", "电视", "WiFi", "独立卫浴", "客厅", "迷你吧", "阳台"]'),
('商务套房', '专为商务人士设计的套房', 488.00, 2, '["空调", "电视", "WiFi", "独立卫浴", "办公桌", "会议设施"]'),
('家庭房', '适合家庭入住的大房间', 388.00, 6, '["空调", "电视", "WiFi", "独立卫浴", "儿童床", "游戏区域"]');

-- 插入房间数据
INSERT INTO rooms (room_number, room_type_id, floor, status) VALUES
-- 1楼标准单人间
('101', 1, 1, 'AVAILABLE'),
('102', 1, 1, 'AVAILABLE'),
('103', 1, 1, 'AVAILABLE'),
-- 1楼标准双人间
('104', 2, 1, 'AVAILABLE'),
('105', 2, 1, 'AVAILABLE'),
('106', 2, 1, 'OCCUPIED'),
-- 2楼标准双人间
('201', 2, 2, 'AVAILABLE'),
('202', 2, 2, 'AVAILABLE'),
('203', 2, 2, 'AVAILABLE'),
('204', 2, 2, 'CLEANING'),
-- 2楼商务套房
('205', 4, 2, 'AVAILABLE'),
('206', 4, 2, 'AVAILABLE'),
-- 3楼豪华套房
('301', 3, 3, 'AVAILABLE'),
('302', 3, 3, 'MAINTENANCE'),
-- 3楼家庭房
('303', 5, 3, 'AVAILABLE'),
('304', 5, 3, 'AVAILABLE');

-- 插入示例客户数据
INSERT INTO customers (name, phone, id_card, email, gender, vip_level) VALUES
('张三', '13912345678', '320101199001011234', 'zhangsan@email.com', 'MALE', 'NORMAL'),
('李四', '13812345678', '320101199002021234', 'lisi@email.com', 'FEMALE', 'SILVER'),
('王五', '13712345678', '320101199003031234', 'wangwu@email.com', 'MALE', 'GOLD'),
('赵六', '13612345678', '320101199004041234', 'zhaoliu@email.com', 'FEMALE', 'NORMAL');