--Adam McKinlay
--c0656685
--October 30, 2019

--1.The Loyalty Department needs an application that determines if a customer is rated gold, silver, or bronze based on total purchases. Create an anonymous block that prompts for the total purchase amount, determines the rating, and displays the results. Use an IF statement and named constants.
DECLARE 
    v_total_purchases NUMERIC(4,0) := :ENTER_TOTAL_PURCHASES;
    c_BRONZE_RATING   NUMERIC(4,0) := 2000;
    c_SILVER_RATING   NUMERIC(4,0) := 3500;
BEGIN
    IF v_total_purchases <= c_BRONZE_RATING THEN
        DBMS_OUTPUT.PUT_LINE('The customer is a BRONZE');
    ELSIF v_total_purchases <= c_SILVER_RATING THEN
        DBMS_OUTPUT.PUT_LINE('The customer is a SILVER');
    ELSE
        DBMS_OUTPUT.PUT_LINE('The customer is a GOLD');
    END IF;
END;

--2. The Loyalty Department needs an application that determines if a customer is rated gold, silver, or bronze based on total purchases. Create an anonymous block that prompts for the total purchase amount, determines the rating, and displays the results. Use a CASE statement and named constants. Use a CASE statement and named constants.
DECLARE
    v_total_purchases NUMERIC(4,0) := :ENTER_TOTAL_PURCHASES;
    c_BRONZE_RATING   NUMERIC(4,0) := 2000;
    c_SILVER_RATING   NUMERIC(4,0) := 3500;
BEGIN
    CASE 
        WHEN v_total_purchases <= c_BRONZE_RATING THEN
            DBMS_OUTPUT.PUT_LINE('The customer is a BRONZE');
        WHEN v_total_purchases <= c_SILVER_RATING THEN
            DBMS_OUTPUT.PUT_LINE('The customer is a SILVER');
        ELSE DBMS_OUTPUT.PUT_LINE('The customer is a GOLD');
    END CASE;        
END;

--3. The Accounts Receivable department needs an application to indicate whether a balance is still due on an account when a payment is received. Create an anonymous block that prompts for account balance and payment amount and displays the account balance, payment amount and if the account is paid in full or has a remaining balance. If there is a remaining balance, output the amount.
DECLARE
    v_account_balance   INTEGER := :ENTER_ACCOUNT_BALANCE;
    v_payment           INTEGER := :ENTER_PAYMENT_AMOUNT;
    v_remaining_balance INTEGER;
BEGIN
    v_remaining_balance := (v_account_balance - v_payment);
    
    DBMS_OUTPUT.PUT_LINE('Account balance = ' || v_account_balance);
    DBMS_OUTPUT.PUT_LINE('Payment amount  = ' || v_payment);

    IF v_remaining_balance > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Current balance = ' || v_remaining_balance);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Account Fully Paid');
    END IF;    
END;

--4. Create an anonymous block that produces a list of available vehicle license plate numbers. These numbers must be in the following format: NN-MMM, where NN is between 60 and 65, and MMM is between 100 and 110. Use nested FOR loops. The outer loop should choose numbers between 60 and 65. The inner loop should choose numbers between 100 and 110, and concatenate the two numbers together. 
BEGIN
    DBMS_OUTPUT.PUT_LINE('Available License Tags are: ');
    FOR i IN 60..65 LOOP
        FOR j IN 100..110 LOOP
            DBMS_OUTPUT.PUT_LINE(i || '-' || j);
        END LOOP;
    END LOOP;
END;

