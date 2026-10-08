-- Day 01: Core Aggregations, WHERE vs HAVING

-- 1. Table Schema
CREATE TABLE salaries (
    emp_id INT PRIMARY KEY,
    department VARCHAR(50),
    base_salary INT,
    bonus INT,
    role VARCHAR(20)
);

-- 2. Mock Data
INSERT INTO salaries (emp_id, department, base_salary, bonus, role) VALUES
(1, 'Engineering', 65000, 5000, 'Full-time'),
(2, 'Engineering', 45000, 0, 'Intern'),
(3, 'Engineering', 70000, 10000, 'Full-time'),
(4, 'Operations', 30000, 2000, 'Full-time'),
(5, 'Operations', 28000, 1000, 'Full-time'),
(6, 'Marketing', 50000, 4000, 'Full-time'),
(7, 'Marketing', 20000, 0, 'Intern');

-- 3. Solution Query
-- Goal: Total compensation (base + bonus) per department for full-time employees,
--       only showing departments where total spend > 100,000.
SELECT 
    department, 
    SUM(base_salary + bonus) AS total_payout
FROM salaries
WHERE role = 'Full-time'
GROUP BY department
HAVING SUM(base_salary + bonus) > 100000;