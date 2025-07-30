-- Creating a Database Sales Retail Analysis- P1
CREATE DATABASE project_sales_retail_p1;

-- Creating a Table.

DROP TABLE IF EXISTS sql_retail_sales_analysis;
CREATE TABLE sql_retail_sales_analysis
(
	transactions_id INT PRIMARY KEY,
	sale_date DATE,
	sale_time TIME,
	customer_id INT,
	gender VARCHAR(15),
	age INT,
	category VARCHAR(15),
	quantity INT,
	price_per_unit FLOAT,
	cogs FLOAT,
	total_sale FLOAT
);

SELECT * FROM sql_retail_sales_analysis;

-- checking for Nulls value for each columns.
-- Cleaning the Data.
SET SQL_SAFE_UPDATES = 0;
DELETE FROM sql_retail_sales_analysis
where transactions_id = 'None'
	OR sale_date = 'None'
    OR sale_time = 'None'
    OR customer_id = 'None'
    OR gender = 'None'
    OR category = 'None'
    OR quantiy = 'None'
    OR price_per_unit = 'None'
    OR cogs = 'None'
    OR total_sale = 'None';

SELECT *
FROM sql_retail_sales_analysis
WHERE quantiy = 'None' OR quantiy IS NULL
LIMIT 10;

-- Data Exploration

-- 1. How many sales we have?
SELECT 
count(*) as total_sales
FROM sql_retail_sales_analysis;

-- 2. How many Customers we have?
SELECT count(Distinct customer_id) as Total_customers
from  sql_retail_sales_analysis;

-- 3. How many category we have?
SELECT count(DISTINCT category) as total_category
FROM sql_retail_sales_analysis;

SELECT DISTINCT category as category
FROM sql_retail_sales_analysis;
