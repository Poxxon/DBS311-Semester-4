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