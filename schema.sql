
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS users;


CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    registration_date DATE NOT NULL,
    city VARCHAR(50)
);


CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    order_date DATE NOT NULL,
    status VARCHAR(30) NOT NULL, -- наприклад: 'Completed', 'Processing', 'Cancelled'
    total_amount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);


CREATE TABLE order_items (
    item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    quantity INT NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);



INSERT INTO users (user_id, name, email, registration_date, city) VALUES
(1, 'Олександр Петренко', 'petrenko@gmail.com', '2026-01-15', 'Київ'),
(2, 'Марія Коваленко', 'kovalenko@ukr.net', '2026-02-01', 'Львів'),
(3, 'Андрій Шевченко', 'shevchenko@gmail.com', '2026-02-10', 'Одеса'),
(4, 'Юлія Бондар', 'bondar@gmail.com', '2026-03-05', 'Харків');


INSERT INTO orders (order_id, user_id, order_date, status, total_amount) VALUES
(101, 1, '2026-03-01', 'Completed', 1500.00),
(102, 2, '2026-03-02', 'Completed', 3200.50),
(103, 1, '2026-03-05', 'Processing', 850.00),
(104, 3, '2026-03-10', 'Completed', 5400.00),
(105, 4, '2026-03-12', 'Cancelled', 1200.00);


INSERT INTO order_items (item_id, order_id, product_name, category, price, quantity) VALUES
(1, 101, 'Бездротова миша', 'Електроніка', 750.00, 2),
(2, 102, 'Офісне крісло', 'Меблі', 3200.50, 1),
(3, 103, 'Клавіатура', 'Електроніка', 850.00, 1),
(4, 104, 'Монітор 27"', 'Електроніка', 5400.00, 1),
(5, 105, 'Настільна лампа', 'Освітлення', 1200.00, 1);
