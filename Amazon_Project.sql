create database amazon_project;
use amazon_project;

CREATE TABLE amazon_sales (
    order_id VARCHAR(30),
    order_date DATE,
    ship_date DATE,
    email_id VARCHAR(100),
    geography VARCHAR(100),
    category VARCHAR(50),
    product_name VARCHAR(255),
    sales DECIMAL(10,2),
    quantity INT,
    profit DECIMAL(10,2)
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/amazon_sales_clean.csv'
INTO TABLE amazon_sales
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- 1. Total Sales & Profit

SELECT 
    ROUND(SUM(sales),2) AS total_sales,
    ROUND(SUM(profit),2) AS total_profit
FROM amazon_sales;

-- 2. Category-wise Sales

SELECT 
    category,
    ROUND(SUM(sales),2) AS category_sales
FROM amazon_sales
GROUP BY category
ORDER BY category_sales DESC;

-- 3. Top 5 Products by Sales

SELECT 
    product_name,
    ROUND(SUM(sales),2) AS total_sales
FROM amazon_sales
GROUP BY product_name
ORDER BY total_sales DESC
LIMIT 5;

-- 4. Monthly Sales Trend

SELECT 
    MONTH(order_date) AS month,
    ROUND(SUM(sales),2) AS monthly_sales
FROM amazon_sales
GROUP BY month
ORDER BY month;

-- 5. Region-wise Sales (Geography)

SELECT 
    geography,
    ROUND(SUM(sales),2) AS region_sales
FROM amazon_sales
GROUP BY geography
ORDER BY region_sales DESC;

-- 6. Profitability Check (Loss Products)

SELECT 
    product_name,
    profit
FROM amazon_sales
WHERE profit < 0;

