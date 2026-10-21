-- Day 9: Churn & Inactivity Detection using LEAD()
-- Demonstrates forward-looking window functions, date delta calculation, and churn risk flagging.

-- 1. Schema Setup
CREATE TABLE user_logins (
    user_id INT,
    login_date DATE
);

INSERT INTO user_logins (user_id, login_date) VALUES
(1, '2026-10-01'),
(1, '2026-10-03'),
(1, '2026-10-15'),
(2, '2026-10-01'),
(2, '2026-10-02');

-- 2. Churn & Inactivity Pipeline Query
WITH login_gaps AS (
    SELECT 
        user_id, 
        login_date, 
        -- Peek forward to the user's next login date
        LEAD(login_date, 1) OVER (
            PARTITION BY user_id 
            ORDER BY login_date ASC
        ) AS next_login_date
    FROM user_logins
)
SELECT 
    user_id, 
    login_date, 
    next_login_date, 
    -- Calculate days between sessions; NULL means it is their most recent active session
    (next_login_date - login_date) AS days_until_next_login,
    -- Flag churn risk if gap exceeds 7 days or if no subsequent login exists
    CASE 
        WHEN (next_login_date - login_date) > 7 THEN 'CHURN_RISK'
        WHEN next_login_date IS NULL THEN 'CURRENT_EDGE'
        ELSE 'ACTIVE'
    END AS user_status
FROM login_gaps
ORDER BY user_id ASC, login_date ASC;