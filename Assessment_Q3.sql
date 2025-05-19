USE adashi_staging;
-- Account Inactivity Alert
-- the query Finds all active accounts (savings or investments) with no transactions in the last 1 year (365 days)

-- CTE to evaluate the last date of transaction for each customer's plan
WITH last_transaction_date_by_customer AS(
SELECT p.id as plan_id,
        p.owner_id,
        CASE 
            WHEN p.is_a_fund = 1 THEN 'Investment'
            WHEN p.is_regular_savings = 1 THEN 'Savings'
            ELSE 'Other'
        END AS type,
        DATE_FORMAT(MAX(s.transaction_date), '%Y-%m-%d') AS last_transaction_date
FROM plans_plan p
JOIN savings_savingsaccount s ON s.plan_id = p.id
GROUP BY p.id, p.owner_id, type
) 

-- Query to evaluate customers with no transaction in the last 365 days
 SELECT  plan_id,
         owner_id,
         type,
         last_transaction_date,
         DATEDIFF(CURDATE(), last_transaction_date) AS inactivity_days
FROM last_transaction_date_by_customer
WHERE DATEDIFF(CURDATE(), last_transaction_date) > 365 -- Filter date that are not active for more that 365 days
        AND type IN ('Savings', 'Investment')
ORDER BY inactivity_days ASC;