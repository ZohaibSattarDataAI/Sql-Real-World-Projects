Transaction_ID
Customer_ID
Transaction_Date
Transaction_Type
Amount
Merchant_Category
City
Payment_Method
Is_Fraud




# ✅ DAY 1 – Basic Queries
  
# 1️⃣ Total Number of Transactions
  
SELECT COUNT(*) AS total_transactions
FROM banking_transactions;

# 2️⃣ Total Revenue
  
SELECT SUM(Amount) AS total_revenue
FROM banking_transactions;

# 3️⃣ Average Transaction Amount
  
SELECT AVG(Amount) AS avg_transaction
FROM banking_transactions;

# 4️⃣ Maximum Transaction
  
SELECT MAX(Amount) AS highest_transaction
FROM banking_transactions;

# 5️⃣ Minimum Transaction
  
SELECT MIN(Amount) AS lowest_transaction
FROM banking_transactions;

# ✅ DAY 2 – Group By
  
# 6️⃣ Transactions by City
  
SELECT City, COUNT(*) AS total_transactions
FROM banking_transactions
GROUP BY City;

# 7️⃣ Revenue by Merchant Category
  
SELECT Merchant_Category, SUM(Amount) AS total_revenue
FROM banking_transactions
GROUP BY Merchant_Category
ORDER BY total_revenue DESC;

# 8️⃣ Transactions by Payment Method
  
SELECT Payment_Method, COUNT(*) AS total
FROM banking_transactions
GROUP BY Payment_Method;

# ✅ DAY 3 – Fraud Analysis
  
# 9️⃣ Total Fraud Cases
SELECT COUNT(*) AS total_fraud
FROM banking_transactions
WHERE Is_Fraud = 1;

# 🔟 Fraud Percentage
SELECT 
    (COUNT(CASE WHEN Is_Fraud = 1 THEN 1 END) * 100.0 / COUNT(*)) AS fraud_percentage
FROM banking_transactions;

# 1️⃣1️⃣ Fraud by Payment Method
  
SELECT Payment_Method,
       COUNT(*) AS fraud_cases
FROM banking_transactions
WHERE Is_Fraud = 1
GROUP BY Payment_Method
ORDER BY fraud_cases DESC;

# ✅ DAY 4 – Date Analysis
  
# 1️⃣2️⃣ Monthly Revenue
  
SELECT 
    MONTH(Transaction_Date) AS month,
    SUM(Amount) AS revenue
FROM banking_transactions
GROUP BY MONTH(Transaction_Date)
ORDER BY month;

# 1️⃣3️⃣ Daily Transactions Count
  
SELECT 
    Transaction_Date,
    COUNT(*) AS daily_transactions
FROM banking_transactions
GROUP BY Transaction_Date
ORDER BY Transaction_Date;

# ✅ DAY 5 – Customer Insights
  
$ 1️⃣4️⃣ Top 10 High Value Customers
  
SELECT Customer_ID,
       SUM(Amount) AS total_spent
FROM banking_transactions
GROUP BY Customer_ID
ORDER BY total_spent DESC
LIMIT 10;

# 1️⃣5️⃣ Customers With More Than 10 Transactions
  
SELECT Customer_ID,
       COUNT(*) AS total_transactions
FROM banking_transactions
GROUP BY Customer_ID
HAVING COUNT(*) > 10;

# ✅ DAY 6 – Advanced Filtering
  
# 1️⃣6️⃣ High Value Transactions (>1000)
  
SELECT *
FROM banking_transactions
WHERE Amount > 1000;

# 1️⃣7️⃣ High Value & Fraud Transactions
  
SELECT *
FROM banking_transactions
WHERE Amount > 1000
AND Is_Fraud = 1;


# ✅ DAY 7 – Case Statements
  
# 1️⃣8️⃣ Customer Segmentation
  
