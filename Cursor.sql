--Adam McKinlay
--c0656685
--2019-11-06
DECLARE 
   CURSOR emp_cursor IS
       SELECT first_name, last_name, department_name, job_title
           FROM s1_employees
              JOIN s1_departments USING(department_code)
              JOIN s1_jobs USING(job_code)
              ORDER BY department_name, last_name;
   v_emp_record emp_cursor%ROWTYPE;
BEGIN
   DBMS_OUTPUT.PUT_LINE('DEPARTMENT_NAME       |NAME            |JOB_TITLE         |');
   DBMS_OUTPUT.PUT_LINE('----------------------|----------------|------------------|');
   OPEN emp_cursor;
   LOOP 
       FETCH emp_cursor
         INTO v_emp_record ;
       EXIT WHEN emp_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(LPAD((v_emp_record.department_name || '|'),23) || LPAD((v_emp_record.first_name|| '' || v_emp_record.last_name || '|'),17) || LPAD(v_emp_record.job_title || '|', 19));        
   END LOOP;
   CLOSE emp_cursor;
END;
