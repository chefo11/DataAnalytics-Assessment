# DataAnalytics-Assessment

## Assessment_Q1.sql: High-Value Customers with Multiple Products

### Task
To find customers with at least one funded savings plan **and** one funded investment plan, sorted by total deposits.

### Approach
- Used a **Common Table Expression (CTE)** to evaluate customers with at least one funded savings plan:
  - Performed an **INNER JOIN** between the `savings_savingsaccount` and `plans_plan` tables.
  - Used the `WHERE` clause to filter for regular savings plans (`is_regular_savings = 1`) and those that are funded (`confirmed_amount > 0`).
  - Used `COUNT()` to get the number of savings plans per customer.
  - Used `SUM()` to calculate the total confirmed amount per customer.

- Evaluated customers with at least one funded investment plan using another CTE:
  - Performed an **INNER JOIN** between the `savings_savingsaccount` and `plans_plan` tables.
  - Filtered for investment plans (`is_funded = 1`) and those that are funded (`confirmed_amount > 0`).
  - Used `COUNT()` and `SUM()` similarly to the savings CTE.

- Joined the `funded_savings_customers` and investment customer CTEs to retain only those with both savings and investment plans.
- Summed the total savings and investment values to get the total deposit per high-value customer.

### Challenges
- The `name` column in `users_customuser` was mostly null, so I concatenated `first_name` and `last_name` using `CONCAT()` and aliased it as `name`.
- Ensured only customers with both types of plans were included using an `INNER JOIN`.

---

## Assessment_Q2.sql: Transaction Frequency Analysis

### Task
To calculate the average number of transactions per customer per month and categorize them.

### Approach
- Created a CTE to evaluate transaction frequency per customer and the number of months between the first and last transaction dates in `savings_savingsaccount`:
  - Used `COUNT()` to count transactions.
  - Used `MIN()`, `MAX()`, and `PERIOD_DIFF()` to calculate the number of months, and added 1 to include the first month.

- Evaluated average transactions per month for each customer and categorized them (high to low frequency) using a `CASE` statement.

- Grouped the final CTE (`customers_by_category`) by frequency category and calculated:
  - Average transaction frequency
  - Customer count

### Challenges
- Ensured the calculation of months included the first transaction month.
- Used `DATE_FORMAT()` and `PERIOD_DIFF()` for month difference extraction.

---

## Assessment_Q3.sql: Account Inactivity Alert

### Task
To find all active accounts (savings or investments) with no transactions in the last 1 year (365 days).

### Approach
- Created a CTE to evaluate and categorize each active plan and retrieve its last transaction date.
- Wrote a query to:
  - Use `DATEDIFF()` to compute inactivity days.
  - Filter for savings or investment plans inactive for more than 365 days.

### Challenges
- Clearly categorized savings, investments, and other plans using a `CASE` statement.
- Used proper filtering (`WHERE` clause with `AND`) to ensure only relevant accounts were returned.

---

## Assessment_Q4.sql: Customer Lifetime Value (CLV) Estimation

### Task
To estimate the Customer Lifetime Value (CLV) for each customer.

### Approach
- Wrote a CTE to calculate:
  - Tenure in months (from `date_joined` to `CURDATE()`)
  - Total number of transactions
  - Average profit per transaction (assumed as 0.1% of transaction amount)

- Used a `LEFT JOIN` between `users_customuser` and `savings_savingsaccount` to retain all customers, including those without transactions.
- Concatenated `first_name` and `last_name` as `name` for consistent naming.
- Returned CLV values using the formula:
<prev>```CLV = (total_transactions / tenure) * 12 * avg_profit_per_transaction```</prev>

- Ordered the results by CLV in descending order.

### Challenges
- Needed to ensure customers without transactions were still included in the output — handled with a `LEFT JOIN`.
- Used the `ORDER BY` clause on the calculated `estimated_CLV` for correct ranking.

