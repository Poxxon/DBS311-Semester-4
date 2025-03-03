-- ***********************
-- Name: Pouya Rad
-- Date: February 23, 2025
-- Purpose: Lab 5 - Stored Procedures & Conditional Statements
-- ***********************
SET SERVEROUTPUT ON;

-- Question 1: Check if a number is even or odd
-- This procedure takes an integer and prints whether it is even or odd.
CREATE OR REPLACE PROCEDURE check_even_odd(num IN NUMBER) AS
BEGIN
    IF MOD(num, 2) = 0 THEN
        DBMS_OUTPUT.PUT_LINE('The number is even.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('The number is odd.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error! Unexpected issue occurred.');
END check_even_odd;

BEGIN
    check_even_odd(10);
END;

-- Question 2: Find Employee Details
-- This procedure retrieves employee details given an employee ID.
CREATE OR REPLACE PROCEDURE find_employee(emp_id IN NUMBER) AS
    v_first_name employees.first_name%TYPE;
    v_last_name employees.last_name%TYPE;
    v_email employees.email%TYPE;
    v_phone employees.phone%TYPE;
    v_hire_date employees.hire_date%TYPE;
    v_job_title employees.job_title%TYPE;
BEGIN
    SELECT first_name, last_name, email, phone, hire_date, job_title
    INTO v_first_name, v_last_name, v_email, v_phone, v_hire_date, v_job_title
    FROM employees
    WHERE employee_id = emp_id;

    DBMS_OUTPUT.PUT_LINE('First name: ' || v_first_name);
    DBMS_OUTPUT.PUT_LINE('Last name: ' || v_last_name);
    DBMS_OUTPUT.PUT_LINE('Email: ' || v_email);
    DBMS_OUTPUT.PUT_LINE('Phone: ' || v_phone);
    DBMS_OUTPUT.PUT_LINE('Hire date: ' || TO_CHAR(v_hire_date, 'DD-MON-YY'));
    DBMS_OUTPUT.PUT_LINE('Job title: ' || v_job_title);

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Error: No employee found with ID ' || emp_id);
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('Error: Multiple employees found with ID ' || emp_id);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error! Unexpected issue occurred.');
END find_employee;

-- Question 3: Update Product Prices by Category
-- This procedure increases the price of all products in a given category.
CREATE OR REPLACE PROCEDURE update_price_by_cat(
    category_id IN NUMBER,
    amount IN NUMBER
) AS
    rows_updated NUMBER;
BEGIN
    UPDATE products
    SET list_price = list_price + amount
    WHERE category_id = category_id AND list_price > 0;

    rows_updated := SQL%ROWCOUNT;
    
    IF rows_updated > 0 THEN
        DBMS_OUTPUT.PUT_LINE(rows_updated || ' rows updated.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('No products updated.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error! Unexpected issue occurred.');
END update_price_by_cat;

-- Question 4: Increase Prices of Low-Priced Products
-- This procedure increases the price of products below the average price.
CREATE OR REPLACE PROCEDURE update_price_under_avg AS
    avg_price NUMBER;
    rows_updated NUMBER;
BEGIN
    SELECT AVG(list_price) INTO avg_price FROM products;

    IF avg_price <= 1000 THEN
        UPDATE products
        SET list_price = list_price * 1.02
        WHERE list_price < avg_price;
    ELSE
        UPDATE products
        SET list_price = list_price * 1.01
        WHERE list_price < avg_price;
    END IF;

    rows_updated := SQL%ROWCOUNT;
    
    IF rows_updated > 0 THEN
        DBMS_OUTPUT.PUT_LINE(rows_updated || ' products updated.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('No products updated.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error! Unexpected issue occurred.');
END update_price_under_avg;

-- Question 5: Product Price Report
-- This procedure categorizes products based on their prices.
CREATE OR REPLACE PROCEDURE product_price_report AS
    avg_price NUMBER;
    min_price NUMBER;
    max_price NUMBER;
    cheap_count NUMBER := 0;
    fair_count NUMBER := 0;
    exp_count NUMBER := 0;
BEGIN
    -- Get min, max, and average price
    SELECT MIN(list_price), MAX(list_price), AVG(list_price)
    INTO min_price, max_price, avg_price
    FROM products;

    -- Categorize products
    SELECT COUNT(*) INTO cheap_count 
    FROM products 
    WHERE list_price < ((avg_price - min_price) / 2);

    SELECT COUNT(*) INTO exp_count 
    FROM products 
    WHERE list_price > ((max_price - avg_price) / 2);

    SELECT COUNT(*) INTO fair_count 
    FROM products 
    WHERE list_price BETWEEN ((avg_price - min_price) / 2) AND ((max_price - avg_price) / 2);

    -- Print results
    DBMS_OUTPUT.PUT_LINE('Cheap: ' || cheap_count);
    DBMS_OUTPUT.PUT_LINE('Fair: ' || fair_count);
    DBMS_OUTPUT.PUT_LINE('Expensive: ' || exp_count);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error! Unexpected issue occurred.');
END product_price_report;