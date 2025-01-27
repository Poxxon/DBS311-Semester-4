-- Pouya Rad
-- In class activity w4

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

-- Display first name, job id and department id of employees whose department id matches...
-- the department id of employee 5
-- Identify greater salaries than the employee 20
SELECT DEPARTMENT_ID 
FROM EMPLOYEE_INFO 
WHERE EMPLOYEE_ID = 5;

-- Using subquery for above
SELECT FIRST_NAME, JOB_ID, DEPARTMENT_ID
FROM EMPLOYEE_INFO
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID FROM EMPLOYEE_INFO WHERE EMPLOYEE_ID = 5)
AND SALARY >= (SELECT SALARY FROM EMPLOYEE_INFO WHERE EMPLOYEE_ID = 2);

-- Display last name, job id and salary of employees that match the minimum salary of employees
SELECT MIN(SALARY)
FROM EMPLOYEE_INFO;

-- Using subquery for above
SELECT LAST_NAME, JOB_ID, SALARY
FROM EMPLOYEE_INFO
WHERE SALARY = (SELECT MIN(SALARY) FROM EMPLOYEE_INFO);

-- Minimum salary in each department where it is greater than the minimum salary in dept 30
SELECT MIN(SALARY)
FROM EMPLOYEE_INFO
WHERE DEPARTMENT_ID = 30;

-- Using subquery for above
SELECT DEPARTMENT_ID, MIN(SALARY)
FROM EMPLOYEE_INFO
GROUP BY DEPARTMENT_ID
HAVING MIN(SALARY) > (SELECT MIN(SALARY) FROM EMPLOYEE_INFO WHERE DEPARTMENT_ID = 30);

-- Find the lowest avg salary for a job id
-- Display job id and that avg salary
SELECT MIN(AVG(SALARY))
FROM EMPLOYEE_INFO
GROUP BY JOB_ID;

-- Using subquery for above
SELECT JOB_ID, AVG(SALARY)
FROM EMPLOYEE_INFO
GROUP BY JOB_ID
HAVING AVG(SALARY) IN (SELECT MIN(AVG(SALARY)) FROM EMPLOYEE_INFO GROUP BY JOB_ID);

-- Multi row group by example
SELECT DEPARTMENT_ID, EMPLOYEE_ID, LAST_NAME, SALARY
FROM EMPLOYEE_INFO
WHERE SALARY IN (SELECT MIN(SALARY) FROM EMPLOYEE_INFO GROUP BY DEPARTMENT_ID);

-- ANY operator:
/*
< ANY -- less than any will mean less than the maximum return
> ANY -- greater than any means more than the minimum value returned
= ANY -- equal to any is the equivalent of the IN operator
*/

-- Display salary of employee who belong to department id 20
SELECT SALARY 
FROM EMPLOYEE_INFO 
WHERE DEPARTMENT_ID = 20;

-- Using subquery for above
SELECT EMPLOYEE_ID, LAST_NAME, JOB_ID, SALARY 
FROM EMPLOYEE_INFO
WHERE SALARY < ANY (SELECT SALARY FROM EMPLOYEE_INFO WHERE DEPARTMENT_ID = 20);

-- Using subquery for above
SELECT EMPLOYEE_ID, LAST_NAME, JOB_ID, SALARY 
FROM EMPLOYEE_INFO
WHERE SALARY > ANY (SELECT SALARY FROM EMPLOYEE_INFO WHERE DEPARTMENT_ID = 20);

-- Using subquery for above
SELECT EMPLOYEE_ID, LAST_NAME, JOB_ID, SALARY 
FROM EMPLOYEE_INFO
WHERE SALARY = ANY (SELECT SALARY FROM EMPLOYEE_INFO WHERE DEPARTMENT_ID = 20);
