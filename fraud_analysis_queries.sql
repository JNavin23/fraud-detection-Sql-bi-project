CREATE DATABASE credit_card_project;
USE credit_card_project;



-- 1. Total Transactions

SELECT COUNT(*) AS total_transactions
FROM transactions;

-- 2. Total Fraud vs Genuine Transactions

SELECT 
    Fraud_label, 
    COUNT(*) AS total_transactions
FROM transactions
GROUP BY Fraud_label;

-- 3. Total Amount by Transaction Type

SELECT 
    Fraud_label, 
    SUM(amount) AS total_amount
FROM transactions
GROUP BY Fraud_label;

-- 4. Average Transaction Amount by Type

SELECT 
    Fraud_label, 
    ROUND(AVG(amount), 2) AS avg_amount
FROM transactions
GROUP BY Fraud_label;

-- 5. Transaction Distribution by Amount Range

SELECT 
    Amount_Range, 
    COUNT(*) AS total_transactions
FROM transactions
GROUP BY Amount_Range
ORDER BY total_transactions DESC;

-- 6. Fraud Count by Amount Range

SELECT 
    Amount_Range,
    COUNT(*) AS fraud_transactions
FROM transactions
WHERE Fraud_label = 'Fraud'
GROUP BY Amount_Range
ORDER BY fraud_transactions DESC;


-- 7. Fraud Percentage by Amount Range

SELECT 
    Amount_Range,
    COUNT(*) AS total_transactions,
    SUM(CASE WHEN Fraud_label = 'Fraud' THEN 1 ELSE 0 END) AS fraud_count,
    ROUND(
        SUM(CASE WHEN Fraud_label = 'Fraud' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 
        2
    ) AS fraud_percentage
FROM transactions
GROUP BY Amount_Range
ORDER BY fraud_percentage DESC;

-- 8. Top 10 Highest Amount Fraud Transactions

SELECT *
FROM transactions
WHERE Fraud_label = 'Fraud'
ORDER BY amount DESC
LIMIT 10;