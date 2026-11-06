CREATE DATABASE IF NOT EXISTS shop_analytics DEFAULT CHARSET utf8mb4;
USE shop_analytics;
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS users;



CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    registration_date DATE NOT NULL,
    city VARCHAR(50)
) DEFAULT CHARSET = utf8mb4;

CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    order_date DATE NOT NULL,
    status VARCHAR(30) NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    CONSTRAINT chk_orders_status
        CHECK (status IN ('Completed', 'Processing', 'Cancelled')),
    CONSTRAINT chk_orders_total CHECK (total_amount >= 0),
    CONSTRAINT fk_orders_user
        FOREIGN KEY (user_id) REFERENCES users(user_id),
    INDEX idx_orders_user (user_id),
    INDEX idx_orders_date (order_date)
) DEFAULT CHARSET = utf8mb4;

CREATE TABLE order_items (
    item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    quantity INT NOT NULL,
    CONSTRAINT chk_items_price CHECK (price > 0),
    CONSTRAINT chk_items_qty CHECK (quantity > 0),
    CONSTRAINT fk_items_order
        FOREIGN KEY (order_id) REFERENCES orders(order_id),
    INDEX idx_items_order (order_id)
) DEFAULT CHARSET = utf8mb4;




INSERT INTO users (user_id, name, email, registration_date, city) VALUES
(1, 'Олександр Петренко', 'petrenko@gmail.com',   '2026-01-15', 'Київ'),
(2, 'Марія Коваленко',    'kovalenko@ukr.net',    '2026-02-01', 'Львів'),
(3, 'Андрій Шевченко',    'shevchenko@gmail.com', '2026-02-10', 'Одеса'),
(4, 'Юлія Бондар',        'bondar@gmail.com',     '2026-03-05', 'Харків'),
(5, 'Ірина Мельник',      'melnyk@gmail.com',     '2026-03-20', 'Київ'),
(6, 'Дмитро Ткаченко',    'tkachenko@ukr.net',    '2026-04-02', 'Львів'),
(7, 'Наталія Кравченко',  'kravchenko@gmail.com', '2026-04-15', 'Дніпро'),
(8, 'Богдан Лисенко',     'lysenko@gmail.com',    '2026-05-10', 'Київ');


INSERT INTO orders (order_id, user_id, order_date, status, total_amount) VALUES
(101, 1, '2026-03-01', 'Completed',  1500.00),
(102, 2, '2026-03-02', 'Completed',  3200.50),
(103, 1, '2026-03-05', 'Processing',  850.00),
(104, 3, '2026-03-10', 'Completed',  5400.00),
(105, 4, '2026-03-12', 'Cancelled',  1200.00),
(106, 5, '2026-03-25', 'Completed',  1600.00),
(107, 1, '2026-04-03', 'Completed',  7800.00),
(108, 2, '2026-04-10', 'Completed',  5700.00),
(109, 6, '2026-04-18', 'Completed',  2450.00),
(110, 5, '2026-04-22', 'Cancelled',  3200.50),
(111, 7, '2026-05-02', 'Completed',  7700.50),
(112, 3, '2026-05-08', 'Completed',  3600.00),
(113, 6, '2026-05-15', 'Processing', 5400.00),
(114, 1, '2026-05-20', 'Completed',   750.00),
(115, 7, '2026-06-01', 'Completed',  2050.00);

INSERT INTO order_items (item_id, order_id, product_name, category, price, quantity) VALUES
(1,  101, 'Бездротова миша', 'Електроніка', 750.00,  2),
(2,  102, 'Офісне крісло',   'Меблі',       3200.50, 1),
(3,  103, 'Клавіатура',      'Електроніка', 850.00,  1),
(4,  104, 'Монітор 27"',     'Електроніка', 5400.00, 1),
(5,  105, 'Настільна лампа', 'Освітлення',  1200.00, 1),
(6,  106, 'Клавіатура',      'Електроніка', 850.00,  1),
(7,  106, 'Бездротова миша', 'Електроніка', 750.00,  1),
(8,  107, 'Монітор 27"',     'Електроніка', 5400.00, 1),
(9,  107, 'Настільна лампа', 'Освітлення',  1200.00, 2),
(10, 108, 'Настільна лампа', 'Освітлення',  1200.00, 1),
(11, 108, 'Письмовий стіл',  'Меблі',       4500.00, 1),
(12, 109, 'Бездротова миша', 'Електроніка', 750.00,  1),
(13, 109, 'Клавіатура',      'Електроніка', 850.00,  2),
(14, 110, 'Офісне крісло',   'Меблі',       3200.50, 1),
(15, 111, 'Письмовий стіл',  'Меблі',       4500.00, 1),
(16, 111, 'Офісне крісло',   'Меблі',       3200.50, 1),
(17, 112, 'Настільна лампа', 'Освітлення',  1200.00, 3),
(18, 113, 'Монітор 27"',     'Електроніка', 5400.00, 1),
(19, 114, 'Бездротова миша', 'Електроніка', 750.00,  1),
(20, 115, 'Клавіатура',      'Електроніка', 850.00,  1),
(21, 115, 'Настільна лампа', 'Освітлення',  1200.00, 1);
