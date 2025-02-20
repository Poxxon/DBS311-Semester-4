-- Sorting by the second column
SELECT *
FROM EMPLOYEE_INFO
ORDER BY 2;

-- Like / Not like
SELECT employee_id, first_name, last_name
FROM ass_employees
WHERE last_name LIKE '%o_';

-- Escape character
SELECT * 
FROM class
WHERE course_code LIKE 'DBS\_%' ESCAPE '\';