-- ***********************
-- Name: Pouya Rad
-- ID: 164382228
-- Date: Jan 30 2025
-- Purpose: Lab 4 DBS311
-- ***********************
-- Q1. The HR department needs a list of Department IDs for departments that do not 
-- contain the job ID of ST_CLERK> Use a set operator to create this report.
SELECT DEPARTMENT_ID FROM JOB_HISTORY
MINUS
SELECT DEPARTMENT_ID FROM JOB_HISTORY
WHERE JOB_ID = 'ST_CLERK';

-- Q2. Display cities that no warehouse is located in them. (use set operators 
-- to answer this question)
SELECT lOCATION_ID, CITY
FROM LOCATIONS
WHERE LOCATION_ID IN (SELECT LOCATION_ID FROM LOCATIONS MINUS SELECT LOCATION_ID FROM WAREHOUSES);

-- Q3. Display the category ID, category name, and the number of products in 
-- category 1, 2, and 5. In your result, display first the number of products in category 5, 
-- then category 1 and then 2.
SELECT c.CATEGORY_ID, c.CATEGORY_NAME, COUNT(p.PRODUCT_ID) AS NUMBER_OF_PRODUCTS
FROM PRODUCT_CATEGORIES c 
JOIN PRODUCTS p ON c.CATEGORY_ID = p.CATEGORY_ID
WHERE c.CATEGORY_ID IN (1,2,5)
GROUP BY c.CATEGORY_ID, c.CATEGORY_NAME
ORDER BY INSTR ('5,1,2', c.CATEGORY_ID);

-- Q4. Display product ID for ordered products whose quantity in the inventory is greater than 5. 
-- (You are not allowed to use JOIN for this question.)
SELECT DISTINCT PRODUCT_ID
FROM ORDER_ITEMS
WHERE PRODUCT_ID IN (SELECT PRODUCT_ID FROM INVENTORIES WHERE QUANTITY > 5);

-- Q5. We need a single report to display all warehouses and the state that they are located in 
-- and all states regardless of whether they have warehouses in them or not.
SELECT w.WAREHOUSE_ID, w.WAREHOUSE_NAME, l.STATE
FROM WAREHOUSES w 
JOIN LOCATIONS l ON w.LOCATION_ID = l.LOCATION_ID
UNION 
SELECT NULL AS WAREHOUSE_ID, NULL AS WAREHOUSE_NAME, l.STATE
FROM LOCATIONS l
WHERE l.LOCATION_ID NOT IN (SELECT LOCATION_ID FROM WAREHOUSES);


