-- Day 5: CTE Benchmarks & Granularity Matching
-- Problem: Flag delivery drivers burning more fuel than their hub's peer average.

-- 1. Schema Setup
CREATE TABLE truck_deliveries (
    truck_id INT PRIMARY KEY,
    driver_name VARCHAR(50),
    hub_city VARCHAR(50),
    fuel_cost INT
);

INSERT INTO truck_deliveries (truck_id, driver_name, hub_city, fuel_cost) VALUES
(101, 'Karthik', 'Bengaluru', 4200),
(102, 'Ramesh', 'Bengaluru', 3100),
(103, 'Suresh', 'Bengaluru', 2900),
(104, 'Manoj', 'Chennai', 5100),
(105, 'Anand', 'Chennai', 3800),
(106, 'Dinesh', 'Madurai', 2200),
(107, 'Vijay', 'Madurai', 3400);

-- 2. CTE Benchmark & Filter Query
WITH hub_benchmarks AS (
    -- Step 1: Compute baseline average per hub
    SELECT 
        hub_city, 
        AVG(fuel_cost) AS avg_fuel 
    FROM truck_deliveries 
    GROUP BY hub_city
)
-- Step 2: Join individual driver grain to the hub benchmark
SELECT 
    t.driver_name, 
    t.hub_city, 
    t.fuel_cost, 
    ROUND(b.avg_fuel, 2) AS avg_fuel 
FROM truck_deliveries t 
JOIN hub_benchmarks b 
    ON t.hub_city = b.hub_city 
WHERE t.fuel_cost > b.avg_fuel;