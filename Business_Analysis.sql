
-- ===============================================
-- Brew & Bean Cafe Sales & Inventory Analytics
-- Business Analysis Queries
-- ===============================================

USE BrewBeanCafe;

-- Query 1: Display all customers

SELECT *
FROM customers;

-- Query 2: Display all menu items

SELECT *
FROM menu_items;

-- Query 3: Find customers from Pune

SELECT customer_id,full_name,city
FROM customers
WHERE city = 'Pune';

-- Query 4: Menu items costing more than ₹200

SELECT item_name,price
FROM menu_items
WHERE price > 200;

-- Query 5: Count total customers

SELECT COUNT(*) AS total_customers
FROM customers;

-- Query 6: Average menu item price

SELECT ROUND(AVG(price),2) AS average_price
FROM menu_items;

-- Query 7: Top 5 expensive menu items

SELECT item_name,
       price
FROM menu_items
ORDER BY price DESC
LIMIT 5;

-- ===============================================
-- Intermediate Queries (8–14)
-- ===============================================

-- Query 8: Display all orders with customer names

SELECT
    o.order_id,
    c.full_name,o.order_date,o.order_status
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id;

-- Query 9: Menu items with category names

SELECT
    m.item_name, c.category_name, m.price
FROM menu_items m
JOIN categories c
ON m.category_id = c.category_id;


-- Query 10: Orders handled by each employee

SELECT
    e.full_name,
    COUNT(o.order_id) AS total_orders
FROM employees e
JOIN orders o
ON e.employee_id = o.employee_id
GROUP BY e.full_name
ORDER BY total_orders DESC;

-- Query 11: Total amount spent by each customer

SELECT c.full_name,
       SUM(p.amount) AS total_spent
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id
INNER JOIN payments p
ON o.order_id = p.order_id
GROUP BY c.full_name
ORDER BY total_spent DESC;



-- Query 12: Revenue by payment method

SELECT payment_method,
       SUM(amount) AS total_revenue
FROM payments
GROUP BY payment_method;

-- Query 13: Low stock items

SELECT m.item_name,
	i.stock_quantity, i.reorder_level
FROM inventory i
INNER JOIN menu_items m
ON i.item_id = m.item_id
WHERE i.stock_quantity <= i.reorder_level;

-- Query 14: Most ordered menu items

SELECT m.item_name,
       SUM(od.quantity) AS total_quantity
FROM order_details od
INNER JOIN menu_items m
ON od.item_id = m.item_id
GROUP BY m.item_name
ORDER BY total_quantity DESC;

-- ===============================================
--         Advanced Queries (15–20)
-- ===============================================


-- Query 15: Top 3 best-selling menu items

SELECT m.item_name,
       SUM(od.quantity) AS total_sold
FROM order_details od
INNER JOIN menu_items m
ON od.item_id = m.item_id
GROUP BY m.item_name
ORDER BY total_sold DESC
LIMIT 3;

-- Query 16: Average order value

SELECT ROUND(AVG(amount),2) AS average_order_value
FROM payments;

-- Query 17: Monthly revenue

SELECT MONTH(payment_date) AS month,
       SUM(amount) AS total_revenue
FROM payments
GROUP BY MONTH(payment_date);

-- Query 18: Rank customers by spending

SELECT c.full_name,
       SUM(p.amount) AS total_spent,
       RANK() OVER(ORDER BY SUM(p.amount) DESC) AS customer_rank
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id
INNER JOIN payments p
ON o.order_id = p.order_id
GROUP BY c.full_name;

-- Query 19: Employee with highest orders

SELECT e.full_name,
       COUNT(o.order_id) AS total_orders
FROM employees e
INNER JOIN orders o
ON e.employee_id = o.employee_id
GROUP BY e.full_name
ORDER BY total_orders DESC
LIMIT 1;

-- Query 20: Revenue by category

SELECT c.category_name,
       SUM(od.quantity * od.unit_price) AS total_revenue
FROM categories c
INNER JOIN menu_items m
ON c.category_id = m.category_id
INNER JOIN order_details od
ON m.item_id = od.item_id
GROUP BY c.category_name
ORDER BY total_revenue DESC;