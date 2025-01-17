-- Create table for ass_employees
drop table ass_employees;
drop table employees;
drop table ass_products;
CREATE TABLE ass_employees (
employee_id NUMBER PRIMARY KEY,
first_name VARCHAR2(50),
last_name VARCHAR2(50),
email VARCHAR2(100),
job_title VARCHAR2(50),
manager_id NUMBER
);


-- Insert values into ass_employees
INSERT INTO ass_employees VALUES (1, 'John', 'Doe', 'john.doe@example.com', 'Manager', NULL);
INSERT INTO ass_employees VALUES (2, 'Jane', 'Smith', 'jane.smith@example.com', 'Director', NULL);
INSERT INTO ass_employees VALUES (3, 'Ellie', 'Brown', 'ellie.brown@example.com', 'Assistant', 2);
INSERT INTO ass_employees VALUES (4, 'Elliot', 'Green', 'elliot.green@example.com', 'Clerk', 2);


-- Create table for employees
CREATE TABLE employees (
employee_id NUMBER PRIMARY KEY,
first_name VARCHAR2(50),
last_name VARCHAR2(50),
hire_date DATE,
department_id NUMBER
);


-- Insert values into employees
INSERT INTO employees VALUES (1, 'Elliot', 'Johnson', TO_DATE('2020-01-10', 'YYYY-MM-DD'), 90);
INSERT INTO employees VALUES (2, 'Ellie', 'Smith', TO_DATE('2019-07-15', 'YYYY-MM-DD'), 90);
INSERT INTO employees VALUES (3, 'John', 'Doe', TO_DATE('2021-03-20', 'YYYY-MM-DD'), 80);


-- Create table for ass_products
CREATE TABLE ass_products (
product_id NUMBER PRIMARY KEY,
list_price NUMBER(10, 2)
);


-- Insert values into ass_products
INSERT INTO ass_products VALUES (1, 45.67);
INSERT INTO ass_products VALUES (2, 49.99);
INSERT INTO ass_products VALUES (3, 30.50);
INSERT INTO ass_products VALUES (4, 20.25);
INSERT INTO ass_products VALUES (5, 10.99);


-- Commit the data
COMMIT;

-- Character functions:
SELECT * FROM ASS_EMPLOYEES;

SELECT lower(job_title) as "Job Title"
FROM ASS_EMPLOYEES;

SELECT initcap(job_title) AS newtitle from ASS_EMPLOYEES;

SELECT lower(job_title) AS "Lower", -- displays data in lowercase
upper(first_name) AS "UPPER", -- displays data in uppercase
initcap(email) AS "Capital" -- displays data with an initial capital letter
FROM ASS_EMPLOYEES
WHERE manager_id = 2;

SELECT * FROM EMPLOYEES
WHERE lower(FIRST_NAME) LIKE 'j%';

SELECT CONCAT('Database ', 'System')
FROM DUAL; -- Dual table is a temp table for random queries that are not based on our tables

SELECT * FROM DUAL; -- Will show a dummy row and column

SELECT length('database') FROM DUAL; -- length() counts the number of chars

SELECT SUBSTR('DatabaseSystems', 1, 4) FROM DUAL; -- Cuts the text to preferred length

SELECT INSTR('DatabaseSystems', 'b') FROM DUAL;

SELECT LPAD('Tommy', 10, '*') FROM DUAL; -- adds padding to the left

SELECT RPAD('Tommy', 10, '*') FROM DUAL; -- adds padding to the right

SELECT REPLACE('Jack and Jue', 'J', 'Bl') FROM DUAL; -- replaces desired texts

SELECT TRIM('D' FROM 'Database') FROM DUAL; -- trims letters 

SELECT LIST_PRICE, mod(LIST_PRICE, 7) FROM ASS_PRODUCTS; -- Remainder function

SELECT LIST_PRICE, round(list_price, 1) FROM ASS_PRODUCTS; -- Round function

SELECT LIST_PRICE, trunc(list_price, 1) FROM ASS_PRODUCTS; -- Truncate function

SELECT SYSDATE + 30 FROM DUAL; -- System date

SELECT TO_CHAR(sysdate + 30,'Month DDth, YYYY') FROM DUAL; -- System date

SELECT last_name, round((SYSDATE - hire_date) / 7, 0) "Weeks Employed"
FROM EMPLOYEES;
