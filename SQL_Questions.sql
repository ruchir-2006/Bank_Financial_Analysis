USE finance_bank ;


SELECT * FROM customers;
SELECT * FROM accounts;
SELECT * FROM branches;
SELECT * FROM cards;
SELECT * FROM transactions;
SELECT * FROM loans;
SELECT * FROM loan_payments;
SELECT * FROM investments;


-- Q1) Find the total number of customers registered in each city, sorted from highest to lowest. The bank wants to identify which cities have the strongest customer base.

-- SELECT COUNT(customer_id) , city 
-- FROM customers
-- GROUP BY city
-- ORDER BY COUNT(customer_id) DESC;


-- Q2) What is the average annual income of customers grouped by their occupation? Identify which professions are the highest earning segments for the bank.

-- SELECT occupation , ROUND(AVG(annual_income) ) AS Average_Income 
-- FROM customers 
-- GROUP BY occupation 
-- ORDER BY Average_Income DESC;

-- Q3) Find the total, minimum, maximum and average balance across all active savings accounts. This gives the treasury team a quick health-check on deposit funds.

-- SELECT ROUND(SUM(balance)) , MAX(balance) , MIn(balance) , ROUND(AVG(balance)) 
-- FROM accounts 
-- ORDER BY ROUND(SUM(balance)) , MAX(balance) , MIn(balance) , ROUND(AVG(balance)) DESC;

-- Q4) How many loans has the bank issued for each loan type (Home Loan, Car Loan, Personal Loan, etc.)? Sort the results to show the most popular loan type first.

-- SELECT COUNT(loan_id) , loan_type 
-- FROM loans
-- GROUP BY loan_type 
-- ORDER BY COUNT(loan_id) DESC;

-- Q5) Which transaction channel (Mobile App, UPI, ATM, Branch, etc.) has generated the highest total transaction amount? The digital team needs this for channel strategy.

-- SELECT channel , COUNT(transaction_id)
-- FROM transactions 
-- GROUP BY channel
-- ORDER BY COUNT(transaction_id) DESC;

-- Q6) List the top 5 branches by the total number of accounts opened. The operations team uses this to allocate resources to the busiest branches.

-- SELECT b.branch_name , COUNT(account_id) AS Total_Count
-- FROM branches b 
-- INNER JOIN accounts a ON a.branch_id = b.branch_id
-- GROUP BY b.branch_name
-- ORDER BY Total_Count DESC LIMIT 5;

-- Q7 ) Find all customers whose credit score is between 750 and 850 (premium segment). The credit team uses this list to offer pre-approved loan products.

-- SELECT first_name, last_name 
-- FROM customers
-- WHERE credit_score BETWEEN 750 AND 850
-- ORDER BY first_name,last_name  ASC ;

-- Q8) How many loans are currently in NPA (Non-Performing Asset) status? Also show the total outstanding amount at risk. Critical metric for the risk management team

-- SELECT COUNT(loan_id) ,status , ROUND(SUM(outstanding_amount))
-- FROM loans 
-- WHERE status = 'NPA';

-- Q9) List each customer's full name, city, account type and current balance. The relationship manager team needs this combined view to prioritise outreach calls.

-- SELECT c.first_name ,c.last_name, a.account_type ,ROUND(a.balance)
-- FROM customers c
-- LEFT JOIN accounts a 
-- ON c.customer_id = a.customer_id
-- GROUP BY  c.first_name ,c.last_name, a.account_type ,ROUND(a.balance);

-- Q10) Find all customers who have taken a Home Loan, along with the branch where the loan was issued, the principal amount and the current loan status.

-- SELECT c.first_name ,c.last_name , l.loan_type , b.branch_name
-- FROM loans l
-- INNER JOIN customers c
-- ON l.customer_id = c.customer_id
-- INNER JOIN branches b
-- ON l.branch_id = b.branch_id 
-- WHERE l.loan_type = 'Home Loan';

-- Q11) How many transactions were made each year from 2020 to 2025? Also show the total amount transacted per year. The finance team tracks this for annual performance reports.

-- SELECT COUNT(transaction_id) , YEAR(transaction_date) , ROUND(SUM(amount))
-- FROM transactions
-- GROUP BY YEAR(transaction_date) 
-- ORDER BY COUNT(transaction_id) , ROUND(SUM(amount)) DESC;


-- Q12) List all customers who joined the bank in 2023, along with their occupation and credit score. Marketing wants to analyse the profile of the bank's most recent acquisition cohort.

-- SELECT first_name, last_name , YEAR(join_date) , occupation , credit_score 
-- FROM customers
-- WHERE YEAR(join_date) = '2023';

-- Q13) Find the total investment amount grouped by investment type and risk rating. The wealth management team uses this to see where customers prefer to park their money.

-- SELECT ROUND(SUM(invested_amount)) , investment_type , risk_rating
-- FROM investments
-- GROUP BY investment_type , risk_rating
-- ORDER BY ROUND(SUM(invested_amount))DESC ;


-- Q14) Which customers have a credit card outstanding balance greater than 50% of their credit limit? This high utilisation ratio signals potential default risk to the collections team.

-- SELECT c.first_name , c.last_name , ca.credit_limit, ca.outstanding_balance 
-- FROM customers c
-- INNER JOIN cards ca 
-- ON c.customer_id = ca.customer_id 
-- WHERE outstanding_balance > 0.5*(credit_limit)
-- ORDER BY outstanding_balance  DESC;


