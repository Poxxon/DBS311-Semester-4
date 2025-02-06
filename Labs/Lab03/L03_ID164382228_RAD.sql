-- ***********************
-- Name: Pouya Rad
-- ID: 164382228
-- Date: Jan 30 2025
-- Purpose: Lab 3 DBS311
-- ***********************
-- 1.	Write a SQL query to display the last name and hire date of all employees 
-- who were hired before the employee with ID 107 got hired. Sort the result by the hire date.
SELECT HIRE_DATE 
FROM EMPLOYEES 
WHERE EMPLOYEE_ID = 107;

SELECT LAST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE HIRE_DATE < (SELECT HIRE_DATE FROM EMPLOYEES WHERE EMPLOYEE_ID = 107);

-- 2.	Write a SQL query to display customer name and credit limit for customers 
-- with lowest credit limit. Sort the result by customer name.
SELECT MIN(CREDIT_LIMIT) 
FROM CUSTOMERS;

SELECT NAME, CREDIT_LIMIT 
FROM CUSTOMERS 
WHERE CREDIT_LIMIT = (SELECT MIN(CREDIT_LIMIT) FROM CUSTOMERS)
ORDER BY NAME;

-- 3.	Write a SQL query to display the product ID, product name, and list price of 
-- the highest paid product(s) in each category.  Sort by category ID. 
SELECT CATEGORY_ID, MAX(LIST_PRICE)
FROM PRODUCTS
GROUP BY CATEGORY_ID;

SELECT CATEGORY_ID, PRODUCT_ID, PRODUCT_NAME, LIST_PRICE
FROM PRODUCTS
WHERE LIST_PRICE = ANY (SELECT MAX(LIST_PRICE) FROM PRODUCTS GROUP BY CATEGORY_ID)
ORDER BY CATEGORY_ID;

-- 4.	Write a SQL query to display the category name of the most expensive 
-- (highest list price) product(s).
SELECT MAX(LIST_PRICE) FROM PRODUCTS;

SELECT c.CATEGORY_NAME, p.LIST_PRICE
FROM PRODUCTS p
INNER JOIN PRODUCT_CATEGORIES c ON p.CATEGORY_ID = c.CATEGORY_ID
WHERE LIST_PRICE = (SELECT MAX(LIST_PRICE) FROM PRODUCTS);

-- 5.	Write a SQL query to display product name and list price for products in category 1 
-- which have the list price less than the lowest list price in ANY category.  Sort the output 
-- by top list prices first and then by the product name.
SELECT MIN(LIST_PRICE) FROM PRODUCTS;

SELECT PRODUCT_NAME, LIST_PRICE 
FROM PRODUCTS
WHERE CATEGORY_ID = 1 AND LIST_PRICE < ANY (SELECT MIN(LIST_PRICE) FROM PRODUCTS GROUP BY CATEGORY_ID)
ORDER BY LIST_PRICE, PRODUCT_NAME;

-- 6.	Display product ID, product name, and category ID for products of the category(s) 
-- that the lowest price product belongs to.
SELECT MIN(LIST_PRICE) FROM PRODUCTS GROUP BY CATEGORY_ID;

SELECT LIST_PRICE, PRODUCT_ID, PRODUCT_NAME, CATEGORY_ID
FROM PRODUCTS
WHERE LIST_PRICE < ANY (SELECT MIN(LIST_PRICE) FROM PRODUCTS GROUP BY CATEGORY_ID);

