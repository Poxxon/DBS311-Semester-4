-- ***********************
-- Name: Pouya Rad
-- ID: 164382228
-- Date: Jan 15 2025
-- Purpose: Lab 1 DBS311
-- ***********************

--Question 1--
--Write a query to display the tomorrow’s date in the following format:
--     January 10th of year 2019
--the result will depend on the day when you RUN/EXECUTE this query.  Label the column “Tomorrow”.

--I need to use today's date and add one and represent it as "Tomorrow".
--Solution--
SELECT TO_CHAR(SYSDATE + 1, 'Month DDth "of year" YYYY') AS "Tomorrow" FROM DUAL;

--Question 2--
--For each product in category 2, 3, and 5, show product ID, product name, list price, and the new list price 
--increased by 2%. Display a new list price as a whole number.
--In your result, add a calculated column to show the difference of old and new list prices.

--The question wants to have the product id, name, current price, current price + 2% and 
--the difference between them displayed.
--Solution--
SELECT PRODUCT_ID, PRODUCT_NAME, LIST_PRICE, ROUND(LIST_PRICE * 1.02) AS NEW_LIST_PRICE, ROUND((LIST_PRICE * 1.02) - LIST_PRICE) AS PRICE_DIFF
FROM PRODUCTS
WHERE CATEGORY_ID IN (2,3,5);

--Question 3--
--For employees whose manager ID is 2, write a query that displays the employee’s Full Name and Job Title in the following format:
--SUMMER, PAYNE is Public Accountant.

--To format a simple name and position query in a FNAME, LNAME is JOBTITLE format.
--Solution--
SELECT UPPER(FIRST_NAME || ', ' || LAST_NAME) || ' is ' || (JOB_TITLE) AS Description
FROM EMPLOYEES;

--Question 4--
--For each employee hired before October 2016, display the employee’s last name, hire date and calculate the number of YEARS between TODAY and the date the employee was hired.
--•	Label the column Years worked. 
--•	Order your results by the number of years employed.  Round the number of years employed up to the closest whole number.

--Query only the workers hired after 10/01/2016 to display their LNAME, HIRE_DATE, and 
--years worked through some calculation.
--Solution--
SELECT LAST_NAME, HIRE_DATE, CEIL(MONTHS_BETWEEN(SYSDATE, hire_date) / 12) AS  "Years Worked"
FROM EMPLOYEES
WHERE HIRE_DATE < TO_DATE('01/10/16', 'DD/MM/YY')
ORDER BY "Years Worked" DESC;

--Question 5--
--Display each employee’s last name, hire date, and the review date, which is the first Tuesday after a year of service, but only for those hired after 2016.  
--•	Label the column REVIEW DAY. 
--•	Format the dates to appear in the format like:
--    TUESDAY, August the Thirty-First of year 2016
--•	Sort by review date

--Display the employees info of those who were employed after 2016 with the review date 
--that is the first tuesday after a year of their service.
--HOWEVER the given data schema has no employees hired past 2016, it works if we change the hire year to 2015.
--Solution--
SELECT LAST_NAME, TO_CHAR(HIRE_DATE, 'DAY, Month "the" DDth "of year" YYYY') AS HIRE_DATE,
TO_CHAR(NEXT_DAY(ADD_MONTHS(HIRE_DATE, 12) - 1, 'TUESDAY'), 'DAY, Month "the" DDth "of year" YYYY') AS REVIEW_DAY
FROM EMPLOYEES
WHERE HIRE_DATE > TO_DATE('31/12/2016', 'DD/MM/YY') --used '31/12/2016' because it is the last day of the year 2016
ORDER BY REVIEW_DAY;

--Question 6--
--For all warehouses, display warehouse id, warehouse name, city, and state. For warehouses with the null value 
--for the state column, display “unknown”.

--Display info for warehouses, if the state is NULL we display "unknown".
--Solution--
SELECT w.warehouse_id, w.warehouse_name, l.city,
NVL(l.state, 'Unknown') AS STATE
FROM WAREHOUSES w LEFT JOIN locations l ON w.location_id = l.location_id;