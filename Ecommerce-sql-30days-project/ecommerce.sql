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


