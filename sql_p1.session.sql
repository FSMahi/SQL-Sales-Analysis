--Create Database
CREATE DATABASE sql_p1;
-- Table Create
DROP TABLE IF EXIT retail_sales;
CREATE TABLE retail_sales(
              transactions_id	INT PRIMARY KEY,
              sale_date DATE,
              sale_time TIME,
              customer_id	INT,
              gender VARCHAR(10),
              age	INT,
              category VARCHAR(20),	
              quantity INT,	
              price_per_unit FLOAT,	
              cogs FLOAT,
              total_sale FLOAT);

-- Show only 10 rows
SELECT * FROM retail_sales
LIMIT 10;
-- Counting the Row number
SELECT COUNT(*)
FROM retail_sales;

-- Data Cleaning
SELECT * FROM retail_sales 
WHERE transactions_id IS NULL;

SELECT * FROM retail_sales 
WHERE sale_time IS NULL;

SELECT * FROM retail_sales 
WHERE price_per_unit IS NULL;

SELECT * FROM retail_sales 
WHERE 
transactions_id IS NULL
OR
sale_date IS NULL
OR 
age IS NULL
OR
 category IS NULL
OR
 cogs IS NULL
OR
 customer_id IS NULL
OR
 gender IS NULL
OR
 price_per_unit IS NULL
OR
 quantity IS NULL
OR
 sale_date IS NULL
OR
 sale_time IS NULL
OR
 total_sale IS NULL
;

DELETE FROM retail_sales
WHERE
transactions_id IS NULL
OR
sale_date IS NULL
OR 
age IS NULL
OR
 category IS NULL
OR
 cogs IS NULL
OR
 customer_id IS NULL
OR
 gender IS NULL
OR
 price_per_unit IS NULL
OR
 quantity IS NULL
OR
 sale_date IS NULL
OR
 sale_time IS NULL
OR
 total_sale IS NULL
;

--Data Exploration & Finding
-- How many sales we have?
SELECT COUNT(*) AS total_sale FROM retail_sales;

--How many unique customer we have?
SELECT COUNT(DISTINCT customer_id) AS total_customer 
FROM retail_sales;

--How many unique category we have?
SELECT DISTINCT category 
FROM retail_sales;

--1.Write a SQL query to retrieve all columns for sales made on '2022-05-18:
SELECT * FROM retail_sales
WHERE sale_date = '2022-05-18';

--2.Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:
SELECT transactions_id 
FROM retail_sales
WHERE category = 'Clothing' 
AND quantity > 4 
AND sale_date BETWEEN '2022-11-01' AND '2022-11-30';

--3.Write a SQL query to calculate the total sales (total_sale) for each category.:
SELECT 
category,
SUM(total_sale) AS net_sale,
COUNT(*) as total_orders
FROM retail_sales
GROUP BY category;

--4.Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:
SELECT category,
AVG(age) as average_age
FROM retail_sales
WHERE category='Beauty'
GROUP BY category;

--5.Write a SQL query to find all transactions where the total_sale is greater than 1000.:
SELECT transactions_id,
total_sale
FROM retail_sales
WHERE total_sale > 1000;

--6.Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:
SELECT gender,
category,
COUNT(transactions_id) as total_transaction_number
 FROM retail_sales
 GROUP BY gender,category
 ORDER BY category;

--7.Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
SELECT
 year,
 month,
 average_sale
  FROM
(SELECT  
  EXTRACT(YEAR FROM sale_date) AS year,
  EXTRACT(MONTH FROM sale_date) AS month,
  AVG(total_sale) AS average_sale,
  RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as ranK 
FROM retail_sales
GROUP BY year,month) AS r1
WHERE ranK = 1;

--8.Write a SQL query to find the top 5 customers based on the highest total sales 
SELECT customer_id,
SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;

--9.Write a SQL query to find the number of unique customers who purchased items from each category.:
SELECT category,COUNT(DISTINCT customer_id) as unique_customer
FROM retail_sales
GROUP BY category ;

--10.Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
SELECT 
CASE
WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
ELSE 'Evening'
END AS shift,
COUNT(*) AS number_of_order
FROM retail_sales
GROUP BY shift
ORDER BY number_of_order DESC;