--5. The shipping department determines shipping costs based on the number of items ordered and club membership status. The applicable rates are shown in the following chart. Create an anonymous block that prompts membership status containing a Y or N and quantity ordered. Input different values to test. Output the membership status, quantity ordered, and shipping cost.
DECLARE
    v_membership_status VARCHAR2(1)  := :ENTER_MEMBERSHIP_STATUS;
    v_quantity_ordered  INTEGER      := :ENTER_QUANTITY_ORDERED;
    c_NONMEM_LEVEL1     NUMERIC(4,2) := 5.00;
    c_NONMEM_LEVEL2     NUMERIC(4,2) := 7.50;
    c_NONMEM_LEVEL3     NUMERIC(4,2) := 10.00;
    c_NONMEM_LEVEL4     NUMERIC(4,2) := 12.00;
    c_MEM_LEVEL1        NUMERIC(4,2) := 3.00;
    c_MEM_LEVEL2        NUMERIC(4,2) := 5.00;
    c_MEM_LEVEL3        NUMERIC(4,2) := 7.00;
    c_MEM_LEVEL4        NUMERIC(4,2) := 9.00;
    c_SHIPPING_LEVEL1   INTEGER      := 3;
    c_SHIPPING_LEVEL2   INTEGER      := 6;
    c_SHIPPING_LEVEL3   INTEGER      := 10;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Membership status: ' || v_membership_status);
    DBMS_OUTPUT.PUT_LINE('Quantity ordered: ' || v_quantity_ordered);

    CASE v_membership_status
        WHEN 'N' THEN
            CASE
                WHEN v_quantity_ordered <= c_SHIPPING_LEVEL1 THEN
                    DBMS_OUTPUT.PUT_LINE('Shipping cost = ' || c_NONMEM_LEVEL1);
                WHEN v_quantity_ordered <= c_SHIPPING_LEVEL2 THEN
                    DBMS_OUTPUT.PUT_LINE('Shipping cost = ' || c_NONMEM_LEVEL2);
                WHEN v_quantity_ordered <= c_SHIPPING_LEVEL3 THEN
                    DBMS_OUTPUT.PUT_LINE('Shipping cost = ' || c_NONMEM_LEVEL3);
                ELSE
                    DBMS_OUTPUT.PUT_LINE('Shipping cost = ' || c_NONMEM_LEVEL4);
            END CASE;
        ELSE
            CASE
                WHEN v_quantity_ordered <= c_SHIPPING_LEVEL1 THEN
                    DBMS_OUTPUT.PUT_LINE('Shipping cost = ' || c_MEM_LEVEL1);
                WHEN v_quantity_ordered <= c_SHIPPING_LEVEL2 THEN
                    DBMS_OUTPUT.PUT_LINE('Shipping cost = ' || c_MEM_LEVEL2);
                WHEN v_quantity_ordered <= c_SHIPPING_LEVEL3 THEN
                    DBMS_OUTPUT.PUT_LINE('Shipping cost = ' || c_MEM_LEVEL3);
                ELSE
                    DBMS_OUTPUT.PUT_LINE('Shipping cost = ' || c_MEM_LEVEL4);
            END CASE;
    END CASE;
END;

--6. Create the following DONORS table 
--NOTE: Use named constants as much as possible. Try to avoid hard-coding values in the execution section.
DROP TABLE donors;

CREATE TABLE donors
(  donor_id              INTEGER         NOT NULL,
   donor_name            VARCHAR2 (30)   NOT NULL,
   donor_type            VARCHAR  (1)    NOT NULL,
   monthly_pledge_amount DECIMAL  (5, 0) NOT NULL,
   start_date            DATE            NOT NULL,
   pledge_months         DECIMAL  (3, 0),
  CONSTRAINT donors_donor_id_pk
    PRIMARY KEY(donor_id) );

INSERT ALL
INTO donors VALUES ( 1, 'Jake Smith',       'I', 22,   '10-Jan-2017', 24)
INTO donors VALUES ( 2, 'Sally Donor',      'G', 15,   '22-Feb-2017', 24)
INTO donors VALUES ( 3, 'Lakeside Inc.',    'B', 250,  '05-Mar-2017', 24)
INTO donors VALUES ( 4, 'Terry Manis',      'I', 10,   '18-Jan-2017', 36)
INTO donors VALUES ( 5, 'Janis Porter',     'G', 5,    '15-Feb-2017', 18)
INTO donors VALUES ( 6, 'Main Street Inc.', 'B', 40,   '12-Mar-2017', 12)
SELECT * FROM donors;

