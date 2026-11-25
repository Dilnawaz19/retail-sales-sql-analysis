-- Create Table
DROP TABLE IF EXISTS retail_sales;

CREATE TABLE retail_sales
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(50),
    age INT,
    category VARCHAR(50),
    quantity INT,
    price_per_unit FLOAT,
    cogs FLOAT,
    total_sale FLOAT
);

-- Loading the Dataset
SELECT 
	*
FROM retail_sales
LIMIT 100;

-- Checking the total no. of rows
SELECT 
	   COUNT(*) AS total_count
FROM retail_sales;

-- Checking the NULL values
SELECT
    SUM(CASE WHEN transactions_id IS NULL THEN 1 ELSE 0 END) AS transactions_id_null,
    SUM(CASE WHEN sale_date IS NULL THEN 1 ELSE 0 END) AS sale_date_null,
    SUM(CASE WHEN sale_time IS NULL THEN 1 ELSE 0 END) AS sale_time_null,
    SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) AS customer_id_null,
    SUM(CASE WHEN gender IS NULL THEN 1 ELSE 0 END) AS gender_null,
    SUM(CASE WHEN age IS NULL THEN 1 ELSE 0 END) AS age_null,
    SUM(CASE WHEN category IS NULL THEN 1 ELSE 0 END) AS category_null,
    SUM(CASE WHEN quantity IS NULL THEN 1 ELSE 0 END) AS quantity_null,
    SUM(CASE WHEN price_per_unit IS NULL THEN 1 ELSE 0 END) AS price_per_unit_null,
    SUM(CASE WHEN cogs IS NULL THEN 1 ELSE 0 END) AS cogs_null,
    SUM(CASE WHEN total_sale IS NULL THEN 1 ELSE 0 END) AS total_sale_null
FROM retail_sales;

-- Fixing the NULL values with deletion method
DELETE FROM retail_sales
WHERE age IS NULL OR 
	  quantity IS NULL OR 
	  price_per_unit IS NULL OR 
	  cogs IS NULL OR 
	  total_sale IS NULL;

-- Exploratory Data Analysis

-- 1.Total Sales
SELECT 
	   SUM(total_sale) AS total_sales
FROM retail_sales;

-- 2.Total Customers
SELECT 
	   COUNT(customer_id) AS total_sales
FROM retail_sales;

-- 3.Total Distinct Customers
SELECT 
	   COUNT(DISTINCT(customer_id)) AS total_sales
FROM retail_sales;

-- Data Analysis & Business Key Problems & Answers
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'
SELECT 
	   * 
FROM retail_sales
WHERE sale_date = '2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' 
-- and the quantity sold is more than 10 in the month of Nov-2022
SELECT 
	   *
FROM retail_sales
WHERE category = 'Clothing'
  AND quantity >= 4
  AND EXTRACT(YEAR FROM sale_date) = 2022
  AND EXTRACT(MONTH FROM sale_date) = 11

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
SELECT 
	   category,
	   SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY category
ORDER BY total_sales DESC;
  
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT 
	   category,
	   ROUND(AVG(age),2) AS average_age
FROM retail_sales
GROUP BY category
HAVING category = 'Beauty';

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT 
	   *
FROM retail_sales
WHERE total_sale > 1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id)
-- made by each gender in each category.
SELECT 
	   gender,
	   category,  
	   COUNT(transactions_id) AS total_number_of_transactions
FROM retail_sales
GROUP BY gender,
	     category;


-- Q.7 Write a SQL query to calculate the average sale for each month. 
-- Find out best selling month in each year.
SELECT 
    EXTRACT(MONTH FROM sale_date) AS months,
    ROUND(AVG(total_sale)::numeric, 2) AS average_sale
FROM retail_sales
GROUP BY months
ORDER BY average_sale DESC;

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales
SELECT 
    customer_id,
    SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;

-- Q.9 Write a SQL query to find the number of unique customers
-- who purchased items from each category.
SELECT 
	category,
    COUNT(DISTINCT (customer_id)) AS number_of_unique_customers
FROM retail_sales
GROUP BY category

-- Q.10 Write a SQL query to create each shift and number of orders 
-- (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
WITH shifts AS
(SELECT 
	   *,
	   CASE
		WHEN EXTRACT(HOUR FROM sale_time) <=12 THEN 'Morning'
		WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
		WHEN EXTRACT(HOUR FROM sale_time) > 17 THEN 'Evening'
	END AS shift_status
FROM retail_sales)
SELECT
	   shift_status,
	   COUNT(quantity) AS number_of_orders
FROM shifts
GROUP BY shift_status
	   