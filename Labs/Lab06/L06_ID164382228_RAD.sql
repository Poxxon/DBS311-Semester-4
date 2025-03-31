-- ***********************
-- Name: Pouya Rad
-- Date: March 6th, 2025
-- Purpose: Lab 6 - Stored Procedures/Iterative Statements
-- ***********************
SET SERVEROUTPUT ON;

-- 1. Write a store procedure that gets an integer number n and calculates and displays its factorial.
CREATE OR REPLACE PROCEDURE Factorial(n NUMBER) AS
Factorial NUMBER:=1;

BEGIN
    FOR i IN REVERSE 1..n LOOP
    Factorial:=Factorial*i;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('Factorial of ' || n || '!= ' || Factorial);
END Factorial;

BEGIN
    Factorial(4);
END;

-- 2. The company wants to calculate the employees’ annual salary:
-- The first year of employment, the amount of salary is the base salary which is $10,000.
-- Every year after that, the salary increases by 5%.
-- Write a stored procedure named calculate_salary which gets an employee ID and for that employee calculates 
-- the salary based on the number of years the employee has been working in the company.  
-- (Use a loop construct to calculate the salary).
-- The procedure calculates and prints the salary.
-- Sample output:
-- First Name: first_name 
-- Last Name: last_name
-- Salary: $9999,99
-- If the employee does not exists, the procedure displays a proper message.
SELECT * FROM EMPLOYEE_INFO;
SELECT TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)/12) FROM EMPLOYEE_INFO;
SELECT * FROM EMPLOYEE_INFO WHERE EMPLOYEE_ID=3;

CREATE OR REPLACE PROCEDURE calculate_salary(empid EMPLOYEE_INFO.employee_id %type) AS 
emp EMPLOYEE_INFO%rowtype;
newSalary EMPLOYEE_INFO.SALARY%TYPE;
yearsWorked NUMBER;

BEGIN
    BEGIN
        SELECT * INTO emp FROM EMPLOYEE_INFO WHERE EMPLOYEE_ID=empid;
        newSalary:=emp.salary;
        yearsWorked:=TRUNC(MONTHS_BETWEEN(SYSDATE, emp.HIRE_DATE)/12);
        FOR i IN 1..yearsWorked LOOP
        newSalary:=newSalary*1.05;
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('First Name: ' || emp.FIRST_NAME);
        DBMS_OUTPUT.PUT_LINE('Last Name: ' || emp.LAST_NAME);
        DBMS_OUTPUT.PUT_LINE('Salary before: $' || emp.SALARY || ', ' || 'Salary after increase: $' ||newSalary);
    END;
END;

BEGIN
    calculate_salary(3);
END;

-- 3. Write a stored procedure named warehouses_report to print the warehouse ID, warehouse name, and the city 
-- where the warehouse is located in the following format for all warehouses:
-- Warehouse ID:
-- Warehouse name:
-- City:
-- State:
-- If the value of state does not exist (null), display “no state”.
-- The value of warehouse ID ranges from 1 to 9.
-- You can use a loop to find and display the information of each warehouse inside the loop.
-- (Use a loop construct to answer this question. Do not use cursors.) 
CREATE OR REPLACE PROCEDURE warehouse_report AS 
    w_id WAREHOUSES.WAREHOUSE_ID%TYPE;
    w_name WAREHOUSES.WAREHOUSE_NAME%TYPE;
    w_city LOCATIONS.CITY%TYPE;
    w_state LOCATIONS.STATE%TYPE;
    
BEGIN
    FOR i IN 1..9 LOOP
        SELECT w.WAREHOUSE_ID, w.WAREHOUSE_NAME, l.CITY, NVL(l.STATE, 'no state')
        INTO w_id, w_name, w_city, w_state
        FROM WAREHOUSES w
        JOIN LOCATIONS l ON w.LOCATION_ID = l.LOCATION_ID
        WHERE w.WAREHOUSE_ID = i;

        DBMS_OUTPUT.PUT_LINE('Warehouse ID: ' || w_id);
        DBMS_OUTPUT.PUT_LINE('Warehouse name: ' || w_name);
        DBMS_OUTPUT.PUT_LINE('City: ' || w_city);
        DBMS_OUTPUT.PUT_LINE('State: ' || w_state);
        DBMS_OUTPUT.PUT_LINE(' '); -- For a space
    END LOOP;
END warehouse_report;

BEGIN
    warehouse_report();
END;