--6. Con't An organization has committed to matching pledge amounts based on the donor type and total pledge amount (monthly pledge amount * pledge months). Donor types include I = Individual, B = Business organization, and G = Grant funds. Prompt for the donor id and access the DONORS table and return donor name, donor type, monthly pledge amount, and pledge months. Output donor name, donor type, total amount pledged, and the match amount. Use nested IF statements for this application. The matching percent are shown below.
DECLARE
    v_donor_id              donors.donor_id%TYPE   := :ENTER_DONOR_ID;
    v_donor_name            donors.donor_name%TYPE;
    v_donor_type            donors.donor_type%TYPE;
    v_monthly_pledge        donors.monthly_pledge_amount%TYPE;
    v_pledge_months         donors.pledge_months%TYPE;
    v_match_pledge          NUMERIC(6,2);
    v_pledge_amount         NUMERIC(6,2);
    c_DONOR_MATCH_MIN       NUMERIC(5,2)           := 100.00;
    c_DONOR_MATCH_I_50_LIM  NUMERIC(5,2)           := 249.00;
    c_DONOR_MATCH_I_30_LIM  NUMERIC(5,2)           := 499.00;
    c_DONOR_MATCH_B_20_LIM  NUMERIC(5,2)           := 499.00;
    c_DONOR_MATCH_B_10_LIM  NUMERIC(5,2)           := 999.00;
    c_DONOR_MATCH_RATE_I_50 NUMERIC(3,2)           := 0.50;
    c_DONOR_MATCH_RATE_I_30 NUMERIC(3,2)           := 0.30;
    c_DONOR_MATCH_RATE_I_20 NUMERIC(3,2)           := 0.20;
    c_DONOR_MATCH_RATE_B_20 NUMERIC(3,2)           := 0.20;
    c_DONOR_MATCH_RATE_B_10 NUMERIC(3,2)           := 0.10;
    c_DONOR_MATCH_RATE_B_5  NUMERIC(3,2)           := 0.05;
    c_DONOR_MATCH_RATE_G_5  NUMERIC(3,2)           := 0.05;
BEGIN
    SELECT donor_name, donor_type, monthly_pledge_amount, pledge_months
        INTO v_donor_name, v_donor_type, v_monthly_pledge, v_pledge_months
        FROM donors
        WHERE donor_id = v_donor_id;

    v_pledge_amount := v_monthly_pledge * v_pledge_months;

    DBMS_OUTPUT.PUT_LINE('Donor pledge for ' || v_donor_name);
    DBMS_OUTPUT.PUT_LINE('Donor type is ' || v_donor_type);
    DBMS_OUTPUT.PUT_LINE('Amount pledged = ' || TO_CHAR(v_pledge_amount, '$99,999.99'));

    IF v_pledge_amount >= c_DONOR_MATCH_MIN THEN
        IF v_donor_type = 'I' THEN
            IF v_pledge_amount <= c_DONOR_MATCH_I_50_LIM THEN
                v_match_pledge := v_pledge_amount * c_DONOR_MATCH_RATE_I_50;
                DBMS_OUTPUT.PUT_LINE('Match amount = ' || TO_CHAR(v_match_pledge,'$99,999.99'));
            ELSIF v_pledge_amount <= c_DONOR_MATCH_I_30_LIM THEN
                v_match_pledge := v_pledge_amount * c_DONOR_MATCH_RATE_I_30;
                DBMS_OUTPUT.PUT_LINE('Match amount = ' || TO_CHAR(v_match_pledge,'$99,999.99'));
            ELSE
                v_match_pledge := v_pledge_amount * c_DONOR_MATCH_RATE_I_20;
                DBMS_OUTPUT.PUT_LINE('Match amount = ' || TO_CHAR(v_match_pledge,'$99,999.99'));
            END IF;
        ELSIF v_donor_type = 'B' THEN
            IF v_pledge_amount <= c_DONOR_MATCH_B_20_LIM THEN
                v_match_pledge := v_pledge_amount * c_DONOR_MATCH_RATE_B_20;
                DBMS_OUTPUT.PUT_LINE('Match amount = ' || TO_CHAR(v_match_pledge,'$99,999.99'));
            ELSIF v_pledge_amount <= c_DONOR_MATCH_B_10_LIM THEN
                v_match_pledge := v_pledge_amount * c_DONOR_MATCH_RATE_B_10;
                DBMS_OUTPUT.PUT_LINE('Match amount = ' || TO_CHAR(v_match_pledge,'$99,999.99'));
            ELSE
                v_match_pledge := v_pledge_amount * c_DONOR_MATCH_RATE_B_5;
                DBMS_OUTPUT.PUT_LINE('Match amount = ' || TO_CHAR(v_match_pledge,'$99,999.99'));
            END IF;
        ELSE
            v_match_pledge := v_pledge_amount * c_DONOR_MATCH_RATE_G_5;
            DBMS_OUTPUT.PUT_LINE('Match amount = ' || TO_CHAR(v_match_pledge,'$99,999.99'));
        END IF;
    ELSE
        DBMS_OUTPUT.PUT_LINE('Donor pledge does not qualify for match.');
    END IF;
