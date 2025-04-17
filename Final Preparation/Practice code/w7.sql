SET SERVEROUTPUT ON;

-- Searched CASE statements
BEGIN
    DECLARE
        semester CHAR(1) := 'S';
    BEGIN
        CASE
            WHEN semester = 'F' THEN DBMS_OUTPUT.PUT_LINE('Fall term');
            WHEN semester = 'W' THEN DBMS_OUTPUT.PUT_LINE('Winter term');
            WHEN semester = 'S' THEN DBMS_OUTPUT.PUT_LINE('Summer term');
            ELSE RAISE CASE_NOT_FOUND;
        END CASE;
    EXCEPTION
        WHEN CASE_NOT_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Semester not found!');
    END;
END;

-- LOOP with EXIT
BEGIN
    DECLARE 
        counter NUMBER := 3;
    BEGIN
        DBMS_OUTPUT.PUT_LINE('--Countdown started--');
        LOOP
            DBMS_OUTPUT.PUT_LINE('counter: ' || counter);
            counter := counter -1;
            IF counter < 1 THEN
                EXIT;
            END IF;
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('--Countdown done--');
    END;
END;

-- EXIT WHEN
BEGIN
    DECLARE 
        counter NUMBER := 3;
    BEGIN
        DBMS_OUTPUT.PUT_LINE('--Countdown started--');
        LOOP
            DBMS_OUTPUT.PUT_LINE('counter: ' || counter);
            counter := counter - 1;
            EXIT WHEN counter < 1;
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('--Countdown done EXIT WHEN--');
    END;
END;

-- FOR LOOP
BEGIN
    FOR i IN 1..4 LOOP
        IF i < 2 THEN
            DBMS_OUTPUT.PUT_LINE(i || ' is less than 2');
        ELSIF i > 2 THEN
            DBMS_OUTPUT.PUT_LINE(i || ' is more than 2');
        ELSE 
            DBMS_OUTPUT.PUT_LINE(i || ' is equal to 2');
        END IF;
    END LOOP;
END;

-- WHILE LOOP
BEGIN
   DECLARE
      run   BOOLEAN := TRUE;
      round NUMBER := 1;
   BEGIN
      DBMS_OUTPUT.PUT_LINE('-- First WHILE LOOP --');
      WHILE run LOOP
         DBMS_OUTPUT.PUT_LINE('round ' || round);
         round := round + 1;
         IF round = 4 THEN
            run := FALSE;
         END IF;
      END LOOP;
   END;
END;

-- CURSOR with params
BEGIN
    DECLARE
        p_product products%ROWTYPE;

        CURSOR product_cursor(price_1 NUMBER, price_2 NUMBER) IS 
            SELECT * FROM products
            WHERE list_price BETWEEN price_1 AND price_2;
    
    BEGIN
        OPEN product_cursor(1000, 2000);
        LOOP 
            FETCH product_cursor INTO p_product;
            EXIT WHEN product_cursor%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE(p_product.product_name || ': ' || p_product.list_price);
            DBMS_OUTPUT.PUT_LINE(product_cursor%ROWCOUNT);
        END LOOP;
        CLOSE product_cursor;
    END;
END;

-- CURSOR in a FOR LOOP
BEGIN
   DECLARE
      CURSOR emp_cursor IS
         SELECT last_name, job_title
         FROM employees
         WHERE job_title LIKE 'A%t %'
         ORDER BY last_name;
   BEGIN
      FOR emp_record IN emp_cursor LOOP
         DBMS_OUTPUT.PUT_LINE('Name: ' || emp_record.last_name || ', Job: ' || emp_record.job_title);
      END LOOP;
   END;
END;

-- FUNCTIONS
CREATE OR REPLACE FUNCTION find_max_price RETURN NUMBER IS
    max_price NUMBER := 0;
BEGIN
    SELECT MAX(list_price) INTO max_price FROM products;
    RETURN max_price;
END;

-- Test it 
BEGIN
   DECLARE
      highest_price NUMBER;
   BEGIN
      highest_price := find_max_price();
      DBMS_OUTPUT.PUT_LINE('The maximum price is: ' || highest_price);
   END;
END;

-- Test it IF ELSE
BEGIN
   DECLARE
      new_price NUMBER := 9000;
   BEGIN
      IF new_price < find_max_price() THEN
         DBMS_OUTPUT.PUT_LINE('The new price is less than the max price.');
      ELSE
         DBMS_OUTPUT.PUT_LINE('The new price is higher than the max price.');
      END IF;
   END;
END;

CREATE OR REPLACE PROCEDURE stringy(S IN VARCHAR2) AS
newWord VARCHAR2(1000) := ''; 

BEGIN
    DBMS_OUTPUT.PUT_LINE('Original: ' || S);
    DBMS_OUTPUT.PUT_LINE('Reverse: ');
    
    FOR i IN REVERSE 1..LENGTH(S) 
    LOOP
        DBMS_OUTPUT.PUT_LINE(SUBSTR(S, i, 1));
    END LOOP; 
EXCEPTION 
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: ' || SQLERRM);
END;
/

DECLARE 
    string1 VARCHAR2(5) := 'hello'; 
BEGIN
    stringy(string1);
END;
/