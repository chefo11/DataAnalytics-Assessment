# DataAnalytics-Assessment
DataAnalytics-Assessment

## Assessment_Q1.sql: High-Value Customers with Multiple Products

### Task:
 To find customers with at least one funded savings plan AND one funded investment plan, sorted by total deposits

### Approach:

- First all I used (CTE) Common Table Expression to evaluated customers with at least one funded savings plan
    - Performed a JOIN (LEFT INNER JOIN) between the savings_savingsaccount table and plans_plan tables
    - Used the WHERE clause to make use I filter to plans that are regular savings (is_regular_savings = 1) and is funded(comfirmed_amount>0)
    - Used COUNT() count the number of savings plans for each customers
    - Used SUM() to sum the total confirmed amount for each customer
- I evaluated customers with at least one funded investment plan using CTE
    - Performed a JOIN (LEFT INNER JOIN) between the savings_savingsaccount table and plans_plan tables
    - Used the WHERE clause to make use I filter to plans that are investment plans (is_funded=1) and is funded(comfirmed_amount>0)
    - Used COUNT() count the number of savings plans for each customers
    - Used SUM() to sum the total confirmed amount for each customer
- I performed a JOIN between the funded_savings_customers and Investment customers to retain customers with both savings and investment plant
- I sumed the total savings and total investment to get total deposit by each High Value Customers
### Challenges:

- Most of the name column from the users_customuser table is null, I had to concatinate firstname and lastname column and then alias it name.
- I had to ensure that the customers in the final table has both savings and investment plan, I used JOIN (LEFT INNER JOIN) to ensure this.

## Assessment_Q2.sql: Transaction Frequency Analysis

### To calculate the average number of transactions per customer per month and categorize them:
