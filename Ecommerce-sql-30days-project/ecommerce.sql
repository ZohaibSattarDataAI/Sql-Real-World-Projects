# 1:Total users signed up in last 30 days

SELECT COUNT(*) AS new_users_30d
FROM users
WHERE signup_date >= date('now','-30 days');

### Explanation:
### Counts all users who signed up in the last 30 days.
### Helps track new user acquisition and growth trends.

# 2:Users with no orders in last 30 days
SELECT *
FROM users
WHERE user_id NOT IN (SELECT DISTINCT user_id FROM orders);

### Explanation:
### Lists users who never placed an order.
### Identifies inactive users for retention campaigns.

# 3. Users with only 1 order
  
SELECT user_id, COUNT(order_id) AS order_count
FROM orders
GROUP BY user_id
HAVING COUNT(order_id) = 1;

# Explanation:
# Finds users who purchased only once.
# Useful for measuring repeat purchase potential.

#4. Top 10 active users by order count

SELECT u.user_id, u.first_name, u.last_name, COUNT(o.order_id) AS orders_count
FROM users u
JOIN orders o ON u.user_id = o.user_id
GROUP BY u.user_id
ORDER BY orders_count DESC
LIMIT 10;

# Explanation:
# Shows most active buyers.
# Helps identify loyal customers or VIPs



# 5. Users with frequent product views but no purchase (cart abandonment)

SELECT pv.user_id, COUNT(*) AS views_no_purchase
FROM product_views pv
LEFT JOIN order_items oi 
  ON pv.product_id = oi.product_id AND pv.user_id = oi.user_id
WHERE oi.product_id IS NULL
GROUP BY pv.user_id
ORDER BY views_no_purchase DESC
LIMIT 10;


# Explanation:
# Measures users who frequently browse but never buy.
# Useful for cart abandonment campaigns.


# 6. Average number of products viewed per user per day

SELECT user_id, COUNT(*)/30.0 AS avg_views_per_day
FROM product_views
GROUP BY user_id;

# Explanation:
# Calculates daily average of product views.
# Helps understand user engagement.

# 7. Users who viewed more than 10 products in last 7 days

SELECT user_id, COUNT(*) AS views_count
FROM product_views
WHERE view_date >= date('now','-7 days')
GROUP BY user_id
HAVING COUNT(*) > 10;

# Explanation:
# Finds highly active users.
# Can target them for promotions.


# 8. Users who placed more than 1 order in last 30 days

SELECT user_id, COUNT(order_id) AS order_count
FROM orders
WHERE order_date >= date('now','-30 days')
GROUP BY user_id
HAVING COUNT(order_id) > 1;

# Explanation:
# Identifies repeat buyers.
# Useful for loyalty program tracking.


# 9. Users who abandoned carts (viewed but no order same day)

SELECT DISTINCT pv.user_id
FROM product_views pv
LEFT JOIN orders o 
  ON pv.user_id = o.user_id AND pv.view_date = o.order_date
WHERE o.order_id IS NULL;

# Explanation:
# Detects users who browsed products but never purchased.
# Important for remarketing campaigns.


# 10. Top 5 users by product views

SELECT user_id, COUNT(*) AS views_count
FROM product_views
GROUP BY user_id
ORDER BY views_count DESC
LIMIT 5;

# Explanation:
# Shows most engaged users in terms of browsing.
# Can analyze behavior patterns for targeted marketing.


# 2️⃣ Product Analytics Queries (Days 11–15)

SELECT product_id, COUNT(*) AS views_count
FROM product_views
GROUP BY product_id
ORDER BY views_count DESC
LIMIT 10;

# Explanation:
# Finds products users are most interested in.
# Useful for trending product insights.


# 13. Products purchased multiple times

SELECT product_id, COUNT(*) AS times_sold
FROM order_items
GROUP BY product_id
ORDER BY times_sold DESC
LIMIT 10;

# Explanation:
# Lists top-selling products.
# Shows popular products for inventory planning.

# 14. Low stock products (<20)

SELECT *
FROM products
WHERE stock_quantity < 20;

# Explanation:
# Detects inventory shortage.
# Helps prevent out-of-stock issues

# 15. Products never sold

SELECT *
FROM products
WHERE product_id NOT IN (SELECT DISTINCT product_id FROM order_items);

# Explanation:
# Finds products with zero sales.
# Useful for promotions or discontinuation decisions.

# 16. Most popular categories by total sales

SELECT p.category, COUNT(oi.product_id) AS sold_count
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.category
ORDER BY sold_count DESC;

# Explanation:
# Shows top product categories.
# Supports category-level promotions and stock planning.

# 17. Average quantity sold per product

SELECT product_id, AVG(quantity) AS avg_quantity
FROM order_items
GROUP BY product_id;

# Explanation:
# Determines typical purchase quantity per product.
# Useful for packaging or pricing strategy.

# 18. Products viewed but not purchased

