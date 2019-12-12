--Adam McKinlay - c0656685
--P5 Triggers
--Date: 4/12/2019

--P6.1 Run the following commands to establish the environment:
DROP TABLE employees_copy;

CREATE TABLE employees_copy AS
    SELECT employee_id, first_name, last_name, salary
        FROM employees
        WHERE employee_id < 110;
ALTER TABLE employees_copy
    ADD CONSTRAINT employees_copy_pk
    PRIMARY KEY ( employee_id );
	
SELECT * FROM employees_copy;
	
--P6.2 Create a LOG table called EMP_AUDIT_LOG to capture the audit trail of changes to the employees_copy table. The table will contains the following columns:
DROP TABLE emp_audit_log;

CRATE TABLE emp_audit_log
    (user_id          VARCHAR2(30),
     last_change_date DATE,
     trigger_name     VARCHAR2(15),
     action           VARCHAR2(30));


SELECT * FROM s1_employees;

--P6.3 Create a statement-level trigger that inserts a row into the EMP_AUDIT_LOG immediately after one or more rows are added to the EMPLOYEES_COPY table. The EMP_AUDIT_LOG row should contain the value "emp_audit_log" in the trigger_name column and "Inserting" in the action column. 
CREATE OR REPLACE TRIGGER log_1_tr
AFTER INSERT ON employees_copy
BEGIN
    INSERT INTO emp_audit_log(user_id, last_change_date, trigger_name, action)
        VALUES(USER, SYSDATE, 'emp_audit_log', 'Inserting');
    DBMS_OUTPUT.PUT_LINE('log_1_tr AFTER INSERT is completed');
END;

--P6.4 Test EMPLOYEE_TR trigger
INSERT INTO employees_copy VALUES (105, 'Betty', 'Smith', 15000);
SELECT * FROM employees_copy ORDER BY employee_id;
SELECT * FROM emp_audit_log;

--P6.5 Test EMPLOYEE_TR trigger P6.6 Verify table and log
INSERT INTO employees_copy VALUES (106, 'Peter', 'Jones', 17500);
SELECT * FROM employees_copy ORDER BY employee_id;
SELECT * FROM emp_audit_log;










	
