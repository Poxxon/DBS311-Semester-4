
-- Q1: For each job title display the number of employees.
-- Display the job titles and the number of employees in each.  
SELECT JOB_TITLE as "Job Title", COUNT(*) AS "Number of employees per title"
FROM EMPLOYEES
GROUP BY JOB_TITLE;

-- Q2: Display the Highest, Lowest and Average customer credit limits. Name these results High, 
-- Low and Avg. Add a column that shows the difference between the highest and lowest credit limits.
-- Use the round function to display two digits after the decimal point.
SELECT MAX(CREDIT_LIMIT) AS "Max", MIN(CREDIT_LIMIT) AS "Min", ROUND(AVG(CREDIT_LIMIT), 2) AS "Average",
(MAX(CREDIT_LIMIT) - MIN(CREDIT_LIMIT)) AS "Difference"
FROM CUSTOMERS;

-- Q3: Display the order id and the total order amount for orders with the total amount over $1000,000. 
SELECT ORDER_ID, SUM(QUANTITY * UNIT_PRICE) AS total_amount
FROM ORDER_ITEMS
GROUP BY ORDER_ID
HAVING SUM(QUANTITY * UNIT_PRICE) > 1000000;

-- Q4: Display the warehouse id, warehouse name, and the total number of products for each warehouse. 
SELECT i.warehouse_id, w.warehouse_name, SUM(QUANTITY) AS "Total Products"
FROM INVENTORIES i
LEFT JOIN WAREHOUSES w ON i.WAREHOUSE_ID = w.WAREHOUSE_ID
GROUP BY i.WAREHOUSE_ID, w.WAREHOUSE_NAME
ORDER BY i.WAREHOUSE_ID;

-- Q5: For each customer display the number of orders issued by the customer. If the customer does not have any orders, the result show display 0.
SELECT c.CUSTOMER_ID, c.NAME, COUNT(o.ORDER_ID)
FROM CUSTOMERS c
LEFT JOIN ORDERS o ON c.CUSTOMER_ID = c.CUSTOMER_ID
GROUP BY c.CUSTOMER_ID, c.NAME;

-- ***********************
-- Name: Pouya Rad
-- ID: 164382228
-- Date: Jan 15 2025
-- Purpose: Lab 1 DBS311
-- ***********************
-- Q6: Write a SQL query to show the total and the average sale amount for each category.