SELECT Customer_ID,
       SUM(Amount) AS total_spent,
       CASE
           WHEN SUM(Amount) < 1000 THEN 'Low'
           WHEN SUM(Amount) BETWEEN 1000 AND 5000 THEN 'Medium'
           ELSE 'High'
       END AS customer_segment
FROM banking_transactions
GROUP BY Customer_ID;


# ✅ DAY 8 – Window Functions (Data Scientist Level)
  
# 1️⃣9️⃣ Rank Customers by Spending
  
SELECT Customer_ID,
       SUM(Amount) AS total_spent,
       RANK() OVER (ORDER BY SUM(Amount) DESC) AS spending_rank
FROM banking_transactions
GROUP BY Customer_ID;


# ✅ DAY 9 – Fraud Risk Patterns
  
# 2️⃣1️⃣ Fraud by City
  
SELECT City,
       COUNT(*) AS fraud_cases
FROM banking_transactions
WHERE Is_Fraud = 1
GROUP BY City
ORDER BY fraud_cases DESC;

# 2️⃣2️⃣ Fraud Rate by Merchant Category
  
SELECT Merchant_Category,
       COUNT(CASE WHEN Is_Fraud = 1 THEN 1 END) * 100.0 / COUNT(*) AS fraud_rate
FROM banking_transactions
GROUP BY Merchant_Category
ORDER BY fraud_rate DESC;

# DAY 10 – Advanced Analytics
  
# 2️⃣3️⃣ Average Fraud Amount
  
SELECT AVG(Amount) AS avg_fraud_amount
FROM banking_transactions
WHERE Is_Fraud = 1;

# 2️⃣4️⃣ Non-Fraud vs Fraud Comparison
  
SELECT Is_Fraud,
       COUNT(*) AS total_transactions,
       AVG(Amount) AS avg_amount
FROM banking_transactions
GROUP BY Is_Fraud;

# DAY 11 – Anomaly Detection Logic
  
# 2️⃣5️⃣ Transactions Above 95th Percentile
  
SELECT *
FROM banking_transactions
WHERE Amount > (
    SELECT PERCENTILE_CONT(0.95) 
    WITHIN GROUP (ORDER BY Amount)
    FROM banking

# DAY 12 – Time Based Fraud Detection
  
# 2️⃣6️⃣ Fraud Transactions Per Month
  
SELECT 
    MONTH(Transaction_Date) AS month,
    COUNT(*) AS fraud_cases
FROM banking_transactions
WHERE Is_Fraud = 1
GROUP BY MONTH(Transaction_Date)
ORDER BY month;

# DAY 13 – Payment Risk Analysis
  
# 2️⃣7️⃣ Fraud Rate by Payment Method
SELECT Payment_Method,
  
       COUNT(CASE WHEN Is_Fraud = 1 THEN 1 END) * 100.0 / COUNT(*) AS fraud_rate
FROM banking_transactions
GROUP BY Payment_Method
ORDER BY fraud_rate DESC;

# DAY 14 – High Risk Customers
  
# 2️⃣8️⃣ Customers With More Than 2 Fraud Transactions
  
SELECT Customer_ID,
       COUNT(*) AS fraud_count
FROM banking_transactions
WHERE Is_Fraud = 1
GROUP BY Customer_ID
HAVING COUNT(*) > 2;

# DAY 15 – Advanced Window & Partition
  
# 2️⃣9️⃣ Customer Wise Running Spending
  
SELECT Customer_ID,
       Transaction_Date,
       Amount,
       SUM(Amount) OVER (PARTITION BY Customer_ID 
                         ORDER BY Transaction_Date) AS running_spending
FROM banking_transactions;

# DAY 16 – ML Preparation
  
# 3️⃣0️⃣ Create Feature Table for ML
SELECT Customer_ID,
       COUNT(*) AS total_transactions,
       SUM(Amount) AS total_spent,
       AVG(Amount) AS avg_amount,
       SUM(CASE WHEN Is_Fraud = 1 THEN 1 ELSE 0 END) AS fraud_count
FROM banking_transactions
GROUP BY Customer_ID;
