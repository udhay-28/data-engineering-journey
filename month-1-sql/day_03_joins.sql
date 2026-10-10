-- Day 03: Multi-Table Joins (INNER vs LEFT JOIN) and Inactive Record Reporting

-- 1. Schema
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_amount INT
);

-- 2. Mock Data
INSERT INTO customers (customer_id, name, city) VALUES
(1, 'Aarav', 'Chennai'),
(2, 'Bhavna', 'Bengaluru'),
(3, 'Chirag', 'Mumbai'),
(4, 'Divya', 'Madurai');

INSERT INTO orders (order_id, customer_id, order_amount) VALUES
(501, 1, 2500),
(502, 1, 1500),
(503, 2, 4000),
(504, 99, 1200);

-- 3. Solution Query
-- Goal: Calculate total spend per customer, keeping users with zero orders.
SELECT 
    c.name,
    c.city,
    COALESCE(SUM(o.order_amount), 0) AS total_spent
FROM customers c
LEFT JOIN orders o 
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name, c.city;