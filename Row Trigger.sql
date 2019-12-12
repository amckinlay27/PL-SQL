--Adam McKinlay - c0656685
--Date: 4/12/2019

--P6.1 Run the following commands to establish the environment:
DROP TABLE gl_grades_copy;

CREATE TABLE gl_grades_copy AS SELECT * FROM gl_grades;
ALTER TABLE gl_grades_copy
    ADD CONSTRAINT gl_grades_copy_pk
    PRIMARY KEY ( section_id, student_no );
INSERT INTO gl_grades_copy (section_id, student_no, numeric_grade,letter_grade) VALUES(1,105,60,'D');
INSERT INTO gl_grades_copy (section_id, student_no, numeric_grade,letter_grade) VALUES(1, 106, 75, 'C');
SELECT * FROM gl_grades_copy;

--P6.2 Create a function called convert_numeric_grade (same as before) that converts a numeric grade to a letter grade. Use the same values as before. 
--Use a CASE structure. IN parameter is the numeric grade and RETURN a VARCHAR2 (letter grade)
CREATE OR REPLACE FUNCTION convert_numeric_grade (p_grade IN gl_grades_copy.numeric_grade%TYPE)
    RETURN VARCHAR2 IS
BEGIN
    CASE
        WHEN p_grade < 60 THEN RETURN 'F';
        WHEN p_grade < 70 THEN RETURN 'D';
        WHEN p_grade < 80 THEN RETURN 'C';
        WHEN p_grade < 90 THEN RETURN 'B';
        ELSE return 'A';
    END CASE;
END convert_numeric_grade;


--P6.3 Create a LOG table called LOG_GRADE_UPDATES to capture the audit trail of changes to the gl_grades_copy table. The table will contain the following columns:
DROP TABLE log_grade_updates;

DROP TABLE gl_grades_copy;

CREATE TABLE gl_grades_copy AS SELECT * FROM gl_grades;
ALTER TABLE gl_grades_copy
    ADD CONSTRAINT gl_grades_copy_pk
    PRIMARY KEY ( section_id, student_no );
INSERT INTO gl_grades_copy (section_id, student_no, numeric_grade,letter_grade) VALUES(1,105,60,'D');
INSERT INTO gl_grades_copy (section_id, student_no, numeric_grade,letter_grade) VALUES(1, 106, 75, 'C');
SELECT * FROM gl_grades_copy;


--P6.2 Create a function called convert_numeric_grade (same as before) that converts a numeric grade to a letter grade. Use the same values as before. 
--Use a CASE structure. IN parameter is the numeric grade and RETURN a VARCHAR2 (letter grade)
CREATE OR REPLACE FUNCTION convert_numeric_grade (p_grade IN gl_grades_copy.numeric_grade%TYPE)
    RETURN VARCHAR2 IS
BEGIN
    CASE
        WHEN p_grade < 60 THEN RETURN 'F';
        WHEN p_grade < 70 THEN RETURN 'D';
        WHEN p_grade < 80 THEN RETURN 'C';
        WHEN p_grade < 90 THEN RETURN 'B';
        ELSE return 'A';
    END CASE;
END convert_numeric_grade;


--P6.3 Create a LOG table called LOG_GRADE_UPDATES to capture the audit trail of changes to the gl_grades_copy table. The table will contain the following columns:
DROP TABLE log_grade_updates;

CREATE TABLE LOG_GRADE_UPDATES
    (user_id         VARCHAR2(30)  DEFAULT USER,
    last_change_date DATE          DEFAULT SYSDATE,
    student_no       DECIMAL (7,0),
    old_grade        VARCHAR2(2),
    new_grade        VARCHAR2(2),
    action           VARCHAR2(30));