END;

--7. Modify 4-6 to use a CASE structures.
DECLARE
    v_donor_id              donors.donor_id%TYPE   := :ENTER_DONOR_ID;
    v_donor_name            donors.donor_name%TYPE;
    v_donor_type            donors.donor_type%TYPE;
    v_monthly_pledge        donors.monthly_pledge_amount%TYPE;
    v_pledge_months         donors.pledge_months%TYPE;
    v_match_pledge          NUMERIC(6,2);
    v_pledge_amount         NUMERIC(6,2);
    c_DONOR_MATCH_MIN       NUMERIC(5,2)           := 100.00;
    c_DONOR_MATCH_I_50_LIM  NUMERIC(5,2)           := 249.00;
    c_DONOR_MATCH_I_30_LIM  NUMERIC(5,2)           := 499.00;
    c_DONOR_MATCH_B_20_LIM  NUMERIC(5,2)           := 499.00;
    c_DONOR_MATCH_B_10_LIM  NUMERIC(5,2)           := 999.00;
    c_DONOR_MATCH_RATE_I_50 NUMERIC(3,2)           := 0.50;
    c_DONOR_MATCH_RATE_I_30 NUMERIC(3,2)           := 0.30;
    c_DONOR_MATCH_RATE_I_20 NUMERIC(3,2)           := 0.20;
    c_DONOR_MATCH_RATE_B_20 NUMERIC(3,2)           := 0.20;
    c_DONOR_MATCH_RATE_B_10 NUMERIC(3,2)           := 0.10;
    c_DONOR_MATCH_RATE_B_5  NUMERIC(3,2)           := 0.05;
    c_DONOR_MATCH_RATE_G_5  NUMERIC(3,2)           := 0.05;
