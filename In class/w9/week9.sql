SET SERVEROUTPUT ON;

-- PL/SQL
DECLARE
grade CHAR(1) :='B';
RESULT VARCHAR(20);

BEGIN
    RESULT:=CASE
    WHEN grade='A' THEN 'Excelent'
    WHEN grade='B' THEN 'Good'
    WHEN grade='F' THEN 'Fail'
    ELSE 'Invalid grade'
END;

DBMS_OUTPUT.PUT_LINE('The result is ' || result);
END;

-- Case with database:
SELECT * FROM EMPLOYEES;

SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, DEPARTMENT_ID,
CASE
    WHEN DEPARTMENT_ID > 100 THEN 'High'
    WHEN DEPARTMENT_ID BETWEEN 50 AND 100 THEN 'Medium' 
    ELSE 'Low'
END
FROM EMPLOYEES;

-- Age <18: Child
-- Age between 18 and 65 then check age<30 print 'young adult' else adult
-- if none of this condition is true -> Senior
DECLARE 
AGE NUMBER:= &a;
RESULT VARCHAR(10);

BEGIN
    RESULT:=CASE
    WHEN AGE<18 THEN 'Child'
    WHEN AGE BETWEEN 18 AND 65 THEN CASE
        WHEN AGE<30 THEN 'Young Adult'
        ELSE 'Adult'
        END
    ELSE 'Senior'
    END;
DBMS_OUTPUT.PUT_LINE('The result is ' || RESULT);
END;

-- Basic loop
DECLARE 
COUNTER NUMBER:=1;

BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE('Counter value is ' || counter);
        COUNTER:=COUNTER+1;
        IF COUNTER > 5 THEN EXIT;
        END IF;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('Loop ended.');
END;

-- Different approach
DECLARE 
COUNTER NUMBER:=1;

BEGIN
    WHILE COUNTER<=5 LOOP
        DBMS_OUTPUT.PUT_LINE('Counter value is ' || counter);
        COUNTER:=COUNTER+1;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('Loop ended.');
END;