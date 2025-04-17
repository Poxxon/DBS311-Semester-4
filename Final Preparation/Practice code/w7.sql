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