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
    
    DBMS_OUTPUT.PUT_LINE('Account balance = $' || v_account_balance);
    DBMS_OUTPUT.PUT_LINE('Payment amount = $' || v_payment);

    IF v_remaining_balance > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Current balance = $' || v_remaining_balance);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Account Fully Paid');
    END IF;    
END;