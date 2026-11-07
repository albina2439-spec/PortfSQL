
-- Клієнти з Києва, зареєстровані у 2026 році
SELECT name, email, registration_date
FROM users
WHERE city = 'Київ'
  AND registration_date >= '2026-01-01'
ORDER BY registration_date DESC;


-- Успішні замовлення з іменами клієнтів
SELECT
    o.order_id,
    u.name AS customer_name,
    u.city,
    o.order_date,
    o.total_amount
FROM orders o
INNER JOIN users u ON o.user_id = u.user_id
WHERE o.status = 'Completed'
ORDER BY o.order_date DESC;


-- Продажі за категоріями (успішні замовлення)
SELECT
    oi.category,
    SUM(oi.quantity) AS total_units_sold,
    SUM(oi.price * oi.quantity) AS total_revenue
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
WHERE o.status = 'Completed'
GROUP BY oi.category
ORDER BY total_revenue DESC;


-- Клієнти, які витратили понад 2000 грн
SELECT
    u.name,
    SUM(o.total_amount) AS total_spent
FROM users u
JOIN orders o ON u.user_id = o.user_id
WHERE o.status = 'Completed'
GROUP BY u.user_id, u.name
HAVING SUM(o.total_amount) > 2000
ORDER BY total_spent DESC;


-- Замовлення, сума яких перевищує середній чек
SELECT order_id, total_amount
FROM orders
WHERE status = 'Completed'
  AND total_amount > (
        SELECT AVG(total_amount)
        FROM orders
        WHERE status = 'Completed'
  )
ORDER BY total_amount DESC;


-- Клієнти, які ще не зробили жодного замовлення
SELECT u.user_id, u.name, u.city, u.registration_date
FROM users u
LEFT JOIN orders o ON u.user_id = o.user_id
WHERE o.order_id IS NULL;


-- 7. Дохід по місяцях та зростання відносно попереднього місяця
-- Навичка: CTE, віконна функція LAG, робота з датами
WITH monthly_revenue AS (
    SELECT
        DATE_FORMAT(order_date, '%Y-%m') AS month,
        SUM(total_amount) AS revenue
    FROM orders
    WHERE status = 'Completed'
    GROUP BY DATE_FORMAT(order_date, '%Y-%m')
)
SELECT
    month,
    revenue,
    LAG(revenue) OVER (ORDER BY month) AS prev_month_revenue,
    ROUND(
        (revenue - LAG(revenue) OVER (ORDER BY month))
        / LAG(revenue) OVER (ORDER BY month) * 100, 1
    ) AS growth_pct
FROM monthly_revenue
ORDER BY month;


-- 8. Рейтинг клієнтів за сумою витрат
-- Навичка: віконна функція RANK
SELECT
    u.name,
    u.city,
    SUM(o.total_amount) AS total_spent,
    RANK() OVER (ORDER BY SUM(o.total_amount) DESC) AS spending_rank
FROM users u
JOIN orders o ON u.user_id = o.user_id
WHERE o.status = 'Completed'
GROUP BY u.user_id, u.name, u.city
ORDER BY spending_rank;


-- 9. Сегментація клієнтів за рівнем витрат
-- Навичка: CTE + CASE
WITH customer_totals AS (
    SELECT
        u.user_id,
        u.name,
        SUM(o.total_amount) AS total_spent
    FROM users u
    JOIN orders o ON u.user_id = o.user_id
    WHERE o.status = 'Completed'
    GROUP BY u.user_id, u.name
)
SELECT
    name,
    total_spent,
    CASE
        WHEN total_spent >= 8000 THEN 'VIP'
        WHEN total_spent >= 3000 THEN 'Regular'
        ELSE 'New'
    END AS segment
FROM customer_totals
ORDER BY total_spent DESC;


-- Перевірка якості даних: чи збігається total_amount із сумою позицій замовлення
SELECT
    o.order_id,
    o.total_amount,
    SUM(oi.price * oi.quantity) AS items_sum
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY o.order_id, o.total_amount
HAVING o.total_amount <> SUM(oi.price * oi.quantity);