SELECT DISTINCT pv.product_id
FROM product_views pv
LEFT JOIN order_items oi 
  ON pv.product_id = oi.product_id AND pv.user_id = oi.user_id
WHERE oi.product_id IS NULL;

# Explanation:
# Highlights products with interest but low conversion.

# 19. Top 5 products by revenue

SELECT p.product_id, p.product_name, SUM(oi.quantity*oi.price) AS revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_id, p.product_name
ORDER BY revenue DESC
LIMIT 5;

# Explanation:
# Measures products generating the most revenue.
# Key for inventory and pricing decisions.

# 20. Products with highest cart abandonment (views > purchases)

SELECT pv.product_id, COUNT(pv.view_id) - COALESCE(COUNT(oi.order_item_id),0) AS abandonment_count
FROM product_views pv
LEFT JOIN order_items oi 
  ON pv.product_id = oi.product_id AND pv.user_id = oi.user_id
GROUP BY pv.product_id
ORDER BY abandonment_count DESC
LIMIT 10;

# Explanation:
# Shows which products are often browsed but rarely bought.
# Important for marketing, UX improvements.

# Query 21 — Total Revenue in 30 Days
  
SELECT SUM(total_amount) AS total_revenue
FROM sales_dataset_30days;

# Explanation:
# SUM(total_amount) → total revenue calculate karta hai
# Pure 30 din ka business revenue
# Business Use:
# Company ka total sales performance check karna.

# Query 22 — Daily Revenue

SELECT sale_date,
       SUM(total_amount) AS daily_revenue
FROM sales_dataset_30days
GROUP BY sale_date
ORDER BY sale_date;

# Explanation:
# Har date ka total revenue
# GROUP BY sale_date → date-wise aggregation

# Business Use:
# Daily performance tracking.

# Query 23 — Top 5 Revenue Generating Products
  
SELECT product_name,
       SUM(total_amount) AS revenue
FROM sales_dataset_30days
GROUP BY product_name
ORDER BY revenue DESC
LIMIT 5;

# Explanation:
# Product-wise revenue calculate
# Highest earning products identify
# Business Use:
# Inventory & marketing decisions.

# Query 24 — Average Order Value (AOV)
  
SELECT AVG(total_amount) AS avg_order_value
FROM sales_dataset_30days;

# Explanation:
# Har sale ka average amount
# AOV ecommerce KPI hota hai
# Business Use:
# Pricing strategy optimize karne ke liye.

# Query 25 — Revenue by Category
  
SELECT category,
       SUM(total_amount) AS category_revenue
FROM sales_dataset_30days
GROUP BY category
ORDER BY category_revenue DESC;

# Explanation:
# Category-wise revenue
# Business Use:
# Product expansion decisions.
# Explanation:
# Har date ka total revenue
# GROUP BY sale_date → date-wise aggregation
# Business Use:
# Daily performance tracking.


# Query 26 — Running Total Revenue (Window Function)
SELECT sale_date,
       SUM(total_amount) AS daily_revenue,
       SUM(SUM(total_amount)) OVER (ORDER BY sale_date) AS running_total
FROM sales_dataset_30days
GROUP BY sale_date
ORDER BY sale_date;

# Explanation:
# Daily revenue calculate
# OVER (ORDER BY sale_date) → cumulative total
# Business Use:
# Growth trend monitoring.

# Query 27 — Rank Products by Revenue
  
SELECT product_name,
       SUM(total_amount) AS revenue,
       RANK() OVER (ORDER BY SUM(total_amount) DESC) AS revenue_rank
FROM sales_dataset_30days
GROUP BY product_name;

# Explanation:
# Revenue calculate
# RANK() → product ranking
# Business Use:
# Top performers highlight karna.

# Query 28 — Customer Lifetime Value (CLV)
  
SELECT customer_id,
       customer_name,
       SUM(total_amount) AS customer_lifetime_value
FROM sales_dataset_30days
GROUP BY customer_id, customer_name
ORDER BY customer_lifetime_value DESC;

# Explanation:
# Har customer ka total spend
# High-value customers identify
# Business Use:
# VIP targeting.


# Query 29 — Customers With More Than 3 Purchases
SELECT customer_id,
       customer_name,
       COUNT(sale_id) AS total_orders
FROM sales_dataset_30days
GROUP BY customer_id, customer_name
HAVING COUNT(sale_id) > 3;

# Explanation:
# HAVING aggregation filter karta hai
# Repeat customers identify karta hai

# Business Use:
# Loyalty program targeting.

# Query 30 — 3-Day Moving Average Revenue
  
SELECT sale_date,
       SUM(total_amount) AS daily_revenue,
       AVG(SUM(total_amount)) OVER (
           ORDER BY sale_date
           ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
       ) AS moving_avg_3_days
FROM sales_dataset_30days
GROUP BY sale_date
ORDER BY sale_date;

# Explanation:
# Last 3 days ka average revenue
#Trend smoothing ke liye use hota hai

# Business Use:
# Short-term sales trend analysis.
