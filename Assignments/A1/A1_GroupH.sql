-- 1. Display the employee number, full employee name, job title, and hire date
-- of all employees hired in September with the most recently hired employees displayed first. 
SELECT EMPLOYEE_ID,
LAST_NAME  || ', ' || FIRST_NAME AS "Full Name",
JOB_TITLE, TO_CHAR(HIRE_DATE, 'Month ddth "of" YYYY') AS "Start Date"
FROM EMPLOYEES
WHERE HIRE_DATE = ANY (SELECT HIRE_DATE FROM EMPLOYEES WHERE HIRE_DATE > TO_DATE('2016-08-30', 'YYYY-MM-DD'))
AND HIRE_DATE = ANY (SELECT HIRE_DATE FROM EMPLOYEES WHERE HIRE_DATE < TO_DATE('2016-10-1', 'YYYY-MM-DD'))
ORDER BY "Start Date" DESC;
 
-- 2. The company wants to see the total sale amount per sales person
-- (salesman) for all orders. Assume that online orders do not have any
-- sales representative. For online orders (orders with no salesman ID),
-- consider the salesman ID as 0. Display the salesman ID and the total
-- sale amount for each employee.
-- Sort the result according to employee number.
SELECT ORDERS.SALESMAN_ID,
       SUM(ORDER_ITEMS.UNIT_PRICE * ORDER_ITEMS.QUANTITY)
AS "Total Sales"
FROM ORDERS
LEFT JOIN ORDER_ITEMS ON ORDERS.ORDER_ID = ORDER_ITEMS.ORDER_ID
WHERE ORDERS.SALESMAN_ID IS NOT NULL
GROUP BY ORDERS.SALESMAN_ID
UNION
SELECT 0 AS SALESMAN_ID,
       SUM(ORDER_ITEMS.UNIT_PRICE * ORDER_ITEMS.QUANTITY)
AS "Total Sales"
FROM ORDERS
LEFT JOIN ORDER_ITEMS ON ORDERS.ORDER_ID = ORDER_ITEMS.ORDER_ID
WHERE ORDERS.SALESMAN_ID IS NULL
ORDER BY SALESMAN_ID ASC;
 
-- 3. Display customer Id, customer name and total number of orders for
-- customers that the value of their customer ID is in values from 35 to 45.
-- Include the customers with no orders in your report if their customer
-- ID falls in the range 35 and 45.  
-- Sort the result by the value of total orders.
SELECT CUSTOMERS.CUSTOMER_ID,
CUSTOMERS.NAME,
COUNT(ORDERS.CUSTOMER_ID) AS "Total Orders"
FROM CUSTOMERS
LEFT JOIN ORDERS ON CUSTOMERS.CUSTOMER_ID = ORDERS.CUSTOMER_ID
WHERE CUSTOMERS.CUSTOMER_ID BETWEEN 35 AND 45
GROUP BY CUSTOMERS.CUSTOMER_ID, CUSTOMERS.NAME
ORDER BY "Total Orders";

-- 4. Display customer ID, customer name, and the order ID and the order date of all 
-- orders for customer whose ID is 44.
-- a. Show also the total quantity and the total amount of each customer’s order.
-- b. Sort the result from the highest to lowest total order amount.
SELECT c.customer_id, c.name AS customer_name, o.order_id, o.order_date,
       SUM(oi.quantity) AS total_quantity,
       SUM(oi.quantity * oi.unit_price) AS total_amount
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
WHERE c.customer_id = 44
GROUP BY c.customer_id, c.name, o.order_id, o.order_date
ORDER BY total_amount DESC;
 
-- 5. Display customer Id, name, total number of orders, the total number of 
-- items ordered, and the total order amount for customers who have more than 30 orders. 
-- Sort the result based on the total number of orders.
SELECT 
    c.customer_id AS "Customer ID",
    c.name AS "Name",
    COUNT(o.order_id) AS "Total Number of Orders",
    SUM(oi.quantity) AS "Total Items",
    SUM(oi.quantity * oi.unit_price) AS "Total Amount"
FROM  customers c
JOIN orders o 
ON c.customer_id = o.customer_id
JOIN  order_items oi 
ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.name
HAVING COUNT(o.order_id) > 30
ORDER BY "Total Number of Orders" ASC;
 
-- 6. Display Warehouse Id, warehouse name, product category Id, product category name, 
-- and the lowest product standard cost for this combination.
-- • In your result, include the rows that the lowest standard cost is less then $200.
-- • Also, include the rows that the lowest cost is more than $500.
-- • Sort the output according to Warehouse Id, warehouse name and then product category Id, 
--   and product category name.
SELECT w.warehouse_id, w.warehouse_name,
       pc.category_id, pc.category_name,
       MIN(p.standard_cost) AS lowest_standard_cost
FROM warehouses w
JOIN inventories i ON w.warehouse_id = i.warehouse_id
JOIN products p ON i.product_id = p.product_id
JOIN product_categories pc ON p.category_id = pc.category_id
GROUP BY w.warehouse_id, w.warehouse_name, pc.category_id, pc.category_name
HAVING MIN(p.standard_cost) < 200 OR MIN(p.standard_cost) > 500
ORDER BY w.warehouse_id, w.warehouse_name, pc.category_id, pc.category_name;
 
-- 7. Display the total number of orders per month. Sort the result from January to December.
SELECT TO_CHAR(order_date, 'Month') AS month,
       COUNT(*) AS total_orders
FROM orders
GROUP BY TO_CHAR(order_date, 'Month'), TO_NUMBER(TO_CHAR(order_date, 'MM'))
ORDER BY TO_NUMBER(TO_CHAR(order_date, 'MM'));

-- 8. Display product Id, product name for products that their list price is more than any 
-- highest product standard cost per warehouse outside Americas regions.
-- (You need to find the highest standard cost for each warehouse that is located outside 
-- the Americas regions. Then you need to return all products that their list price is higher 
-- than any highest standard cost of those warehouses.)
-- Sort the result according to list price from highest value to the lowest.
SELECT p.product_id AS "Product ID", p.product_name AS "Product Name", TO_CHAR(p.list_price, '$999,999.99') AS "Price"
FROM products p
WHERE p.list_price > ANY (SELECT MAX(pr.standard_cost) AS max_standard_cost FROM warehouses w 
        JOIN locations l ON w.location_id = l.location_id 
        JOIN countries c ON l.country_id = c.country_id
        JOIN  products pr ON pr.product_id IN (SELECT   i.product_id FROM   inventories i WHERE   i.warehouse_id = w.warehouse_id)
WHERE c.region_id NOT IN (SELECT   region_id FROM  regions WHERE  region_name = 'Americas')
GROUP BY  w.warehouse_id)
ORDER BY p.list_price DESC;

-- 9. Write a SQL statement to display the most expensive and the cheapest product (list price). 
-- Display product ID, product name, and the list price.
SELECT product_id AS "Product ID", product_name AS "Product Name", TO_CHAR(list_price, '$999,999.99') AS "Price"
FROM products
WHERE list_price = (SELECT MAX(list_price) FROM products)
UNION
SELECT product_id AS "Product ID", product_name AS "Product Name", TO_CHAR(list_price, '$999,999.99') AS "Price"
FROM products
WHERE list_price = (SELECT MIN(list_price) FROM products);

-- 10.	Write a SQL query to display the number of customers with total order amount over the 
-- average amount of all orders



