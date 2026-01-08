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
