BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE accounts CASCADE CONSTRAINTS';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;
/

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE employees CASCADE CONSTRAINTS';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;
/

CREATE TABLE accounts (
   account_id     NUMBER PRIMARY KEY,
   customer_id    NUMBER,
   account_type   VARCHAR2(20),
   balance        NUMBER
);
CREATE TABLE employees (
   emp_id         NUMBER PRIMARY KEY,
   name           VARCHAR2(50),
   department_id  NUMBER,
   salary         NUMBER
);
INSERT INTO accounts VALUES (101, 1, 'Savings', 10000);
INSERT INTO accounts VALUES (102, 2, 'Savings', 20000);
INSERT INTO accounts VALUES (103, 3, 'Current', 5000);
INSERT INTO accounts VALUES (104, 4, 'Savings', 15000);
COMMIT;

INSERT INTO employees VALUES (1, 'Dhanush', 10, 40000);
INSERT INTO employees VALUES (2, 'Siva', 10, 42000);
INSERT INTO employees VALUES (3, 'Menaka', 20, 50000);
COMMIT;

-- Scenario 1: ProcessMonthlyInterest
CREATE OR REPLACE PROCEDURE ProcessMonthlyInterest IS
BEGIN
   FOR acc_rec IN (
      SELECT account_id, balance
      FROM accounts
      WHERE LOWER(account_type) = 'savings'
   )
   LOOP
      UPDATE accounts
      SET balance = balance + (acc_rec.balance * 0.01)
      WHERE account_id = acc_rec.account_id;
   END LOOP;

   COMMIT;
   DBMS_OUTPUT.PUT_LINE('Monthly interest processed for all savings accounts.');
EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

-- Scenario 2: UpdateEmployeeBonus
CREATE OR REPLACE PROCEDURE UpdateEmployeeBonus (
   dept IN NUMBER,
   bonus_percent IN NUMBER
) IS
BEGIN
   UPDATE employees
   SET salary = salary + (salary * bonus_percent / 100)
   WHERE department_id = dept;

   COMMIT;
   DBMS_OUTPUT.PUT_LINE('Bonus updated for Department ID: ' || dept);
EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

-- Scenario 3: TransferFunds
CREATE OR REPLACE PROCEDURE TransferFunds (
   source_acc IN NUMBER,
   target_acc IN NUMBER,
   amount IN NUMBER
) IS
   src_balance NUMBER;
BEGIN
   SELECT balance INTO src_balance
   FROM accounts
   WHERE account_id = source_acc
   FOR UPDATE;

   IF src_balance < amount THEN
      RAISE_APPLICATION_ERROR(-20001, 'Insufficient balance in source account');
   END IF;

   UPDATE accounts
   SET balance = balance - amount
   WHERE account_id = source_acc;

   UPDATE accounts
   SET balance = balance + amount
   WHERE account_id = target_acc;

   COMMIT;
   DBMS_OUTPUT.PUT_LINE('Transferred ' || amount || ' from Account ' || source_acc || ' to Account ' || target_acc);
EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/
BEGIN
   DBMS_OUTPUT.ENABLE;
END;
/

BEGIN
   ProcessMonthlyInterest;
END;
/

BEGIN
   UpdateEmployeeBonus(10, 5);
END;
/

BEGIN
   TransferFunds(102, 103, 3000);
END;
/

SELECT * FROM accounts;
SELECT * FROM employees;
