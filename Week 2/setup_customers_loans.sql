BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE loans';
EXCEPTION WHEN OTHERS THEN
   DBMS_OUTPUT.PUT_LINE('loans table may not exist yet.');
END;
/

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE customers';
EXCEPTION WHEN OTHERS THEN
   DBMS_OUTPUT.PUT_LINE('customers table may not exist yet.');
END;
/
CREATE TABLE customers (
   customer_id NUMBER PRIMARY KEY,
   name        VARCHAR2(100),
   age         NUMBER,
   balance     NUMBER,
   isVIP       VARCHAR2(5)
);
CREATE TABLE loans (
   loan_id       NUMBER PRIMARY KEY,
   customer_id   NUMBER,
   interest_rate NUMBER,
   due_date      DATE,
   FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
INSERT INTO customers VALUES (1, 'Anita', 65, 12000, 'FALSE');
INSERT INTO customers VALUES (2, 'Ravi', 45, 9000, 'FALSE');
INSERT INTO customers VALUES (3, 'Meena', 70, 15000, NULL);
INSERT INTO loans VALUES (101, 1, 9.0, SYSDATE + 10);
INSERT INTO loans VALUES (102, 2, 8.5, SYSDATE + 40);
INSERT INTO loans VALUES (103, 3, 9.5, SYSDATE + 5);
COMMIT;
SELECT * FROM CUSTOMERS;
SELECT * FROM LOANS;