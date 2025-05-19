-- CTES to calculate the average profit per transaction for each customer
WITH Avg_Transaction_amount_per_customer AS(SELECT u.id AS owner_id,
        CONCAT(u.first_name, ' ', u.last_name) AS name, -- customer name
        PERIOD_DIFF(DATE_FORMAT(CURDATE(), '%Y%m'), DATE_FORMAT(u.date_joined, '%Y%m')) + 1 AS tenure_months, -- tenure in months
        COUNT (s.id) AS total_transactions,
        COALESCE(ROUND(AVG(s.confirmed_amount) * 0.001, 2), 0) AS avg_profit_transaction
FROM users_customuser u
LEFT JOIN savings_savingsaccount s ON u.id = s.owner_id
GROUP BY u.id, name)

-- Query to calculate the estimated customer lifetime value (CLV) based on average transaction amount and tenure
SELECT owner_id,
       name,
       tenure_months,
       total_transactions,
       ROUND((total_transactions/tenure_months * 12 *avg_profit_transaction), 2) AS estimated_clv
FROM Avg_Transaction_amount_per_customer
ORDER BY estimated_clv DESC