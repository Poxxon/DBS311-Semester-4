-- Select
SELECT employee_id, first_name, last_name
FROM employees;

-- Column Alias
SELECT list_price * 1.05 as new_price
FROM ass_products;

-- Sorting
SELECT *
FROM ass_product_categories
ORDER BY category_name DESC;

-- Sorting by column alias
SELECT list_price * 1.05 as "New Price"
FROM ass_products
ORDER BY "New Price";

-- Sorting by column numeric position
SELECT * 
FROM ass_product_categories
ORDER BY 2;

-- Sorting by multiple columns 
SELECT * 
FROM ass_warehouses
ORDER BY warehouse_name, location_id DESC;

-- Like / Not like
SELECT employee_id, first_name, last_name
FROM ass_employees
WHERE last_name LIKE '%o_';

-- Escape character
SELECT * 
FROM class
WHERE course_code LIKE 'DBS\_%' ESCAPE '\';

-- Between / Not between
SELECT product_id, product_name, list_price
FROM ass_products
WHERE list_price NOT BETWEEN 50 AND 800
ORDER BY list_price;

-- In / Not In
SELECT * 
FROM ass_product_categories
WHERE category_id NOT IN (2,3);

-- Is NULL / Is NOT NULL
SELECT * 
FROM ass_warehouses
WHERE location_id IS NOT NULL;

-- AND / OR
SELECT * 
FROM ass_warehouses
WHERE warehouse_name = 'Central Warehouse' OR location_id IN  (101, 102, 103);

-- Concatenation operator 
SELECT  first_name, last_name,
    first_name || last_name AS "Name",
    first_name || ' ' || last_name AS "Full Name",
    CONCAT(first_name, last_name) as "Name 2",
    CONCAT(CONCAT(first_name, ' '), last_name) as "Name 3"
FROM ass_employees;

-- Literal character strings
SELECT last_name || q'['s employee id is ]' || employee_id
FROM ass_employees;

-- Distinct
SELECT DISTINCT warehouse_name
FROM ass_warehouses;

CREATE TABLE candidate (
    name VARCHAR2(50),
    location NUMBER
);

CREATE TABLE student (
    name VARCHAR2(50),
    phone_number NUMBER
);

INSERT ALL
    INTO candidate (name, location) VALUES ('Sam', 23)
    INTO candidate (name, location) VALUES ('Max', 24)
    INTO candidate (name, location) VALUES ('Donald', 25)
SELECT * FROM dual;

INSERT ALL
    INTO student (name, phone_number) VALUES ('Sam', 232323)
    INTO student (name, phone_number) VALUES ('Maxey', 2424)
    INTO student (name, phone_number) VALUES ('Jane', 52566)
SELECT * FROM dual;

-- Inner Join
SELECT * FROM student 
INNER JOIN candidate ON candidate.name = student.name;

-- Right join
SELECT * FROM student
RIGHT JOIN candidate ON candidate.name = student.name;

-- Left join
SELECT * FROM student
LEFT JOIN candidate on candidate.name = student.name;

-- Full join
SELECT * FROM student
FULL JOIN candidate on candidate.name = student.name;



