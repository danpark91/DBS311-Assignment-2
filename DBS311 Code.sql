SET ECHO OFF;
DROP TABLE customer cascade constraints;
DROP TABLE orders cascade constraints;
DROP TABLE payment cascade constraints;
DROP TABLE categories cascade constraints;
DROP TABLE RepRegion cascade constraints;
DROP TABLE label cascade constraints;
DROP TABLE Recording cascade constraints;
DROP TABLE RecordingHistory cascade constraints;
DROP TABLE SalesRep cascade constraints;
DROP TABLE ORDERLINES cascade constraints;

/* 
SET ECHO OFF;
--TABLE DROP STATEMENTS

SET VERIFICATION OFF

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE customers CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE orders CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE payment CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE categories CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
*/

-- Table customer (DDL)
--OK
PROMPT '******* Create customer table';
CREATE TABLE customer (
    CID INT NOT NULL PRIMARY KEY,
    CLastName varchar(50) NOT NULL,
    CFirstName varchar(50) NOT NULL,
    CDateBirth date NOT NULL,
    CAddress varchar(50) NOT NULL,
    Province varchar(50) DEFAULT NULL,
    CpostalCode varchar(15) DEFAULT NULL,
    phone varchar(50) NOT NULL,
    Cemail varchar(50) NOT NULL,
    UNIQUE(Cemail)
);
--OK
-- Data for the table 'CUSTOMER' (DML)
INSERT ALL
    INTO customer VALUES (1, 'Manzon', 'Mary', to_date('1993-01-06','yyyy-mm-dd'), '100 Market Street', 'QC', '94080', '+1 650 219 4782', 'dmurphy@classicmodelcars.com')
    INTO customer VALUES (2, 'Merck', 'Bob', to_date('1997-07-09','yyyy-mm-dd'), '1550 Court Place', 'SK', '02107', '+1 215 837 0825', 'bmerck@classicmodelcars.com')
    INTO customer VALUES (3, 'Morgon', 'John', to_date('1993-12-06','yyyy-mm-dd'), '898 East 57th Street', 'MB', '10022', '+1 212 555 3000', 'gbondur@classicmodelcars.com')
    INTO customer VALUES (4, 'Jennings', 'Luis', to_date('1995-03-08','yyyy-mm-dd'), '74 Jeffrey Street', 'ON', '75017', '+33 14 723 4404', 'ljennings@classicmodelcars.com')
    INTO customer VALUES (5, 'Amsterdam', 'Sam', to_date('1997-02-27','yyyy-mm-dd'), '43 Rue Place', 'QC', '75817', '+1 650 723 4782', 'samsterdam@classicmodelcars.com')
    INTO customer VALUES (6, 'Altuz', 'Murphy', to_date('1984-09-22','yyyy-mm-dd'), '100 Market Drive', 'SK', '94080', '+1 215 719 5782', 'maltuz@classicmodelcars.com')
    INTO customer VALUES (7, 'McKenna', 'Baden', to_date('1997-07-26','yyyy-mm-dd'), '1550 Court Avenue', 'SK', '02107', '+1 215 837 0825', 'bmckenna@classicmodelcars.com')
    INTO customer VALUES (8, 'Monzese', 'Jonas', to_date('1989-05-30','yyyy-mm-dd'), '500 East 49th Street', 'MB', '10022', '+1 269 555 3000', 'jmonzese@classicmodelcars.com')
    INTO customer VALUES (9, 'Lincoln', 'Kevin', to_date('1977-10-07','yyyy-mm-dd'), '80 East Avenue', 'ON', '75017', '+33 14 723 9955', 'klincoln@classicmodelcars.com')
    INTO customer VALUES (10, 'Bavarian', 'Silva', to_date('1999-09-09','yyyy-mm-dd'), '80 Place Street', 'SK', '75817', '+33 14 733 4090', 'sbavarian@classicmodelcars.com')
    SELECT * FROM DUAL;
COMMIT;