BEGIN
    SELECT donor_name, donor_type, monthly_pledge_amount, pledge_months
        INTO v_donor_name, v_donor_type, v_monthly_pledge, v_pledge_months
        FROM donors
        WHERE donor_id = v_donor_id;

    v_pledge_amount := v_monthly_pledge * v_pledge_months;

    DBMS_OUTPUT.PUT_LINE('Donor pledge for ' || v_donor_name);
    DBMS_OUTPUT.PUT_LINE('Donor type is ' || v_donor_type);
    DBMS_OUTPUT.PUT_LINE('Amount pledged = ' || TO_CHAR(v_pledge_amount, '$99,999.99'));

    CASE
        WHEN v_pledge_amount >= c_DONOR_MATCH_MIN THEN
            CASE v_donor_type 
                WHEN 'I' THEN
                    CASE
                        WHEN v_pledge_amount >= c_DONOR_MATCH_MIN AND v_pledge_amount <= c_DONOR_MATCH_I_50_LIM THEN
                            v_match_pledge := v_pledge_amount * c_DONOR_MATCH_RATE_I_50;
                            DBMS_OUTPUT.PUT_LINE('Match amount = ' || TO_CHAR(v_match_pledge,'$99,999.99'));
                        WHEN v_pledge_amount <= c_DONOR_MATCH_I_30_LIM THEN
                            v_match_pledge := v_pledge_amount * c_DONOR_MATCH_RATE_I_30;
                            DBMS_OUTPUT.PUT_LINE('Match amount = ' || TO_CHAR(v_match_pledge,'$99,999.99'));
                        ELSE
                            v_match_pledge := v_pledge_amount * c_DONOR_MATCH_RATE_I_20;
                            DBMS_OUTPUT.PUT_LINE('Match amount = ' || TO_CHAR(v_match_pledge,'$99,999.99'));
                        END CASE;
                WHEN 'B' THEN
                    CASE
                        WHEN v_pledge_amount >= c_DONOR_MATCH_MIN AND v_pledge_amount <= c_DONOR_MATCH_B_20_LIM THEN
                            v_match_pledge := v_pledge_amount * c_DONOR_MATCH_RATE_B_20;
                            DBMS_OUTPUT.PUT_LINE('Match amount = ' || TO_CHAR(v_match_pledge,'$99,999.99'));
                        WHEN v_pledge_amount <= c_DONOR_MATCH_B_10_LIM THEN
                            v_match_pledge := v_pledge_amount * c_DONOR_MATCH_RATE_B_10;
                            DBMS_OUTPUT.PUT_LINE('Match amount = ' || TO_CHAR(v_match_pledge,'$99,999.99'));
                        ELSE
                            v_match_pledge := v_pledge_amount * c_DONOR_MATCH_RATE_B_5;
                            DBMS_OUTPUT.PUT_LINE('Match amount = ' || TO_CHAR(v_match_pledge,'$99,999.99'));
                    END CASE;
                ELSE
                    v_match_pledge := v_pledge_amount * c_DONOR_MATCH_RATE_G_5;
                    DBMS_OUTPUT.PUT_LINE('Match amount = ' || TO_CHAR(v_match_pledge,'$99,999.99'));
            END CASE;
        ELSE
            DBMS_OUTPUT.PUT_LINE('Donor pledge does not qualify for match.');
    END CASE;    
END;

--8. Create a PL/SQL block that includes a FOR loop that generates a pledge schedule, which is paid in equal monthly increments. Input the donor id and access the DONORS table to retrieve donor name, monthly pledge amount, start date, and number of pledge months. The output should display a line for each monthly pledge showing pledge number, due date, monthly pledge amount, and donation balance (remaining amount of pledge owed). Note the output for due date and dollar amounts.
DECLARE
    v_donor_id donors.donor_id%TYPE := :ENTER_DONOR_ID;
    v_donor_name            donors.donor_name%TYPE;
    v_pledge_months         donors.pledge_months%TYPE;
    v_monthly_pledge        donors.monthly_pledge_amount%TYPE;
    v_start_date            donors.start_date%TYPE;
    v_pledge_amount         NUMERIC(7,2);
    v_balance               NUMERIC(7,2);
BEGIN
    SELECT donor_name, monthly_pledge_amount, start_date, pledge_months
        INTO v_donor_name, v_monthly_pledge, v_start_date, v_pledge_months
        FROM donors
        WHERE donor_id = v_donor_id;

    v_pledge_amount := v_pledge_months * v_monthly_pledge;

    DBMS_OUTPUT.PUT_LINE('Donor pledge for ' || v_donor_name);
    DBMS_OUTPUT.PUT_LINE('Amount pledged = ' || TO_CHAR(v_pledge_amount, '$99,999.99'));
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('Pledge#' || LPAD('Due Date',15) || LPAD('Amount',15) || LPAD('Balance',11));
    DBMS_OUTPUT.PUT_LINE('-------' || LPAD('--------',15) || LPAD('------',15) || LPAD('-------',11));
    
    v_balance := v_pledge_amount;

    FOR i IN 1..v_pledge_months LOOP
        v_balance := v_balance - v_monthly_pledge;
        DBMS_OUTPUT.PUT_LINE(LPAD(i,7) || LPAD(TO_CHAR(v_start_date, 'Mon DD, YYYY'), 19) || TO_CHAR(v_monthly_pledge, '$99,999.99') || TO_CHAR(v_balance, '$99,999.99'));
        v_start_date := ADD_MONTHS(v_start_date, 1);
    END LOOP;
