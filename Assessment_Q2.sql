-- Transaction Frequency Analysis
-- This query classofies customers based on their transaction frenquency and average number of transaction per month.

-- CTES to calculate transaction frequency and average number of transactions per month per customer
WITH transaction_frequency_per_customer AS (
    SELECT owner_id,
           COUNT(*) AS total_transactions,
           MAX(transaction_date) AS last_transaction_date,
           MIN(transaction_date) AS first_transaction_date,
           PERIOD_DIFF(
            DATE_FORMAT(MAX(transaction_date), '%Y%m'), 
            DATE_FORMAT(MIN(transaction_date), '%Y%m')
           )+1 AS no_of_active_months
    FROM savings_savingsaccount
    GROUP BY owner_id
),
-- CTE to calculate the average number of transactions per month and grouping the frequency into categories
customers_by_category AS (
    SELECT owner_id,
              total_transactions,
              no_of_active_months,
              (total_transactions/no_of_active_months) AS avg_transactions_per_month,
              CASE 
                WHEN (total_transactions/no_of_active_months) >= 10 THEN 'High Frequency'
                WHEN (total_transactions/no_of_active_months) BETWEEN 3 AND 9 THEN 'Medium Frequency'
                ELSE 'Low Frequency'
              END AS frequency_category
    FROM transaction_frequency_per_customer
)

SELECT frequency_category,
         COUNT(*) AS customer_count,
         ROUND(AVG(avg_transactions_per_month), 2) AS avg_transactions_per_month
FROM customers_by_category
GROUP BY frequency_category;