--P6.4 Create a BEFORE UPDATE trigger on the gl_grades_copy table that fires before a change is made to the letter grade. The trigger inserts a row
--into the LOG_GRADE_UPDATES audit table. Use a nested IF statement or CASE structure to determine the ACTION to insert. When the old letter
--grade is the same as the new letter grade, insert 'grade is the same'. When the old letter grade is less than the new letter grade, insert 'grade went
--up'. When the old letter grade is greater than new letter grade, insert 'grade went down '. Use a row trigger.
CREATE OR REPLACE TRIGGER log_2_tr
BEFORE UPDATE OF letter_grade ON gl_grades_copy
FOR EACH ROW
BEGIN
    CASE
         WHEN :OLD.letter_grade = :NEW.letter_grade THEN
            INSERT INTO LOG_GRADE_UPDATES(user_id, last_change_date, student_no, old_grade, new_grade, action)
                VALUES(USER, SYSDATE, :OLD.student_no, :OLD.letter_grade, :NEW.letter_grade, 'grade is the same');
            DBMS_OUTPUT.PUT_LINE('log_2_tr BEFORE UPDATE completed');
        WHEN :OLD.letter_grade > :NEW.letter_grade THEN
            INSERT INTO LOG_GRADE_UPDATES(user_id, last_change_date, student_no, old_grade, new_grade, action)
                VALUES(USER, SYSDATE, :OLD.student_no, :OLD.letter_grade, :NEW.letter_grade, 'grade went up');
            DBMS_OUTPUT.PUT_LINE('log_2_tr BEFORE UPDATE completed');
        WHEN :OLD.letter_grade < :NEW.letter_grade THEN
            INSERT INTO LOG_GRADE_UPDATES(user_id, last_change_date, student_no, old_grade, new_grade, action)
                VALUES(USER, SYSDATE, :OLD.student_no, :OLD.letter_grade, :NEW.letter_grade, 'grade went down');
            DBMS_OUTPUT.PUT_LINE('log_2_tr BEFORE UPDATE completed');
    END CASE;
END;


--P6.5 Test UPDATE_GRADE_TR trigger
DECLARE 
    v_section_id gl_grades_copy.section_id%TYPE    :=:Enter_section_id;
    v_student_no gl_grades_copy.student_no%TYPE    :=:Enter_student_no;
    v_new_grade  gl_grades_copy.numeric_grade%TYPE :=:Enter_new_numeric_grade;
    v_letter_grade gl_grades_copy.letter_grade%TYPE := convert_numeric_grade(v_new_grade);
BEGIN
    UPDATE gl_grades_copy
        SET numeric_grade = v_new_grade, letter_grade = v_letter_grade
        WHERE section_id = v_section_id AND student_no = v_student_no;        
END;
SELECT * FROM gl_grades_copy;
SELECT * FROM LOG_GRADE_UPDATES;

--P6.6 Test UPDATE_GRADE_TR trigger
DECLARE 
    v_section_id gl_grades_copy.section_id%TYPE    :=:Enter_section_id;
    v_student_no gl_grades_copy.student_no%TYPE    :=:Enter_student_no;
    v_new_grade  gl_grades_copy.numeric_grade%TYPE :=:Enter_new_numeric_grade;
    v_letter_grade gl_grades_copy.letter_grade%TYPE := convert_numeric_grade(v_new_grade);
BEGIN
    UPDATE gl_grades_copy
        SET numeric_grade = v_new_grade, letter_grade = v_letter_grade
        WHERE section_id = v_section_id AND student_no = v_student_no;        
END;
SELECT * FROM gl_grades_copy;
SELECT * FROM LOG_GRADE_UPDATES;

--P6.7 Test UPDATE_GRADE_TR trigger
DECLARE 
    v_section_id gl_grades_copy.section_id%TYPE    :=:Enter_section_id;
    v_student_no gl_grades_copy.student_no%TYPE    :=:Enter_student_no;
    v_new_grade  gl_grades_copy.numeric_grade%TYPE :=:Enter_new_numeric_grade;
    v_letter_grade gl_grades_copy.letter_grade%TYPE := convert_numeric_grade(v_new_grade);
BEGIN
    UPDATE gl_grades_copy
        SET numeric_grade = v_new_grade, letter_grade = v_letter_grade
        WHERE section_id = v_section_id AND student_no = v_student_no;        
END;
SELECT * FROM gl_grades_copy;
SELECT * FROM LOG_GRADE_UPDATES;