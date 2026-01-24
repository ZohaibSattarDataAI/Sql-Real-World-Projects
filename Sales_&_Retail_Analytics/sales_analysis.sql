-- ==================================================
-- SQL Portfolio Project: Sales & Retail Analytics
-- Author: Zohaib Sattar
-- Dataset: sales_dataset_30days.csv
-- Purpose: 1-Month Daily SQL Practice
-- ==================================================

-- Select Table From Database
SELECT * FROM Analysis_sql
WHERE customer_id=164;

-- Day 2: Total revenue per product
SELECT product_name, SUM(total_amount) AS Total_Revenue 
FROM Analysis_sql
GROUP BY product_name
ORDER BY Total_Revenue DESC;

-- Day 3: Top 5 customers by spending

SELECT customer_name, SUM(total_amount) AS Top_Customer
FROM Analysis_sql
GROUP BY customer_name
ORDER BY Top_Customer DESC
LIMIT 5;

-- Day 4: Total quantity sold per category

SELECT category, SUM(quantity) AS total_quantity
FROM Analysis_sql
GROUP BY category;

-- Day 5: Daily revenue trend
SELECT substr(sale_date,1,10) AS Date_Wise,
SUM(total_amount) AS Trend
FROM Analysis_sql
GROUP BY Date_Wise
ORDER BY Trend DESC;

-- Day 6: Average order amount per customer
SELECT customer_id, customer_name , AVG(total_amount) as avg_order
FROM Analysis_sql
GROUP BY customer_id , customer_name
ORDER BY avg_order DESC;

-- Day 7: Products sold more than 2 units
SELECT product_name, SUM(quantity) AS units_sold
FROM Analysis_sql
GROUP BY product_name
HAVING SUM(quantity) > 2;

-- Day 8: Customers with more than 1 purchase
SELECT customer_id, COUNT(*) AS purchase_count
FROM Analysis_sql
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- Day 9: Ranking products by revenue

SELECT product_name, SUM(total_amount) AS revenue,
       RANK() OVER(ORDER BY SUM(total_amount)DESC) AS rank_product
FROM Analysis_sql
GROUP BY product_name;

-- Day 10: Window function - cumulative revenue
SELECT substr(sale_date,1,10) as Sales_Date, SUM(total_amount) 
      OVER (ORDER BY sale_date) AS cumulative_revenue
FROM Analysis_sql;

-- Day 11: Join example with products table (if exists)
-- Assuming another table: products(product_id, product_name, category, price)
-- SELECT s.sale_id, s.sale_date, p.product_name, s.quantity, s.total_amount
-- FROM sales s
-- INNER JOIN products p ON s.product_id = p.product_id;

-- Day 12: Subquery example

SELECT customer_id,total_amount
FROM Analysis_sql
WHERE total_amount >(SELECT AVG(total_amount)FROM Analysis_sql);

-- Day 13: Group by + having + order

SELECT category,SUM(total_amount) AS revenue
FROM Analysis_sql
GROUP BY category
HAVING SUM(total_amount)>200
ORDER BY revenue DESC;

-- Day 14: Distinct customers

SELECT DISTINCT(customer_name),
FROM Analysis_sql;

-- Day 15: Count products per customer
SELECT customer_id, COUNT(DISTINCT product_id) AS products_bought
FROM Analysis_sql
GROUP BY customer_id;

-- Day 16: String function example
SELECT customer_name, UPPER(customer_name) AS name_upper
FROM Analysis_sql;

-- Day 17: Date function example
SELECT sale_date, EXTRACT(DAY FROM sale_date) AS day, SUM(total_amount) AS revenue
FROM Analysis_sql
GROUP BY sale_date;

-- Day 18: CTE example
WITH revenue_per_product AS (
    SELECT product_name, SUM(total_amount) AS revenue
    FROM Analysis_sql
    GROUP BY product_name
)
SELECT * FROM revenue_per_product
WHERE revenue > 500;

-- Day 19: Ranking customers by revenue
SELECT customer_id, SUM(total_amount) AS revenue,
       DENSE_RANK() OVER (ORDER BY SUM(total_amount) DESC) AS rank
FROM sales
GROUP BY customer_id;

-- Day 20: Monthly revenue trend (if dataset covers multiple months)
-- SELECT DATE_TRUNC('month', sale_date) AS month, SUM(total_amount) AS monthly_revenue
-- FROM sales
-- GROUP BY month
-- ORDER BY month;

-- Day 21: Moving average (3-day)
-- SELECT sale_date, AVG(total_amount) OVER (ORDER BY sale_date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS moving_avg
-- FROM sales;

-- Day 22: Top product per day
SELECT sale_date, product_name, SUM(quantity) AS units_sold,
       RANK() OVER (PARTITION BY sale_date ORDER BY SUM(quantity) DESC) AS daily_rank
FROM sales
GROUP BY sale_date, product_name;

-- Day 23: Subquery with IN
SELECT customer_name, total_amount
FROM sales
WHERE product_id IN (SELECT product_id FROM sales WHERE category='Electronics');

-- Day 24: Subquery with EXISTS
SELECT customer_name
FROM sales s
WHERE EXISTS (SELECT 1 FROM sales WHERE customer_id=s.customer_id AND total_amount>500);
