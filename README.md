# DataAnalytics-Assessment
DataAnalytics-Assessment

## Assessment_Q1.sql

### Task:
 To find customers with at least one funded savings plan AND one funded investment plan, sorted by total deposits

### Approach:

- First all I used (CTES) Common Table Expression to evaluated customers with at least on savings account
    - Performed a JOIN (LEFT INNER JOIN) between the savings_savingsaccount table and plans_plan tables
    - Used the WHERE clause to make use I filter to plans that are regular savings and made sure the confirmed amount is greater than 0
    - Used COUNT() count the number of savings plans for each customers
    - Used SUM() to sum the total confirmed amount for each customer

### Challenges:

- 
