-- Week 4 sql file : Subqueries
SELECT * FROM EMPLOYEE_INFO;

-- Salaries over 50,000
SELECT FIRST_NAME 
FROM EMPLOYEE_INFO
WHERE SALARY > 50000;

-- Salaries greater than Smith's 
SELECT SALARY
FROM EMPLOYEE_INFO 
WHERE LAST_NAME = 'Smith';

-- Using subquery for above
SELECT LAST_NAME 
FROM EMPLOYEE_INFO 
WHERE SALARY > (SELECT SALARY FROM EMPLOYEE_INFO WHERE LAST_NAME = 'Smith');

-- Salaries greater than Brown's (display last and first name)
SELECT SALARY
FROM EMPLOYEE_INFO 
WHERE LAST_NAME = 'Brown';

-- Using subquery for above
SELECT LAST_NAME, FIRST_NAME
FROM EMPLOYEE_INFO 
WHERE SALARY > (SELECT SALARY FROM EMPLOYEE_INFO WHERE LAST_NAME = 'Brown');

-- Display employees whose job id is the same as employee 2 (display last name and job id)
SELECT JOB_ID
FROM EMPLOYEE_INFO 
WHERE EMPLOYEE_ID = 2;

-- Using subquery for above
SELECT LAST_NAME, JOB_ID
FROM EMPLOYEE_INFO
WHERE JOB_ID = (SELECT JOB_ID FROM EMPLOYEE_INFO WHERE EMPLOYEE_ID = 2);

-- Display employees whose job id is the same as employee 2
-- Compare to see who has a salary greater than employee 3
SELECT LAST_NAME, JOB_ID
FROM EMPLOYEE_INFO
WHERE JOB_ID = (SELECT JOB_ID FROM EMPLOYEE_INFO WHERE EMPLOYEE_ID = 2)
AND SALARY > (SELECT SALARY FROM EMPLOYEE_INFO WHERE EMPLOYEE_ID = 3);

-- Display first name, job id and department id of employees whose department id matches
-- department id of employee 5
SELECT DEPARTMENT_ID 
FROM EMPLOYEE_INFO 
WHERE EMPLOYEE_ID = 5;

-- Using subquery for above
SELECT FIRST_NAME, JOB_ID, DEPARTMENT_ID
FROM EMPLOYEE_INFO
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID FROM EMPLOYEE_INFO WHERE EMPLOYEE_ID = 5);