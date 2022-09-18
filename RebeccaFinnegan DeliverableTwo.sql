DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS visits;
DROP TABLE IF EXISTS visitors;
DROP TABLE IF EXISTS members;
DROP TABLE  IF EXISTS customers;
DROP TABLE IF EXISTS tables_b;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS employees;

CREATE TABLE employees
(
  staffID INT(6) PRIMARY KEY AUTO_INCREMENT,
  empName VARCHAR(40) NOT NULL,
  address VARCHAR(100) NOT NULL,
  mobile INT(10) NOT NULL,
  hourlyRate INT(5) NOT NULL,
  PPSNum VARCHAR(30) NOT NULL,
  IBAN VARCHAR(40) NOT NULL,
  bankAccNum INT(30) NOT NULL,
  startDate DATE NOT NULL,
  contractDuration VARCHAR(20),
  medicalHistory VARCHAR(50)
);

INSERT INTO employees(staffID, empName, address, mobile, hourlyRate, PPSNum, IBAN, bankAccNum, startDate, contractDuration, medicalHistory)
VALUES 
  (104567, 'John Murphy', 'Waterford City, Waterford', 085693256, 16.00, '345B8889ZY0', '00020D20256', 026532, '2015-03-15', '6 years', 'Asthma'),
  (289543, 'Ciara Walsh', 'Newrath, Kilkenny', 087841203, 12.00, '8PU746GH00', '74569P80', 8452255, '2021-05-1', '4 months - Seasonal', 'None'),
  (785145, 'Kieran ONeill', 'Ardkeen, Waterford', 051475698, 14.00, 'PG3483240Y', '012RY03578', 9530625, '2020-03-23', '3 years', 'None'),
  (000125, 'Lauren Mackey', 'Kilmacow, Kilkenny', 051475698, 11.00, '321JUP890', 'Y87T254426', 4562845, '2021-06-11', '3 months - Seasonal', 'Heart Condition');


CREATE TABLE products
(
  productID INT(6) PRIMARY KEY AUTO_INCREMENT,
  productType VARCHAR(10) NOT NULL,
  productName VARCHAR(100) NOT NULL,
  price INT(6) NOT NULL CHECK (price > 0),
  brand VARCHAR(30) NOT NULL,
  supplier VARCHAR(50) NOT NULL,
  stockLevel INT(10) NOT NULL,
  alcoholType VARCHAR(20),
  saleLevels INT(6),
  draughtTap VARCHAR(5),
  empID INT(6),
  FOREIGN KEY fk_employee(empID) REFERENCES employees(staffID)
	ON UPDATE CASCADE
    ON DELETE SET NULL
);

INSERT INTO products(productID, productType, productName, price, brand, supplier, stockLevel, alcoholType, saleLevels, draughtTap, empID)
VALUES
  (001120, 'Beverage', 'Americano', 2, 'Mean Bean', 'Mean Bean Coffee', 250, '-', '200', '-', 000125),
  (125670, 'Gin', 'Gordons Pink', 8, 'Gordons', 'Musgraves', 20, 'Spirit', '36', '-', 785145),
  (000001, 'Pint', 'Guiness', 5, 'Guiness', 'Diageo', 200, 'Stout', '270', 'Yes', 104567),
  (000520, 'Pint', 'Heineken 00', 6, 'Heineken', 'Musgraves', 150, 'Larger', '360', 'Yes', 289543),
  (000756, 'Snack', 'Dairy Milk', 1, 'Cadburys', 'Musgraves', 15, '-', '20', '-', 000125),
  (085262, 'Snack', 'Cheese & Onion Crisps', 2, 'McCoys', 'World Wide Wines', 28, '-', '6', '-', 000125),
  (001132, 'Beverage', 'Cappuccino', 3, 'Mean Bean', 'Mean Bean Coffee', 150, '-', '151', '-', 289543);
  

