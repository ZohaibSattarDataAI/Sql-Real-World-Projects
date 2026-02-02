##1:Total users signed up in last 30 days

SELECT COUNT(*) AS new_users_30d
FROM users
WHERE signup_date >= date('now','-30 days');

### 