-- Table orders (DDL)
--OK
PROMPT '******* Create orders table';
CREATE TABLE orders (
  orderiD int NOT NULL PRIMARY KEY,
  orderDate date NOT NULL,
  cID int NOT NULL,
  orderTotal DECIMAL(10,2),
  CONSTRAINT ordelGReated check(orderTotal>0),
  CONSTRAINT orders_cust_fk FOREIGN KEY (cId) REFERENCES customer (CID)
);

--OK
-- Data for the table 'ORDERS' (DML)
INSERT ALL
    INTO orders VALUES (10100,to_date('2003-9-16','yyyy-mm-dd'),1,1000)
    INTO orders VALUES (10101,to_date('2003-3-19','yyyy-mm-dd'),2,2345)
    INTO orders VALUES (10102,to_date('2003-4-11','yyyy-mm-dd'),3,1234)
    INTO orders VALUES (10103,to_date('2003-6-29','yyyy-mm-dd'),4,21312)
    INTO orders VALUES (10104,to_date('2003-8-01','yyyy-mm-dd'),5,32422)
    INTO orders VALUES (10105,to_date('2003-2-26','yyyy-mm-dd'),6,234234)
    INTO orders VALUES (10106,to_date('2003-1-29','yyyy-mm-dd'),7,324423)
    INTO orders VALUES (10107,to_date('2003-8-27','yyyy-mm-dd'),8,54353)
    INTO orders VALUES (10108,to_date('2003-12-29','yyyy-mm-dd'),9,432)
    INTO orders VALUES (10109,to_date('2003-11-27','yyyy-mm-dd'),10,42312)
    SELECT * FROM DUAL;
COMMIT;
    
-- Table payment (DDL)
--OK
PROMPT '******* Create payment table';
CREATE TABLE payment (
  cardNumber int NOT NULL,
  orderId int NOT NULL,
  cardHolder varchar(50),
  expDate date NOT NULL,
  cardType varchar(50)CHECK(cardType IN('VISA', 'MAST', 'AMEX')),
  PRIMARY KEY (cardNumber),
  CONSTRAINT payments_Orders FOREIGN KEY (orderId) REFERENCES orders (orderiD)
);

--OK
-- Data for the table payment (DML)
INSERT ALL
    INTO payment VALUES(4887271275383781,10100,'Manzon Mary',to_date('2004-10','yyyy-mm'),'VISA')
    INTO payment VALUES(4887271275383782,10101,'Merck Bob',to_date('2003-06','yyyy-mm'),'VISA')
    INTO payment VALUES(4887271275383783,10102,'Morgan John',to_date('2004-12','yyyy-mm'),'VISA')
    INTO payment VALUES(4887271275383784,10103,'Jennings Luis',to_date('2004-12','yyyy-mm'),'VISA')
    INTO payment VALUES(4887271275383785,10104,'Amsterdam Sam',to_date('2003-06','yyyy-mm'),'AMEX')
    INTO payment VALUES(4887271275383786,10105,'Altuz Murphy',to_date('2004-08','yyyy-mm'),'MAST')
    INTO payment VALUES(4887271275383787,10106,'McKenna Baden',to_date('2003-05','yyyy-mm'),'MAST')
    INTO payment VALUES(4887271275383788,10107,'Monzese Jonas',to_date('2005-03','yyyy-mm'),'VISA')
    INTO payment VALUES(4887271275383789,10108,'Lincoln Kevin',to_date('2005-09','yyyy-mm'),'AMEX')
    INTO payment VALUES(4887271275383790,10109,'Bavarian Silva',to_date('2005-11','yyyy-mm'),'VISA')
    SELECT * FROM DUAL;
COMMIT;

-- Table categories (DDL)
--OK
PROMPT '******* Create Categories table';
CREATE TABLE categories(
    categoryId INT NOT NULL,
    categoryDesc VARCHAR(50) NOT NULL,
  PRIMARY KEY (categoryId),
 CONSTRAINT categoryValue CHECK(categoryDesc IN('RB', 'Jazz', 'Metal Rock', 'Alt Rock', 'Easy Rock', 'Classic Rock', 'Hip-Hop'))
);

