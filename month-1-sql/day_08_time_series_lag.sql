-- Day 8: Time-Series Analysis with LAG()
-- Demonstrates row offset retrieval, chronological ordering, and delta tracking.

CREATE TABLE merchant_transactions (
    merchant_id INT,
    txn_date DATE,
    total_volume INT
);

INSERT INTO merchant_transactions (merchant_id, txn_date, total_volume) VALUES
(1, '2026-10-01', 100),
(1, '2026-10-02', 150),
(1, '2026-10-03', 90),
(2, '2026-10-01', 200),
(2, '2026-10-02', 180);

SELECT 
    merchant_id, 
    txn_date, 
    total_volume, 
    LAG(total_volume, 1, 0) OVER (
        PARTITION BY merchant_id 
        ORDER BY txn_date ASC
    ) AS prev_volume,
    LAG(total_volume, 1, 0) OVER (
        PARTITION BY merchant_id 
        ORDER BY txn_date ASC
    ) - total_volume AS volume_drop
FROM merchant_transactions
ORDER BY merchant_id ASC, txn_date ASC;