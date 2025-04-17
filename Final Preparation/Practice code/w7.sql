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
            ELSE DBMS_OUTPUT.PUT_LINE('Wrong value');
        END CASE;
    END;
END;

