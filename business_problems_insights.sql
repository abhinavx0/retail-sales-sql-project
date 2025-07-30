-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
SELECT 
	transactions_id, sale_date, sale_time, customer_id, gender, age, category, quantiy, price_per_unit, cogs, total_sale
FROM sql_retail_sales_analysis
Where sale_date = '2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022

SELECT *
FROM sql_retail_sales_analysis
WHERE category = 'Clothing' 
AND DATE_FORMAT(sale_date, '%Y-%m')  = '2022-11' AND quantiy >= 4;

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
SELECT category,
	SUM(total_sale),
    count(*) as total_order
FROM sql_retail_sales_analysis
Group BY category;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT category,
	Avg(age)
FROM sql_retail_sales_analysis
WHERE category = 'Beauty'
Group BY category;

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT *
FROM sql_retail_sales_analysis
where total_sale > 1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
SELECT 
  category,
  gender,
	count(transactions_id)
FROM sql_retail_sales_analysis
GROUP BY category,gender;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year.
SELECT 
    year,
    month,
    avg_sale
FROM (
    SELECT 
        EXTRACT(YEAR FROM sale_date) AS year,
        EXTRACT(MONTH FROM sale_date) AS month,
        AVG(total_sale) AS avg_sale,
        RANK() OVER (
            PARTITION BY EXTRACT(YEAR FROM sale_date)
            ORDER BY AVG(total_sale) DESC
        ) AS rnk
    FROM sql_retail_sales_analysis
    GROUP BY EXTRACT(YEAR FROM sale_date), EXTRACT(MONTH FROM sale_date)
) AS t
WHERE rnk = 1;

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
SELECT DISTINCT customer_id,
	sum(total_sale)
FROM sql_retail_sales_analysis
GROUP BY customer_id
Order by sum(total_sale) DESC
Limit 5;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT 
	category,
	count(DISTINCT customer_id) unique_customers
FROM sql_retail_sales_analysis
Group BY category;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
SELECT transactions_id,
	sale_date,
    CASE WHEN sale_time between '00:00:00' AND '12:00:00' Then 'Morning'
		 WHEN sale_time between '12:00:01' AND '17:00:00' Then 'Afternoon'
         ElSE 'Evening'
	END as sale_shift,
    customer_id,
    total_sale
FROM sql_retail_sales_analysis; 
