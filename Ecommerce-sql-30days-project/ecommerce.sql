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