--OK
-- Data for the table categories (DML)
INSERT ALL
    INTO categories VALUES(1,'RB')
    INTO categories VALUES(2,'Jazz')
    INTO categories VALUES(3,'Metal Rock')
    INTO categories VALUES(4,'Alt Rock')
    INTO categories VALUES(5,'Easy Rock')
    INTO categories VALUES(6,'Classic Rock')
    INTO categories VALUES(7,'Hip-Hop')
SELECT * FROM DUAL;
COMMIT;

-- Table RepRegion (DDL)
--OK
PROMPT '******* Create RepRegion table';
CREATE TABLE RepRegion(
    RregionID INT NOT NULL,
    RegionName VARCHAR(50) NOT NULL,
    PRIMARY KEY (RregionID)
);

--OK
-- Data for the table RepRegion (DML)
INSERT ALL
    INTO RepRegion VALUES(1,'US-North')
    INTO RepRegion VALUES(2,'US-West')
    INTO RepRegion VALUES(3,'Canada')
    INTO RepRegion VALUES(4,'Asia')
    INTO RepRegion VALUES(5,'Europe')
    INTO RepRegion VALUES(6,'SouthAmerica')
    SELECT * FROM DUAL;
COMMIT;

-- Table label (DDL)
--OK
PROMPT '******* Create label table';
CREATE TABLE label (
    LabelID int not null,
    LabelName varchar(50),
    URL varchar(100),
    PRIMARY KEY (LabelID)
);

--OK
--Data for the table label (DML)
INSERT ALL
    INTO label VALUES(1,'Sony','https://www.sonymusic.com/labels/')
    INTO label VALUES(2,'Columnia','https://www.columbiarecords.com/')
    INTO label VALUES(3,'Virgin','https://www.virgin.com/virgin-companies/virgin-records')
    INTO label VALUES(4,'Artista Nashville','https://www.artistanashville.com/labels')
    INTO label VALUES(5,'Elektra Records','https://www.elektramusicgroup.com/')
SELECT * FROM DUAL;
COMMIT;

-- ORDERS Table Recording (DDL)
--OK
PROMPT '******* Create Recording table';
CREATE TABLE Recording(
    recordingID INT NOT NULL,
    Title VARCHAR(50),
    Artist VARCHAR(50),
    SellPrice DECIMAL(10,2),
    QtyInStock INT NOT NULL,
    categoryId INT,
    LabelID INT,
    PRIMARY KEY (recordingID),
    CONSTRAINT cate_recor     FOREIGN KEY (categoryId) REFERENCES categories (categoryId),
    CONSTRAINT recor_label    FOREIGN KEY (LabelID)   REFERENCES label (LabelID)
);

--OK
--Data for the table Recording (DML)
INSERT ALL
    INTO Recording VALUES(34,'Fire of Power','Mira Bracha',55.69,12,1,4)
    INTO Recording VALUES(99,'Thunder of','Shreya Anahid',67.60,66,2,4)
    INTO Recording VALUES(76,'Whispers of Choices','Naomi Telesphore',68.18,11,3,1)
    INTO Recording VALUES(01,'Metalcore Destruction','Iris Rosamund',54.15,75,4,2)
    INTO Recording VALUES(66,'Dream Secrets','Reba Katlyn',44.39,45,6,1)
    INTO Recording VALUES(13,'In Whispers','Hildred Rien',76.98,43,5,5)
SELECT * FROM DUAL;
COMMIT;

--ORDERS Table RecordingHistory (DDL)
--OK
PROMPT '******* Create RECORDING HISTORY table';
CREATE TABLE RecordingHistory(
    price DECIMAL(10,2) not null CHECK(price>0 AND price<999.99),
    recordingID int not null,
    price_history DECIMAL(10,2),
    startDate Date not null,
    CONSTRAINT recording_history FOREIGN KEY (recordingID) REFERENCES Recording (recordingID)
);

