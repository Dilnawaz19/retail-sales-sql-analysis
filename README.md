# Retail Sales SQL Analysis (PostgreSQL)

An end-to-end SQL exploratory data analysis (EDA) and business problem-solving project on a retail sales dataset (`retail_sales`).

## Dataset Overview
The dataset tracks retail transactions with the following columns:
- `transactions_id`: Unique transaction identifier
- `sale_date`: Date of the transaction
- `sale_time`: Time of the transaction
- `customer_id`: Unique customer identifier
- `gender`: Customer gender (`Male` / `Female`)
- `age`: Customer age
- `category`: Product category (`Clothing`, `Beauty`, `Electronics`, etc.)
- `quantity`: Units sold per transaction
- `price_per_unit`: Price per unit
- `cogs`: Cost of goods sold
- `total_sale`: Total transaction value

## Business Questions Answered
1. **Specific Date Sales:** Retrieve all columns for sales made on `'2022-11-05'`.
2. **Filtered Transactions (Nov 2022):** Retrieve transactions in the `'Clothing'` category during `Nov-2022` meeting the quantity filter.
3. **Total Sales by Category:** Calculate `total_sale` for each product category.
4. **Average Customer Age (Beauty):** Find the average age of customers who bought from `'Beauty'`.
5. **High-Value Transactions:** Find all transactions where `total_sale` is greater than `1000`.
6. **Transactions by Gender & Category:** Count total transactions (`transactions_id`) for each gender within each category.
7. **Average Monthly Sales:** Calculate average sales per month (and identify top-performing periods).
8. **Top 5 Customers:** Rank the top 5 customers by highest total sales.
9. **Unique Customers by Category:** Count distinct customers per category.
10. **Orders by Shift:** Group orders into `Morning` (`<= 12`), `Afternoon` (`12` to `17`), and `Evening` (`> 17`) based on `sale_time`.

## How to Run
1. Open **pgAdmin** / **PostgreSQL** and create a database (e.g., `sql_project_p1`).
2. Run the table creation and import your CSV dataset into `retail_sales`.
3. Execute the queries in `sql/retail_sales_analysis.sql`.