CREATE TABLE tables_b
(
  tableID INT(6) PRIMARY KEY AUTO_INCREMENT,
  location VARCHAR(10) NOT NULL,
  capacity INT(1) NOT NULL CHECK (capacity <= 6),
  tableType VARCHAR(20),
  empID INT(6),
  FOREIGN KEY fk_employee(empID) REFERENCES employees(staffID)
	ON UPDATE CASCADE
    ON DELETE SET NULL
);

INSERT INTO tables_b(tableID, location, capacity, tableType, empID)
VALUES
  (1, 'Bar Hatch', 6, 'TV Viewing Table', 289543),
  (4, 'DanceFloor', 4, 'Window Table', 785145),
  (9, 'Snug', 6, 'Long Table', 000125),
  (15, 'Outdoors', 3, 'Bench', 104567),
  (19, 'Restaurant', 2, 'Restraurant Dining', 785145),
  (8, 'Snug', 2, 'Small Window Table', 000125);


CREATE TABLE customers
(
  customerID INT(6) PRIMARY KEY AUTO_INCREMENT,
  firstName VARCHAR(20),
  lastName VARCHAR(30) NOT NULL,
  vaccineCert VARCHAR(10) NOT NULL,
  photoID VARCHAR(10) NOT NULL,
  phone INT(10) NOT NULL,
  customerType VARCHAR(10) NOT NULL,
  address VARCHAR(100),
  email VARCHAR(80)
);

INSERT INTO customers(customerID, firstName, lastName, vaccineCert, photoID, phone, customerType, address, email)
VALUES
  (005867, 'Sarah', 'Quinn', 'QRCode', 'Licence', 087456987, 'Member', 'Kilmacow, Kilkenny', 'sarahq101@gmail.com'),
  (125458, 'Paul', 'Ryan', 'Card', 'Licence', 083745698, 'Visitor', 'Tullow, Carlow', 'paulll@mail.com'),
  (249358, 'Frank', 'Laurens', 'Letter', 'Passport', 051789328, 'Public', 'Howth, Dublin', 'fr89724fr@gmail.com'),
  (005698, 'Leah', 'Scotts', 'EUPass', 'Passport', 087123547, 'Public', 'Barcelona, Spain', 'scottslea@mail.com'),
  (856952, 'Liam', 'Farrell', 'QRCode', 'Licence', 084463008, 'Visitor', 'Dungarvan, Kilkenny', 'farellgliam@gmail.com'),
  (456789, 'Colm', 'Fitz', '-', '-', 082459689, 'Member', 'Waterford City Centre, Waterford', 'fitzyy@yahoo.com');

CREATE TABLE members
(
  memberNum INT(20) PRIMARY KEY AUTO_INCREMENT,
  clubcardBalance INT(10) NOT NULL,
  transactionHistory VARCHAR(100) NOT NULL,
  customerDetails INT(6),
  FOREIGN KEY fk_customer(customerDetails) REFERENCES customers(customerID)
	ON UPDATE CASCADE
    ON DELETE SET NULL
);

INSERT INTO members(memberNum,clubcardBalance,transactionHistory,customerDetails)
VALUES
  (22503803, 256.00, 'Last Monthly Bar Spendings = 156.00', 456789),
  (62508790, 6.00, 'Last Monthly Bar Spendings = 34.65', 005867);

CREATE TABLE visitors
(
  GUIID INT(20) PRIMARY KEY AUTO_INCREMENT,
  homeClub VARCHAR(40) NOT NULL,
  societies VARCHAR(50),
  team VARCHAR(50),
  customerDetails INT(6),
  FOREIGN KEY fk_customer(customerDetails) REFERENCES customers(customerID)
	ON UPDATE CASCADE
    ON DELETE SET NULL
);

INSERT INTO visitors(GUIID, homeClub, societies, team, customerDetails)
VALUES
  (78956842, 'Carlow Golf Club', 'Carlow Mens Society', '-', 125458),
  (00125987, 'Kilkenny Golf Club', '-', 'Leinster Cup Team', 856952);