--OK
--Data for the table RecordingHistory (DML)
INSERT ALL
    INTO RecordingHistory VALUES(98.21, 34, 19, to_date('2022-12','yyyy-mm'))
    INTO RecordingHistory VALUES(44.12, 13, 49, to_date('1999-11','yyyy-mm'))
    INTO RecordingHistory VALUES(123.123, 66, 90, to_date('1978-11','yyyy-mm'))
    INTO RecordingHistory VALUES(12.546, 99, 20, to_date('1955-06','yyyy-mm'))
    INTO RecordingHistory VALUES(47.456, 01, 60, to_date('1987-03','yyyy-mm'))
SELECT * FROM DUAL;
COMMIT;

-- ORDERS Table SalesRep (DDL)
--OK
PROMPT '******* Create SalesRep table';
CREATE TABLE SalesRep (
    Rid int not null,
    RLName varchar(50) NOT NULL,
    RFName varchar(50) NOT NULL,
  phone varchar(50) NOT NULL,
  LabelID int not null,
    RregionID int NOT NULL,
  REmail varchar(50) NOT NULL,
    PRIMARY KEY (Rid),
  UNIQUE(REmail),
    CONSTRAINT label_id   FOREIGN KEY (LabelID) REFERENCES label  (LabelID),
    CONSTRAINT saleRegion FOREIGN KEY (RregionID) REFERENCES RepRegion (RregionID)
);

--OK
--Data for the table SalesRep (DML)
INSERT ALL
    INTO SalesRep VALUES(1, 'Abel', 'Reyes', '+1 311 377-6274', 1, 1, 'gumpish@gmail.com')
    INTO SalesRep VALUES(2, 'India', 'Thomas', '+1 332 312-1234', 1, 2, 'johnbob@aol.com')
    INTO SalesRep VALUES(4, 'Roosevelt', 'Brennan', '+1 123 365-7274', 4, 1, 'kmiller@optonline.net')
    INTO SalesRep VALUES(5, 'Velasequz', 'Maria', '+1 999 334-9856', 2, 3, 'pedwards@msn.com')
    INTO SalesRep VALUES(6, 'Connor', 'Squires', '+1 848 949-9999', 1, 4, 'graham@msn.com')
    SELECT * FROM DUAL;
COMMIT;

-- ORDERS Table orderlines (DDL)
--OK
PROMPT '******* Create ORDERLINES table';
CREATE TABLE orderlines(
  Line int NOT NULL,
  orderId int NOT NULL,
  Qty int NOT NULL CHECK(Qty>=0),
  actPrice decimal(10,3) NOT NULL CHECK(actPrice>0),
  recordingID int not null,
  PRIMARY KEY (LINE,orderId),
  CONSTRAINT Order_lines FOREIGN KEY (orderId) REFERENCES orders (orderiD),
  CONSTRAINT Order_recording FOREIGN KEY (recordingID) REFERENCES Recording (recordingID)
);

--OK
--Data for the table SalesRep (DML)
INSERT ALL
    INTO ORDERLINES VALUES(123, 10100, 9876, 191, 34)
    INTO ORDERLINES VALUES(198, 10101, 9, 998, 99)
    INTO ORDERLINES VALUES(12, 10102, 10, 428, 76)
    INTO ORDERLINES VALUES(111, 10103, 996, 729, 01)
    INTO ORDERLINES VALUES(765, 10104, 988, 765, 66)
    INTO ORDERLINES VALUES(989, 10105, 543, 23, 13)
SELECT * FROM DUAL;
COMMIT;
/*
SET VERIFICATION ON
SET ECHO ON
*/

create or replace procedure Recording_Selling_Price_Report as

avg_price NUMBER(9,2);
low_count NUMBER := 0;
high_count NUMBER := 0;

Begin
    select avg(actprice) into avg_price from Orderlines;
    for item in (select actprice from Orderlines)
    loop
        if item.actprice < avg_price then
            low_count := low_count + 1;
        elsif item.actprice > avg_price then
            high_count := high_count + 1;
        end if;
    end loop;
    dbms_output.put_line('Recordings Selling Price Report');
    dbms_output.put_line('Low: ' || low_count);
    dbms_output.put_line('High: ' || high_count);
End;