--Adam McKinlay || c0656685
--11/27/2019
--P5.1 – convert_numeric_grade function 
--Create a function called convert_numeric_grade that converts a numeric grade to a letter grade. Use a CASE structure. Accept a numeric grade as the input parameter and return a letter grade
CREATE OR REPLACE FUNCTION convert_numeric_grade (p_grade IN NUMBER)
    RETURN VARCHAR IS
BEGIN
    CASE
        WHEN p_grade < 60 THEN RETURN 'F';
        WHEN p_grade < 70 THEN RETURN 'D';
        WHEN p_grade < 80 THEN RETURN 'C';
        WHEN p_grade < 90 THEN RETURN 'B';
        ELSE return 'A';
    END CASE;
END convert_numeric_grade;


--P5.2 – Invoke the convert_numeric_grade function 
--Create an anonymous block that invokes convert_numeric_grade. Prompt for the numeric grade and pass as a parameter to convert_numeric_grade. Return the letter grade and output as shown below. 
DECLARE
    v_grade        NUMBER(2) :=:Enter_numeric_grade;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Numeric grade: ' || v_grade);
    DBMS_OUTPUT.PUT_LINE('Letter grade: ' || convert_numeric_grade(v_grade) );
END;


--P5.3 – get_numeric_grade function 
--Create a function called get_numeric_grade. Pass the necessary parameters to get_numeric_grade. Access the GL_GRADES table and return the numeric grade for the requested student
CREATE OR REPLACE FUNCTION get_numeric_grade
    (p_student_no gl_grades.student_no%TYPE,
     p_section_id gl_grades.section_id%TYPE)
    RETURN NUMERIC IS v_grade gl_grades.numeric_grade%TYPE :=0;
BEGIN
    SELECT numeric_grade INTO v_grade
        FROM gl_grades
        WHERE student_no = p_student_no AND section_id = p_section_id;
    RETURN v_grade;
END get_numeric_grade;


--P5.4 – get_letter_grade function
--Create a function called get_letter_grade. Pass the necessary parameters to get_letter_grade. Access the ENROLLMENTS table and return the letter grade for the requested student.
CREATE OR REPLACE FUNCTION get_letter_grade
    (p_student_no gl_grades.student_no%TYPE,
     p_section_id gl_grades.section_id%TYPE)
    RETURN VARCHAR IS v_letter_grade gl_grades.letter_grade%TYPE :='';
BEGIN
    SELECT letter_grade INTO v_letter_grade 
        FROM gl_grades
        WHERE student_no = p_student_no AND section_id = p_section_id;
    RETURN v_letter_grade;
END get_letter_grade;


--P5.5 – get_full_name functio
--Create a function called get_full_name. Pass the student id as a parameter to get_full_name. Access the STUDENTS table and return the full name. Example "Joe Smith." Add an EXCEPTION section to check for NO_DATA_FOUND. If the NO_DATA_FOUND error occurs, RETURN a NULL value. 
CREATE OR REPLACE FUNCTION get_full_name (p_student_no gl_students.student_no%TYPE)
    RETURN VARCHAR2 IS v_full_name VARCHAR2(300);
BEGIN
    SELECT first_name || ' ' || last_name INTO v_full_name
        FROM gl_students
        WHERE student_no = p_student_no;
    RETURN v_full_name;
EXCEPTION
    WHEN NO_DATA_FOUND THEN RETURN NULL;
END get_full_name;


--P5.6 – Invoke the get_full_name function 
--Create an anonymous block that invokes get_full_name. Prompt for the student id and pass as a parameter to get_full_name. Return the student's full name and output as shown below. If a NO_DATA_FOUND error occurs in the function, the error message is outputted and NULL is returned. If --NULL is returned, do not output the full name. 
DECLARE
    v_student_id gl_students.student_no%TYPE :=:Enter_Student_no;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Student: ' || v_student_id);
    IF get_full_name(v_student_id) IS NULL THEN
        DBMS_OUTPUT.PUT_LINE('Exception handled in get_full_name function');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Name: ' || get_full_name(v_student_id));
    END IF;
END;


--P5.7 – Invoke the get_numeric_grade, get_letter_grade, and get_full_name functions
--Create an anonymous block that prompts for the class id and student id. Pass these values to both the get_numeric_grade and get_letter_grade functions and return the numeric and letter grades. The output below is generated from this anonymous block. Use section id 10001 and student ----number 1000 for testing. 
DECLARE
    v_section_id gl_grades.section_id%TYPE :=:Enter_section_id;
    v_student_id gl_grades.student_no%TYPE :=:Enter_student_id;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Student: ' ||v_student_id || ' ' || get_full_name(v_student_id));
    DBMS_OUTPUT.PUT_LINE('Numeric grade: ' || get_numeric_grade(v_student_id, v_section_id));
    DBMS_OUTPUT.PUT_LINE('Letter grade: ' || get_letter_grade(v_student_id, v_section_id));
END;


