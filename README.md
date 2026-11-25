# Retail Sales Analysis SQL Project

## Project Overview

**Project Title:** Retail Sales Analysis  
**Level:** Beginner to Intermediate  
**Database:** `retail_sales` (PostgreSQL)

This project demonstrates end-to-end SQL skills used by data analysts to explore, clean, and analyze retail transaction data. It covers database schema setup, null-value inspection and cleaning, exploratory data analysis (EDA), and solving 10 practical business questions using SQL queries.

---

## Objectives

1. **Database Setup:** Create and populate the `retail_sales` database table.
2. **Data Cleaning:** Identify and remove records containing missing (`NULL`) values.
3. **Exploratory Data Analysis (EDA):** Perform basic aggregations to understand total revenue, transaction volume, and unique customer count.
4. **Business Analysis:** Answer key business questions using SQL filtering, grouping, aggregations, and Common Table Expressions (CTEs).

---

## Project Structure

### 1. Database Setup

- **Table Creation:** Create a table named `retail_sales` to store transaction details including transaction ID, date, time, customer demographics, product category, quantity, unit price, cost of goods sold (`cogs`), and total sale amount.

```sql
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
```

---

### 2. Data Exploration & Cleaning

- **Preview Data & Row Count:** Inspect the first 100 rows and verify total record count.
- **Null Check & Removal:** Check every column for `NULL` values and delete incomplete records.

```sql
-- Loading / Previewing the Dataset
SELECT *
FROM retail_sales
LIMIT 100;

-- Checking the total number of rows
SELECT COUNT(*) AS total_count
FROM retail_sales;

-- Checking for NULL values across all columns
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
WHERE age IS NULL
   OR quantity IS NULL
   OR price_per_unit IS NULL
   OR cogs IS NULL
   OR total_sale IS NULL;
```

---

### 3. Exploratory Data Analysis (EDA)

```sql
-- 1. Total Sales
SELECT SUM(total_sale) AS total_sales
FROM retail_sales;

-- 2. Total Customer Transactions
SELECT COUNT(customer_id) AS total_transactions
FROM retail_sales;

-- 3. Total Distinct Customers
SELECT COUNT(DISTINCT customer_id) AS total_unique_customers
FROM retail_sales;
```

---

### 4. Data Analysis & Business Key Problems & Answers

#### Q.1 Write a SQL query to retrieve all columns for sales made on `'2022-11-05'`.
```sql
SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';
```

#### Q.2 Write a SQL query to retrieve all transactions where the category is `'Clothing'` and the quantity sold is at least 4 in the month of `Nov-2022`.
```sql
SELECT *
FROM retail_sales
WHERE category = 'Clothing'
  AND quantity >= 4
  AND EXTRACT(YEAR FROM sale_date) = 2022
  AND EXTRACT(MONTH FROM sale_date) = 11;
```

#### Q.3 Write a SQL query to calculate the total sales (`total_sale`) for each category.
```sql
SELECT
    category,
    SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY category
ORDER BY total_sales DESC;
```

#### Q.4 Write a SQL query to find the average age of customers who purchased items from the `'Beauty'` category.
```sql
SELECT
    category,
    ROUND(AVG(age)::numeric, 2) AS average_age
FROM retail_sales
GROUP BY category
HAVING category = 'Beauty';
```

#### Q.5 Write a SQL query to find all transactions where the `total_sale` is greater than `1000`.
```sql
SELECT *
FROM retail_sales
WHERE total_sale > 1000;
```

#### Q.6 Write a SQL query to find the total number of transactions (`transactions_id`) made by each gender in each category.
```sql
SELECT
    gender,
    category,
    COUNT(transactions_id) AS total_number_of_transactions
FROM retail_sales
GROUP BY gender, category;
```

#### Q.7 Write a SQL query to calculate the average sale for each month and rank months by average sales.
```sql
SELECT
    EXTRACT(MONTH FROM sale_date) AS months,
    ROUND(AVG(total_sale)::numeric, 2) AS average_sale
FROM retail_sales
GROUP BY months
ORDER BY average_sale DESC;
```

#### Q.8 Write a SQL query to find the top 5 customers based on the highest total sales.
```sql
SELECT
    customer_id,
    SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;
```

#### Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
```sql
SELECT
    category,
    COUNT(DISTINCT customer_id) AS number_of_unique_customers
FROM retail_sales
GROUP BY category;
```

#### Q.10 Write a SQL query to create each shift and number of orders (Morning `<= 12`, Afternoon Between `12 & 17`, Evening `> 17`).
```sql
WITH shifts AS (
    SELECT
        *,
        CASE
            WHEN EXTRACT(HOUR FROM sale_time) <= 12 THEN 'Morning'
            WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
            WHEN EXTRACT(HOUR FROM sale_time) > 17 THEN 'Evening'
        END AS shift_status
    FROM retail_sales
)
SELECT
    shift_status,
    COUNT(quantity) AS number_of_orders
FROM shifts
GROUP BY shift_status;
```

---

## Key Findings

- **Customer Demographics:** The dataset spans customers across multiple age groups, with purchases distributed across categories such as **Clothing**, **Beauty**, and **Electronics**.
- **High-Value Sales:** Several transactions exceed `1000` in total sale value, highlighting strong premium-item demand.
- **Sales Trends:** Monthly average sales and shift-level order counts reveal clear peak shopping periods across the day and calendar year.
- **Customer Loyalty:** Identifying the top 5 highest-spending customers and unique buyers per category helps pinpoint core revenue drivers.

---

## How to Use

1. Clone this repository or copy the SQL queries above.
2. Create a PostgreSQL database and run the `CREATE TABLE` script.
3. Import your `retail_sales` CSV dataset into the table.
4. Execute the cleaning, EDA, and business analysis queries in **pgAdmin** or **psql**.
