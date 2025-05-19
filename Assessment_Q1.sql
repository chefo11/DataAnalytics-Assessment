USE adashi_staging;
-- Finding High-Value Customers with Multiple Products
-- This SQL query identifies customers who have both a savings and an investment plan (cross-selling opportunity).


-- CTES for customers with at least one funded savings plan
WITH funded_savings_customers AS (
  SELECT 
    s.owner_id, 
    COUNT(s.id) AS savings_count, 
    SUM(s.confirmed_amount) AS total_savings 
  FROM 
    savings_savingsaccount s 
    JOIN plans_plan p ON s.plan_id = p.id 
  WHERE 
    confirmed_amount > 0 
    AND p.is_regular_savings = 1 
  GROUP BY 
    s.owner_id
), 
-- CTES for customers with at least one investment plan
funded_investment_customers AS (
  SELECT 
    s.owner_id, 
    COUNT(s.id) AS investment_count, 
    SUM(s.confirmed_amount) AS total_investment 
  FROM 
    savings_savingsaccount s 
    JOIN plans_plan p ON s.plan_id = p.id 
  WHERE 
    confirmed_amount > 0 
    AND p.is_a_fund = 1 
  GROUP BY 
    s.owner_id
)

-- Final query: Customer with at least one funded savings plan and one funded investment plan, sorted by total deposit
SELECT 
  u.id AS owner_id, 
  CONCAT(u.first_name, ' ', u.last_name) AS name, 
  s.savings_count, 
  i.investment_count, 
  ROUND(
    (
      s.total_savings + i.total_investment
    )/ 100, 
    2
  ) AS total_deposit -- Converted to Naira
FROM 
  users_customuser u 
  JOIN funded_savings_customers s ON u.id = s.owner_id 
  JOIN funded_investment_customers i ON u.id = i.owner_id 
ORDER BY 
  total_deposit DESC;
