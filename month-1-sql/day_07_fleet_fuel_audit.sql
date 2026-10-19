-- Day 7: Solo Synthesis Challenge - Fleet Fuel Audit
-- Combines CTE, DENSE_RANK() partitioning, and Window SUM() aggregation.

-- 1. Schema Setup
CREATE TABLE truck_deliveries (
    delivery_id INT PRIMARY KEY,
    city VARCHAR(50),
    driver_id INT,
    fuel_spent INT
);

INSERT INTO truck_deliveries (delivery_id, city, driver_id, fuel_spent) VALUES
(101, 'Mumbai', 11, 120),
(102, 'Mumbai', 12, 90),
(103, 'Mumbai', 13, 40),
(104, 'Bengaluru', 21, 200),
(105, 'Bengaluru', 22, 150),
(106, 'Bengaluru', 23, 100);

-- 2. Audit Pipeline Query
WITH truck_orders AS (
    SELECT 
        city, 
        delivery_id, 
        fuel_spent, 
        -- Rank deliveries from highest to lowest fuel consumption per city
        DENSE_RANK() OVER (
            PARTITION BY city 
            ORDER BY fuel_spent DESC
        ) AS city_fuel_rank,
        -- Calculate total fuel consumed across the entire city partition
        SUM(fuel_spent) OVER (
            PARTITION BY city
        ) AS city_total_fuel
    FROM truck_deliveries
)
SELECT 
    city, 
    delivery_id, 
    fuel_spent, 
    city_fuel_rank, 
    city_total_fuel 
FROM truck_orders 
WHERE city_fuel_rank <= 2
ORDER BY city ASC, city_fuel_rank ASC;