-- Day 02: Handling NULLs and Three-Valued Logic with COALESCE

-- 1. Table Schema
CREATE TABLE customer_orders (
    order_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    item_price INT,
    discount_amount INT,
    shipping_fee INT
);

-- 2. Mock Data
INSERT INTO customer_orders (order_id, customer_name, item_price, discount_amount, shipping_fee) VALUES
(201, 'Aarav', 1500, 200, 50),
(202, 'Bhavna', 3200, NULL, 100),
(203, 'Chirag', 850, 50, NULL),
(204, 'Divya', 4000, NULL, NULL),
(205, 'Esha', 1200, 150, 0);

-- 3. Solution Query
SELECT 
    customer_name, 
    item_price - COALESCE(discount_amount, 0) + COALESCE(shipping_fee, 0) AS final_bill
FROM customer_orders
WHERE item_price - COALESCE(discount_amount, 0) + COALESCE(shipping_fee, 0) > 1000;