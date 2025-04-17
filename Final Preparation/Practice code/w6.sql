SET SERVEROUTPUT ON;

-- Basic output
BEGIN
    DBMS_OUTPUT.PUT_LINE('Welcome to DBS311!');
END;

-- Variables and arithmetic
DECLARE
    val1 NUMBER := 20;
    val2 NUMBER := 5;
    result NUMBER;
BEGIN
    result := val1 + val2;
    DBMS_OUTPUT.PUT_LINE('Result is: ' || result);
END;

-- Error handling - divide by zero
DECLARE 
    a NUMBER := 20;
    b NUMBER := 0;
    result NUMBER;
BEGIN
    result := a / b;
    DBMS_OUTPUT.PUT_LINE('Result is: ' || result);
EXCEPTION
    WHEN ZERO_DIVIDE THEN -- Can use WHEN OTHERS THEN for any other errors too
        DBMS_OUTPUT.PUT_LINE('Divider is zero!');
END;

-- SELECT INTO statements
SELECT product_name INTO v_name FROM products WHERE product_id = 2;

-- Creating a stored procedure
CREATE OR REPLACE PROCEDURE hello_world AS
BEGIN
    DBMS_OUTPUT.PUT_LINE('Hello World!');
END;
/

-- Stored procedures with parameters
-- IN parameter - Input
CREATE OR REPLACE PROCEDURE remove_emp(employee_id IN NUMBER) AS
BEGIN
    DELETE FROM employees WHERE employee_id = remove_emp.employee_id;
END;
/

-- OUT parameter - Output
CREATE OR REPLACE PROCEDURE count_employees(employee_count OUT NUMBER) AS 
BEGIN
    SELECT COUNT(*) INTO employee_count FROM employees;
END;
/

-- IN OUT parameter - read and update
CREATE OR REPLACE PROCEDURE increase_salary(salary IN OUT FLOAT) AS 
BEGIN
    salary := salary * 2;
END;
/

DECLARE 
    emp_count NUMBER; -- to hold the OUT parameter
    salary FLOAT := 1000; -- to pass to procedure
BEGIN
    -- hello_world();
    -- remove_emp(12);

    count_employees(emp_count);
    DBMS_OUTPUT.PUT_LINE('Employee count is: ' || emp_count); 

    increase_salary(salary);
    DBMS_OUTPUT.PUT_LINE('Updated salary is: ' || salary); 
END;

-- IF - ELSIF - ELSE - END IF
BEGIN
    DECLARE 
        salary NUMBER := 2000;
    BEGIN
        IF salary > 2200 THEN
            DBMS_OUTPUT.PUT_LINE('High Salary!');
        ELSIF salary > 1800 THEN
            DBMS_OUTPUT.PUT_LINE('Good salary');
        ELSE 
            DBMS_OUTPUT.PUT_LINE('Low salary');
        END IF;
    END;
END;

-- CASE
BEGIN
    DECLARE
        grade CHAR(1) := 'A';
    BEGIN
        CASE grade
            WHEN 'A' THEN DBMS_OUTPUT.PUT_LINE('Excellent');
            WHEN 'B' THEN DBMS_OUTPUT.PUT_LINE('Good');
            WHEN 'C' THEN DBMS_OUTPUT.PUT_LINE('Fair');
            ELSE DBMS_OUTPUT.PUT_LINE('Try again');
        END CASE;
    END;
END;