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