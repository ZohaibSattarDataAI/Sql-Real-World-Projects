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
