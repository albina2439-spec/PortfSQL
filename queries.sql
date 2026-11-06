

SELECT name, email, registration_date 
FROM users 
WHERE city = 'Київ' AND registration_date >= '2026-01-01'
ORDER BY registration_date DESC;


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


SELECT 
    category,
    COUNT(item_id) AS total_items_sold,
    SUM(price * quantity) AS total_revenue
FROM order_items
GROUP BY category
ORDER BY total_revenue DESC;


SELECT 
    u.name,
    SUM(o.total_amount) AS total_spent
FROM users u
JOIN orders o ON u.user_id = o.user_id
WHERE o.status = 'Completed'
GROUP BY u.user_id, u.name
HAVING total_spent > 2000
ORDER BY total_spent DESC;


SELECT order_id, total_amount 
FROM orders 
WHERE total_amount > (SELECT AVG(total_amount) FROM orders);
