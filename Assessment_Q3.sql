 use adashi_staging;
WITH last_transaction_date_by_customer AS(
SELECT p.id as plan_id,
        p.owner_id,
        CASE
            WHEN p.is_a_fund = 1 THEN 'Investment'
            WHEN p.is_regular_savings = 2 THEN 'Savings'
            ELSE 'Other'
        END AS type,
        DATE_FORMAT(MAX(s.transaction_date), '%Y-%m-%d') AS last_transaction_date
FROM plans_plan p
JOIN savings_savingsaccount s ON s.plan_id = p.id
GROUP BY p.id, p.owner_id, type
) 

 SELECT  plan_id,
         owner_id,
         type,
         last_transaction_date,
         DATEDIFF(CURDATE(), last_transaction_date) AS inactivity_days
FROM last_transaction_date_by_customer
WHERE DATEDIFF(CURDATE(), last_transaction_date) > 365
ORDER BY inactivity_days ASC;