END;

--9. Create Table 
DROP TABLE loans;

CREATE TABLE loans
(  loan_no               INTEGER       NOT NULL,
   loan_amount           DECIMAL(7,2)  NOT NULL,
   loan_payment          DECIMAL(5,2)  NOT NULL,
   yearly_interest_rate  DECIMAL  (2)  NOT NULL,
  CONSTRAINT loans_loan_no_pk
    PRIMARY KEY( loan_no ) );
  
INSERT INTO loans VALUES ( 1, 5500.00, 325.50, 12 );

--9. Create a PL/SQL block that includes a WHILE loop that generates a payment schedule for loans, which is paid in equal monthly increments. Input the loan number and access the LOANS table to retrieve loan amount, loan payment, and yearly interest rate. The output should be displayed as shown. The monthly interest is calculated by dividing the yearly interest rate by 100 to get a percent. Then, divide the yearly interest rate by 12 to get the monthly interest rate. Note: Make sure to handle the final payment.
DECLARE
    v_loan_no               loans.loan_no%TYPE := :ENTER_LOAN_NO;
    v_loan_amount           loans.loan_amount%TYPE;
    v_loan_payment          loans.loan_payment%TYPE;
    v_year_interest         loans.yearly_interest_rate%TYPE;
    v_monthly_interest_rate DECIMAL(4,2);
    v_monthly_interest      DECIMAL(4,2);
    v_balance               loans.loan_amount%TYPE;
    v_counter               INTEGER :=1;
BEGIN
    SELECT loan_no, loan_amount, loan_payment, yearly_interest_rate
        INTO   v_loan_no, v_loan_amount, v_loan_payment, v_year_interest
        FROM loans
        WHERE loan_no = v_loan_no;

    v_monthly_interest_rate := ((v_year_interest/100)/12);
    v_balance := v_loan_amount;

    DBMS_OUTPUT.PUT_LINE('Loan No. : ' || v_loan_no);
    DBMS_OUTPUT.PUT_LINE('Loan Amount: ' || TO_CHAR(v_loan_amount, '$99,999.99'));
    DBMS_OUTPUT.PUT_LINE('Loan Payment: ' || TO_CHAR(v_loan_payment, '$9,999.99'));
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('Payment#' ||   LPAD('Interest', 10) || LPAD('Payment', 11) || LPAD(' Balance', 13));
    DBMS_OUTPUT.PUT_LINE('--------' ||   LPAD('--------', 10) || LPAD('-------', 11) || LPAD(' -------', 13));

    WHILE v_balance > 0 LOOP
        v_monthly_interest := v_balance*v_monthly_interest_rate;
        
        IF ((v_balance + v_monthly_interest)-v_loan_payment)  < 0 THEN
            v_loan_payment := v_balance + v_monthly_interest;
            v_balance := 0.00;
            DBMS_OUTPUT.PUT_LINE(LPAD(v_counter, 8) || '    ' || TO_CHAR(v_monthly_interest, '99.99') || '    ' || TO_CHAR(v_loan_payment, '999.99') || '    ' || TO_CHAR(v_balance, '9,999.99'));
        ELSE
            v_balance := (v_balance+v_monthly_interest)-v_loan_payment;
            DBMS_OUTPUT.PUT_LINE(LPAD(v_counter, 8) || '    ' || TO_CHAR(v_monthly_interest, '99.99') || '    ' || TO_CHAR(v_loan_payment, '999.99') || '    ' || TO_CHAR(v_balance, '9,999.99'));
        END IF;

        v_counter := v_counter+1;
    END LOOP;
END;