CREATE TABLE visits
(
  visitID INT(6) PRIMARY KEY AUTO_INCREMENT,
  visitDate DATE NOT NULL,
  visitTime INT(4) NOT NULL,
  duration VARCHAR(20) NOT NULL,
  purpose VARCHAR(20),
  empID INT(6),
  seatedTable INT(6),
  customerDetails INT(6),
  
  FOREIGN KEY fk_employee(empID) REFERENCES employees(staffID)
	ON UPDATE CASCADE
    ON DELETE SET NULL,
    
FOREIGN KEY fk_tables(seatedTable) REFERENCES tables_b(tableID)
	ON UPDATE CASCADE
    ON DELETE SET NULL,
    
  FOREIGN KEY fk_customer(customerDetails) REFERENCES customers(customerID)
	ON UPDATE CASCADE
    ON DELETE SET NULL
);

INSERT INTO visits(visitID, visitDate, visitTime, duration, purpose, empID, customerDetails, seatedTable)
VALUES
  (012, '2021-11-17', 1013, 'Under an Hour', 'Enquiry', 104567, 005867, 4),
  (028, '2021-05-26', 1256, '5 Hours', '-', 289543, 456789, 15),
  (045, '2021-07-08', 1643, '7 Hours', '-', 785145, 456789, 15),
  (083, '2021-07-08', 1819, '3 Hours', 'Function', 785145, 005698, 9),
  (101, '2021-07-08', 1845, '4 Hours', 'Function', 785145, 249358, 9),
  (125, '2021-11-13', 2011, '2 Hours', 'Match Viewing', 104567, 125458, 1),
  (265, '2021-12-1', 1156, '12 Hours', '-', 785145, 856952, 1);

CREATE TABLE orders
(
  orderNum INT(6) PRIMARY KEY AUTO_INCREMENT,
  paymentMethod VARCHAR(10) NOT NULL,
  tab VARCHAR(10),
  itemID INT(6),
  visitDetails INT(6),
  customerDetails INT(6),
  
  FOREIGN KEY fk_product(itemID) REFERENCES products(productID)
	ON UPDATE CASCADE
    ON DELETE SET NULL,
    
  FOREIGN KEY fk_visit(visitDetails) REFERENCES visits(visitID)
	ON UPDATE CASCADE
    ON DELETE SET NULL,
    
  FOREIGN KEY fk_customer(customerDetails) REFERENCES customers(customerID)
	ON UPDATE CASCADE
    ON DELETE SET NULL
);

INSERT INTO orders(orderNum, paymentMethod, tab, itemID, visitDetails, customerDetails)
VALUES
  (206, 'Clubcard', '-', 001120, 012, 005867),
  (207, 'Clubcard', '-', 001120, 012, 005867),
  (853, 'Cash', 'tab 9', 000001, 045, 456789),
  (6245, 'Card', '-', 125670, 083, 005698),
  (6286, 'Cash', '-', 000520, 101, 249358),
  (226, 'Card', 'tab 23', 000001, 265, 856952);
  
  
SELECT
  firstName AS 'First Name', lastName AS 'Second Name', vaccineCert AS 'Vaccination Proof Shown', photoID AS 'ID Provided'
FROM
  customers
  WHERE 
  vaccineCert != '-' AND photoID != '-';
  
  
SELECT 
  productName AS "Product" , SUM(stockLevel) AS "Stock Units", saleLevels AS "Units Sold - Previous Week"
FROM 
  products 
WHERE 
  stockLevel <= 20 OR stockLevel <= saleLevels
GROUP BY 
  productName;
  
 
SELECT 
  empName AS "Employee", hourlyRate AS "Rate of Pay per Hour", contractDuration AS "Contract"
FROM 
  employees;


SELECT
    c.customerID AS 'Customer',
    c.firstName AS 'First Name',
    c.lastName AS 'Second Name',
    v.empID AS 'Server',
    o.orderNum AS 'Order Number',
    t.tableID AS 'Seated table'
FROM customers c
LEFT JOIN visits v ON v.customerDetails = c.customerID
LEFT JOIN orders o ON o.customerDetails = c.customerID
LEFT JOIN tables_b t ON v.seatedTable = t.tableID;
  