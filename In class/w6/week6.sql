-- To display results on the terminal
SET SERVEROUTPUT ON;

-- Example 1 - Simple print
BEGIN
    DBMS_OUTPUT.PUT_LINE('Welcome');
END;

-- Example 2 - Variable and operations
DECLARE
VALUE1 number:=10;
VALUE2 number:=20;
RESULT NUMBER;

BEGIN
    RESULT:= VALUE1 + VALUE2;
    DBMS_OUTPUT.PUT_LINE('The addition of two number is = ' || RESULT);
END;

-- Procedure: Addition - No return (void)
CREATE OR REPLACE PROCEDURE ADDITION AS 
VALUE1 number:=10;
VALUE2 number:=20;
RESULT NUMBER;
BEGIN
    RESULT:= VALUE1 + VALUE2;
    DBMS_OUTPUT.PUT_LINE('The addition of two number is = ' || RESULT);
END ADDITION;

-- Procedure: Division - No return (void)
CREATE OR REPLACE PROCEDURE DIVISION AS 
VALUE1 number:=20;
VALUE2 number:=10;
RESULT NUMBER;
BEGIN
    RESULT:= VALUE1 / VALUE2;
    DBMS_OUTPUT.PUT_LINE('The division of two number is = ' || RESULT);
EXCEPTION
    WHEN ZERO_DIVIDE
    THEN
    DBMS_OUTPUT.PUT_LINE('Check 2nd number');
END DIVISION;

-- In class 
SELECT * FROM EMPLOYEE_INFO;

-- Get salary from emp id 6's salary
CREATE OR REPLACE PROCEDURE EMP AS
SAL NUMBER:=66000;
BEGIN
    SELECT SALARY INTO SAL FROM EMPLOYEE_INFO WHERE SALARY=SAL;
    DBMS_OUTPUT.PUT_LINE(SAL);
END EMP;

-- Get salary from emp id 6
CREATE OR REPLACE PROCEDURE EMP2 AS
SAL NUMBER:=66000;
BEGIN
    SELECT SALARY INTO SAL FROM EMPLOYEE_INFO WHERE EMPLOYEE_ID=6;
    DBMS_OUTPUT.PUT_LINE(SAL);
END EMP2;

-- Call procedure block (main function)
BEGIN
    ADDITION();
    DIVISION();
    EMP();
    EMP2();
END;