-- Q15) Find the top 10 customers by total transaction amount across all their accounts. Include the customer's full name, city and total amount spent. Useful for VIP relationship management.

-- SELECT c.first_name , c.last_name,city, ROUND(SUM(amount)) 
-- FROM customers c
-- INNER JOIN accounts a
-- ON c.customer_id = a.customer_id
-- INNER JOIN transactions t 
-- ON t.account_id = a.account_id
-- GROUP BY c.first_name , c.last_name,city
-- ORDER BY ROUND(SUM(amount)) DESC LIMIT 10;

-- Q16 )Find all customers who have both an active loan AND an active investment. These are the most financially engaged customers and are prime targets for cross-sell campaigns.

-- SELECT c.first_name, c.last_name , l.loan_type , i.investment_type
-- FROM customers c
-- INNER JOIN loans l
-- ON c.customer_id = l.customer_id
-- INNER JOIN investments i
-- ON l.customer_id = i.customer_id
-- GROUP BY c.first_name, c.last_name , l.loan_type , i.investment_type;

-- Q17) Which branch has the highest total outstanding loan amount? Also show how many loans are active vs NPA per branch. Critical for the credit monitoring dashboard.

-- SELECT 
--     b.branch_name,
--     SUM(l.outstanding_amount) AS total_outstanding,
--     COUNT(CASE WHEN l.status = 'Active' THEN 1 END) AS active_loans,
--     COUNT(CASE WHEN l.status = 'NPA' THEN 1 END) AS npa_loans
-- FROM branches b
-- JOIN loans l 
--     ON b.branch_id = l.branch_id
-- GROUP BY b.branch_name
-- ORDER BY total_outstanding DESC;

-- Q18) Find all customers who made a late loan payment in 2023 or 2024. Show their name, loan type, payment date, and late fee charged. The collections team follows up on these accounts.

-- SELECT c.first_name , c.last_name , l.loan_type , lp.late_fee , lp.payment_date
-- FROM customers c
-- INNER JOIN loans l
-- ON c.customer_id = l.customer_id 
-- INNER JOIN loan_payments lp
-- ON l.loan_id = lp.loan_id 
-- WHERE YEAR(payment_date) IN ( '2023' , '2024' ) AND lp.late_fee > 0;



-- Q20) For each loan type, find the average interest rate, average EMI amount and total principal disbursed. Segment the results by loan status (Active, Closed, NPA). Used in the monthly credit risk report.

-- SELECT loan_type , ROUND(AVG(interest_rate)) , ROUND(AVG(emi_amount)), ROUND(SUM(principal_amount)) , status
-- FROM loans 
-- GROUP BY  loan_type, status;


-- ------------------------------------------------- WINDOWS FUNCTION ----------------------------------------------------------------------------

-- Q21) Rank customers within each city based on their total account balance from highest to lowest. Use RANK(). The regional team uses this to identify the wealthiest customers city-by-city.

-- SELECT 
-- c.customer_id, c.first_name,c.last_name,c.city,
-- SUM(a.balance) AS total_balance,
--     RANK() OVER (
--         PARTITION BY c.city
--         ORDER BY SUM(a.balance) DESC
--     ) AS rank_in_city
-- FROM customers c
-- JOIN accounts a 
-- ON c.customer_id = a.customer_id
-- GROUP BY c.customer_id, c.city,c.first_name,c.last_name;

-- Q22) Calculate a running total of transaction amounts for each account, ordered by transaction date. 
-- This running balance helps identify which accounts are rapidly growing or draining.

-- SELECT 
--     account_id,
--     transaction_date,
--     amount,
--     
--     SUM(amount) OVER (
--         PARTITION BY account_id
--         ORDER BY transaction_date
--     ) AS running_balance

-- FROM transactions;

-- Q23) Find the month-over-month change in total loan disbursements for 2023. Use LAG() to compare each month's total against the previous month. The lending team tracks this for growth targets.

-- WITH monthly_data AS (
--     SELECT 
--         MONTH(disbursement_date) AS month,
--         SUM(amount) AS total_disbursed
--     FROM loans
--     WHERE YEAR(disbursement_date) = 2023
--     GROUP BY MONTH(disbursement_date)
-- )
-- SELECT 
--     month,
--     total_disbursed,
--     
--     LAG(total_disbursed) OVER (ORDER BY month) AS prev_month,
--     
--     total_disbursed - LAG(total_disbursed) OVER (ORDER BY month) 
--     AS mom_change
-- FROM monthly_data;

-- Q24) Using DENSE_RANK(), find the top 3 highest spending customers within each occupation group. HR and the premium banking team use this to decide who deserves relationship manager assignment.

-- SELECT 
--     customer_id,
--     current_value,
--     invested_amount,
--     
--     PERCENT_RANK() OVER (
--         ORDER BY current_value DESC
--     ) AS percentile_rank

-- FROM investments;

-- Q25) For each customer, calculate their investment portfolio's current value vs invested amount and show their percentile rank (PERCENT_RANK or NTILE) among all investors.
--      Wealth management uses this to tier customers into Bronze, Silver and Gold segments.

-- SELECT 
--     customer_id,
--     current_value,
--     invested_amount,
--     
--     PERCENT_RANK() OVER (
--         ORDER BY current_value DESC
--     ) AS percentile_rank

-- FROM investments;


