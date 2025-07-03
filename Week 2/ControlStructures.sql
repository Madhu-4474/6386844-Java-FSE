SET SERVEROUTPUT ON;

BEGIN
   DBMS_OUTPUT.ENABLE;
END;
/
BEGIN
   DBMS_OUTPUT.PUT_LINE('Starting PL/SQL Logic');
   FOR cust_rec IN (
      SELECT l.loan_id, l.customer_id, l.interest_rate
      FROM loans l
      JOIN customers c ON l.customer_id = c.customer_id
      WHERE c.age > 60
   )
   LOOP
      UPDATE loans
      SET interest_rate = interest_rate - 1
      WHERE loan_id = cust_rec.loan_id;

      DBMS_OUTPUT.PUT_LINE('1% discount applied for Customer ID: ' || cust_rec.customer_id);
   END LOOP;


   FOR vip_rec IN (
      SELECT customer_id
      FROM customers
      WHERE balance > 10000 AND NVL(isVIP, 'FALSE') != 'TRUE'
   )
   LOOP
      UPDATE customers
      SET isVIP = 'TRUE'
      WHERE customer_id = vip_rec.customer_id;

      DBMS_OUTPUT.PUT_LINE('Customer promoted to VIP: ' || vip_rec.customer_id);
   END LOOP;

   FOR due_rec IN (
      SELECT l.loan_id, c.customer_id, c.name, l.due_date
      FROM loans l
      JOIN customers c ON l.customer_id = c.customer_id
      WHERE l.due_date BETWEEN SYSDATE AND SYSDATE + 30
   )
   LOOP
      DBMS_OUTPUT.PUT_LINE('Reminder: Loan ID ' || due_rec.loan_id ||
                           ' for Customer ' || due_rec.name ||
                           ' (ID: ' || due_rec.customer_id ||
                           ') is due on ' || TO_CHAR(due_rec.due_date, 'DD-MON-YYYY'));
   END LOOP;

   COMMIT;
EXCEPTION
   WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error occurred: ' || SQLERRM);
      ROLLBACK;
END;
/