-- Day 6: Window Functions (DENSE_RANK) & CTE Top-N Filtering
-- Problem: Retrieve the top 2 highest orders per country, handling ties without gaps.

-- 1. Schema Setup
CREATE TABLE customer_orders (
    order_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    country VARCHAR(50),
    order_amount INT
);

INSERT INTO customer_orders (order_id, customer_name, country, order_amount) VALUES
(1, 'Aarav', 'India', 9500),
(2, 'Diya', 'India', 9500),
(3, 'Kabir', 'India', 8200),
(4, 'Liam', 'USA', 12000),
(5, 'Olivia', 'USA', 11000),
(6, 'Noah', 'USA', 9000),
(7, 'Emma', 'UK', 7500);

-- 2. CTE with Window Function Filter
WITH ranked_orders AS (
    SELECT 
        customer_name, 
        country, 
        order_amount, 
        DENSE_RANK() OVER (
            PARTITION BY country 
            ORDER BY order_amount DESC
        ) AS spend_rank 
    FROM customer_orders
) 
SELECT 
    customer_name, 
    country, 
    order_amount, 
    spend_rank 
FROM ranked_orders 
WHERE spend_rank <= 2;