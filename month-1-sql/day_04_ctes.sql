-- Day 4: CTEs and Granularity Matching
-- Schema Setup
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    department VARCHAR(50),
    salary INT
);

INSERT INTO employees (emp_id, emp_name, department, salary) VALUES
(1, 'Arjun', 'Engineering', 100000),
(2, 'Priya', 'Engineering', 80000),
(3, 'Vikram', 'Sales', 60000),
(4, 'Sneha', 'Sales', 40000),
(5, 'Kavya', 'HR', 55000);

-- Query: Employees earning above their department benchmark
WITH dept_avg AS (
    SELECT 
        department, 
        AVG(salary) AS avg_salary
    FROM employees
    GROUP BY department
)
SELECT 
    e.emp_name,
    e.department,
    e.salary,
    d.avg_salary
FROM employees e
JOIN dept_avg d 
    ON e.department = d.department
WHERE e.salary > d.avg_salary;