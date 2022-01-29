-- Create the DDL, set up the tables for your database

DROP DATABASE IF EXISTS InNOut;
CREATE DATABASE InNOut;

USE InNOut; 

DROP TABLE IF EXISTS Customers;
CREATE TABLE Customers
( 
  CustomerID			SMALLINT NOT NULL AUTO_INCREMENT,
  FirstName				VARCHAR(25) NOT NULL,
  LastName				VARCHAR(25) NOT NULL,
  Phone					CHAR(12) NOT NULL,
  Email					VARCHAR(35) NOT NULL,
  CONSTRAINT PK_Customers_CustomerID PRIMARY KEY ( CustomerID )
);

DROP TABLE IF EXISTS Employees;
CREATE TABLE Employees 
(
EmployeeID				SMALLINT NOT NULL,
FirstName				VARCHAR(25) NOT NULL,
LastName				VARCHAR(25) NOT NULL,
Title					VARCHAR(35) NOT NULL,
HireDate   				DATETIME NOT NULL
						DEFAULT CURRENT_TIMESTAMP,
ManagerID				SMALLINT,
CONSTRAINT PK_Employees_EmployeeID PRIMARY KEY ( EmployeeID ),
CONSTRAINT FK_Employees_ManagerID FOREIGN KEY ( ManagerID ) REFERENCES Employees ( EmployeeID )
);

DROP TABLE IF EXISTS Orders;
CREATE TABLE Orders
( 
  OrderID				SMALLINT NOT NULL,
  EmployeeID			SMALLINT NOT NULL,
  CustomerID			SMALLINT NOT NULL,
  OrderDate				DATE NOT NULL,
  OrderTime				TIME NOT NULL,
  OrderType 			CHAR(2) NOT NULL Default'TO',
  CONSTRAINT PK_Orders_OrderID PRIMARY KEY ( OrderID ),
  CONSTRAINT FK_Orders_EmployeeID FOREIGN KEY ( EmployeeID ) REFERENCES Employees ( EmployeeID ),
  CONSTRAINT FK_Orders_CustomerID FOREIGN KEY ( CustomerID ) REFERENCES Customers ( CustomerID ),
  CONSTRAINT CHECK_Orders_OrderType CHECK ( OrderType IN ( 'TO', 'DI' ) )
);

DROP TABLE IF EXISTS MenuItems;
CREATE TABLE MenuItems
( 
  ItemID				SMALLINT NOT NULL,
  ItemName				VARCHAR(25) NOT NULL,
  ItemDescription		VARCHAR(100) NOT NULL,
  ItemPrice 			DECIMAL(3,2) NOT NULL,
  CONSTRAINT PK_MenuItems_ItemID PRIMARY KEY ( ItemID )
);

DROP TABLE IF EXISTS OrderItems; 
CREATE TABLE OrderItems
( 
  OrderID				SMALLINT NOT NULL,
  ItemID				SMALLINT NOT NULL, 
  Quantity				SMALLINT NOT NULL,
  /* CONSTRAINT PK_OrderItem_OrderId PRIMARY KEY ( OrderID ),
  CONSTRAINT FK_OrderItem_OrderId FOREIGN KEY ( OrderID ) REFERENCES Orders ( OrderID ),
  */ 
  CONSTRAINT PK_OrderItem_OrderID_ItemID PRIMARY KEY ( OrderID, ItemID ),
  CONSTRAINT FK_OrderItem_OrderID FOREIGN KEY ( OrderID ) REFERENCES Orders ( OrderID ),
  CONSTRAINT FK_OrderItem_ItemID FOREIGN KEY ( ItemID ) REFERENCES MenuItems ( ItemID )
  );

DROP TABLE IF EXISTS Statuses;
CREATE TABLE Statuses 
(
  StatusID				SMALLINT NOT NULL,
  StatusName 			VARCHAR(10) NOT NULL,
  StatusDescription 	VARCHAR(200) NOT NULL,
  CONSTRAINT PK_Statuses_StatusID PRIMARY KEY ( StatusID )
);

DROP TABLE IF EXISTS OrderStatuses;
CREATE TABLE OrderStatuses
  ( 
	OrderID					SMALLINT NOT NULL,
	StatusID				SMALLINT NOT NULL,
	StatusInitiation		DATETIME NOT NULL
							DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT PK_OrderStatus_OrderID_StatusID PRIMARY KEY ( OrderID, StatusID ),
	CONSTRAINT FK_OrderStatus_OrderID FOREIGN KEY ( OrderID ) REFERENCES Orders ( OrderID ),
	CONSTRAINT FK_OrderStatus_StatusID FOREIGN KEY ( StatusID ) REFERENCES Statuses ( StatusID )
  );
  
DROP TABLE IF EXISTS Stores;
CREATE TABLE Stores
( 
  StoreID				SMALLINT NOT NULL,
  ManagerID				SMALLINT NOT NULL,
  StoreName				CHAR(7) NOT NULL, 
  StreetAddress			VARCHAR(30) NOT NULL,
  Phone					CHAR(12) NOT NULL,
  Email					VARCHAR(25) NOT NULL
						DEFAULT 'in@out.com',
  CONSTRAINT PK_Stores_StoreID PRIMARY KEY ( StoreID ),
  CONSTRAINT FK_Stores_ManagerID FOREIGN KEY ( ManagerID ) REFERENCES Employees ( EmployeeID )
);

DROP TABLE IF EXISTS Shifts;
CREATE TABLE Shifts
( 
  ShiftID				SMALLINT NOT NULL,
  ShiftName				VARCHAR(13) NOT NULL, 
  ShiftStart			CHAR(8) NOT NULL,
  ShiftEnd				CHAR(8) NOT NULL,
  CONSTRAINT PK_Shifts_ShiftID PRIMARY KEY ( ShiftID )
);

DROP TABLE IF EXISTS Schedules;
CREATE TABLE Schedules
( 
  ScheduleID			SMALLINT NOT NULL,
  EmployeeID			SMALLINT NOT NULL,
  ShiftID				SMALLINT NOT NULL,
  StoreID				SMALLINT NOT NULL,
  CONSTRAINT PK_Schedules_ScheduleID PRIMARY KEY ( ScheduleID ),
  CONSTRAINT FK_Schedules_EmployeeId FOREIGN KEY ( EmployeeID ) REFERENCES Employees ( EmployeeID ),
  CONSTRAINT FK_Schedules_ShiftID FOREIGN KEY ( ShiftID ) REFERENCES Shifts ( ShiftID ), 
  CONSTRAINT FK_Schedules_StoreID FOREIGN KEY ( StoreID ) REFERENCES Stores ( StoreID )
);

-- Create the DML and input the theoretical data into database, we used mockaroo

USE InNOut; 

INSERT INTO Customers ( CustomerID, FirstName, LastName, Phone, Email )
VALUES 
( 1, 'Brendis', 'Curl', '973-302-3797', 'bcurl0@guardian.co.uk' ),
( 2, 'Selene', 'McGinlay', '519-471-6117', 'smcginlay1@deliciousdays.com' ),
( 3, 'Grace', 'Meace', '709-341-0535', 'gmeace2@state.gov' ),
( 4, 'Lodovico', 'Eveling', '209-678-5270', 'leveling3@mapy.cz' ),
( 5, 'Fredericka', 'Wreakes', '662-276-7407', 'fwreakes4@twitpic.com' ),
( 6, 'Lorelei', 'Evershed', '694-727-3351', 'levershed5@tripadvisor.com' ),
( 7, 'Verney', 'Palfreman', '702-327-9655', 'vpalfreman6@wikipedia.org' ),
( 8, 'Brigham', 'Erskine Sandys', '749-423-9933', 'berskinesandys7@shutterfly.com' ),
( 9, 'Benjie', 'Attree', '518-589-7823', 'battree8@boston.com' ),
( 10, 'Laurence', 'Banes', '749-885-7698', 'lbanes9@china.com.cn' ),
( 11, 'Emmy', 'Mapston', '564-399-0388', 'emapstona@indiatimes.com' ),
( 12, 'Benedetto', 'Chamberlaine', '436-732-8266', 'bchamberlaineb@dailymail.co.uk' ),
( 13, 'Della', 'Rauprich', '623-266-8787', 'drauprichc@bravesites.com' ),
( 14, 'Tiebout', 'Antonioni', '341-222-2497', 'tantonionid@a8.net' ),
( 15, 'Sheff', 'Hurlston', '135-457-6721', 'shurlstone@eepurl.com' ),
( 16, 'Ivett', 'Killiam', '452-704-6956', 'ikilliamf@wired.com' ),
( 17, 'Miller', 'Asp', '586-839-9399', 'maspg@webnode.com' ),
( 18, 'Maximilien', 'Hember', '828-869-9317', 'mhemberh@zimbio.com' ),
( 19, 'Magdalene', 'Redman', '940-476-7148', 'mredmani@chicagotribune.com' ),
( 20, 'Sela', 'Milne', '109-554-4161', 'smilnej@newsvine.com' );

INSERT INTO Employees ( EmployeeID, FirstName, LastName, Title, HireDate, ManagerID ) 
VALUES 
( 311, 'Amil', 'Arden', 'Manager', '2021-07-09', 311 ), -- 3 managers & 3 cashiers in this DB
( 321, 'Josy', 'Gianneschi', 'Cook', '2021-09-25', 311 ),
( 331, 'Algernon', 'Packman', 'Cook', '2021-03-08', 311 ),
( 341, 'Cissy', 'Records', 'Cashier', '2021-09-02', 311 ),
( 351, 'Nicoli', 'Duffin', 'Dishwasher', '2021-01-22', 311 ),
( 361, 'Myrtice', 'Braganza', 'Dishwasher', '2021-10-10', 311 ),
( 371, 'Nesta', 'Wrefford', 'Manager', '2021-08-25', 371 ),
( 381, 'Meggi', 'Eldin', 'Cook', '2021-07-14', 371 ),
( 391, 'Astrid', 'Olcot', 'Cook', '2020-12-08', 371 ),
( 3101, 'Candis', 'Hamsson', 'Dishwasher', '2021-02-21', 371 ),
( 3111, 'Jenn', 'Abrahams', 'Cashier', '2021-01-17', 371 ),
( 3121, 'Denney', 'Crum', 'Cook', '2021-10-07', 371 ),
( 3131, 'Toinette', 'Rennard', 'Cook', '2021-04-08', 371 ),
( 3141, 'Adolpho', 'Keysel', 'Cashier', '2021-11-27', 371 ),
( 3151, 'Terry', 'Haughan', 'Cook', '2021-01-27', 371 ),
( 3161, 'Giff', 'Stoop', 'Manager', '2021-11-18', 3161 ),
( 3171, 'Veronika', 'Mahy', 'Dishwasher', '2021-09-09', 3161 ),
( 3181, 'Rafi', 'MacGlory', 'Cook', '2021-11-18', 3161 ),
( 3191, 'Rebbecca', 'Rablin', 'Cook', '2021-07-13', 3161 ),
( 3201, 'Erich', 'Joincey', 'Cook', '2021-10-13', 3161 );

INSERT INTO Orders ( OrderID, EmployeeID, CustomerID, OrderDate, OrderTime, OrderType )
VALUES 
( 2120, 3111, 1, '2021-10-28', '11:00:00', 'DI' ), -- all employee ID's used here are those of 'cashier' employees [i.e. EmployeeID: 341, 3111, or 3141]
( 2220, 3141, 2, '2021-11-19', '12:00:00', 'DI' ),
( 2320, 3111, 3, '2021-10-13', '13:00:00', 'DI' ),
( 2420, 341, 4, '2021-11-19', '14:00:00', 'TO' ),
( 2520, 3141, 5, '2021-10-20', '15:00:00', 'DI' ),
( 2620, 3111, 6, '2021-11-23', '15:30:00', 'TO' ),
( 2720, 341, 7, '2021-11-16', '16:00:00', 'DI' ),
( 2820, 3141, 8, '2021-10-12', '16:30:00', 'TO' ),
( 2920, 3111, 9, '2021-10-19', '17:00:00', 'TO' ),
( 21020, 3141, 10, '2021-11-08', '17:30:00', 'TO' ),
( 21120, 3111, 11, '2021-10-18', '18:00:00', 'DI' ),
( 21220, 341, 12, '2021-11-02', '18:30:00', 'DI' ),
( 21320, 3111, 13, '2021-10-17', '19:00:00', 'TO' ),
( 21420, 3141, 14, '2021-10-23', '19:30:00', 'TO' ),
( 21520, 341, 15, '2021-10-26', '20:00:00', 'TO' ),
( 21620, 3111, 16, '2021-11-06', '20:30:00', 'TO' ),
( 21720, 3141, 17, '2021-11-02', '21:00:00', 'DI' ),
( 21820, 3141, 18, '2021-11-20', '22:00:00', 'TO' ),
( 21920, 3111, 19, '2021-11-24', '23:00:00', 'TO' ),
( 22020, 3141, 20, '2021-10-26', '00:00:00', 'TO' );

INSERT INTO MenuItems ( ItemID, ItemName, ItemDescription, ItemPrice )
VALUES  ( 113, 'Fries', 'Hand Cut daily', 1.75 ), 
		( 223, 'Shake', 'Made With Fresh Fruit', 2.50 ), 
		( 333, 'Burger', 'Never Frozen Beef', 3.25 ), 
        ( 443, 'Double-double', 'With Onions?', 4.50 );

INSERT INTO OrderItems ( OrderID, ItemID, Quantity )
VALUES 	( 2120, 113, 5 ), 
		( 2220, 113, 3 ),
        ( 2320, 113, 1 ), 
        ( 2420, 113, 2 ), 
        ( 2520, 113, 6 ), 
        ( 2620, 113, 4 ), 
        ( 2720, 113, 2 ), 
        ( 2820, 113, 3 ), 
        ( 21020, 113, 5 ),  
        ( 21120, 113, 1 ), 
        ( 21320, 113, 4 ), 
        ( 21420, 113, 2 ), 
        ( 21520, 113, 6 ), 
        ( 21620, 113, 3 ), 
        ( 21820, 113, 5 ), 
        ( 21920, 113, 4 ), 
        ( 2520, 223, 2 ), 
        ( 2820, 223, 3 ), 
        ( 2920, 223, 1 ), 
        ( 21220, 223, 2 ), 
        ( 21320, 223, 6 ), 
        ( 21520, 223, 3 ), 
        ( 21620, 223, 4 ), 
        ( 2520, 333, 2 ), 
        ( 2620, 333, 1 ), 
        ( 21220, 333, 2 ), 
        ( 21520, 333, 1 ), 
        ( 21920, 333, 6 ), 
        ( 22020, 333, 3 ),  
        ( 2120, 443, 3 ), 
        ( 2220, 443, 2 ), 
        ( 2320, 443, 2 ), 
        ( 2420, 443, 6 ), 
        ( 2520, 443, 4 ), 
        ( 2620, 443, 9 ), 
        ( 2720, 443, 3 ), 
        ( 2820, 443, 1 ), 
        ( 2920, 443, 1 ), 
        ( 21020, 443, 2 ), 
        ( 21120, 443, 5 ), 
        ( 21220, 443, 6 ), 
        ( 21320, 443, 2 ), 
        ( 21420, 443, 2 ), 
        ( 21520, 443, 2 ), 
        ( 21620, 443, 3 ), 
        ( 21720, 443, 1 ), 
        ( 21820, 443, 2 ), 
		( 21920, 443, 6 ), 
        ( 22020, 443, 4 ); 
        
INSERT INTO Statuses ( StatusID, StatusName, StatusDescription )
VALUES ( 114, 'Placed', 'Order has been placed by customer' ),
       ( 224, 'Delivered', 'Order has been delivered to the customer' ),
       ( 334, 'Complete', 'Customer has confirmed receipt of order delivery & are satisfied' ),
       ( 444, 'Cancelled', 'Order has been cancelled by customer' ),
       ( 554, 'Returned', 'Order has been returned by the customer' );
       
INSERT INTO OrderStatuses ( OrderID, StatusID, StatusInitiation )
VALUES  
( 2120, 114, '2021-05-18' ),
( 2220, 224, '2021-07-20' ),
( 2320, 334, '2021-03-26' ),
( 2420, 444, '2021-12-02' ),
( 2520, 554, '2021-07-12' ),
( 2620, 114, '2021-05-14' ),
( 2720, 224, '2021-07-05' ),
( 2820, 334, '2021-07-19' ),
( 2920, 444, '2021-04-04' ),
( 21020, 554, '2021-02-10' ),
( 21120, 114, '2021-07-16' ),
( 21220, 224, '2021-11-24' ),
( 21320, 334, '2021-01-17' ),
( 21420, 444, '2021-05-23' ),
( 21520, 554, '2021-08-06' ),
( 21620, 114, '2021-11-05' ),
( 21720, 224, '2020-12-22' ),
( 21820, 334, '2021-08-16' ),
( 21920, 444, '2021-01-20' ),
( 22020, 554, '2021-06-10' );

INSERT INTO Stores ( StoreID, ManagerID, StoreName, StreetAddress, Phone, Email )
VALUES  ( 115, 311,  'Store 1', '111 State Street', '973-555-9182', 'in@out.com' ),
		( 225, 371, 'Store 2', '222 West Temple', '801-294-3746', 'in@out.com' ), 
		( 335, 3161, 'Store 3', '333 1100 East', '435-647-3619', 'in@out.com' );
        
INSERT INTO Shifts ( ShiftID, ShiftName, ShiftStart, ShiftEnd )
VALUES  ( 416, 'Monday AM', '10:30:00', '18:00:00' ), 
		( 426, 'Monday PM', '17:30:00', '01:30:00' ), 
		( 436, 'Tuesday AM', '10:30:00', '18:00:00' ), 
        ( 446, 'Tuesday PM', '17:30:00', '10:30:00' ), 
        ( 456, 'Wednesday AM', '10:30:00', '18:00:00' ), 
        ( 466, 'Wednesday PM', '17:30:00', '01:30:00' ), 
        ( 476, 'Thursday AM', '10:30:00', '18:00:00' ), 
		( 486, 'Thursday PM', '17:30:00', '01:30:00' ),
        ( 496, 'Friday AM', '10:30:00', '18:30:00' ), 
        ( 4106, 'Friday PM', '18:00:00', '02:00:00' ),
        ( 4116, 'Saturday AM', '10:30:00', '18:30:00' ), 
        ( 4126, 'Saturday PM', '18:00:00', '02:00:00' ),
        ( 4136, 'Sunday AM', '10:30:00', '18:00:00' ), 
        ( 4146, 'Sunday PM', '17:30', '01:30:00' );
        
INSERT INTO Schedules ( ScheduleID, EmployeeID, ShiftID, StoreID )
VALUES 
( 317, 311, 416, 115 ),
( 327, 321, 426, 115 ), 
( 337, 331, 436, 115 ),
( 347, 341, 446, 115 ),
( 357, 351, 456, 115 ),
( 367, 361, 466, 115 ),
( 377, 371, 476, 115 ),
( 387, 381, 486, 115 ),
( 397, 391, 496, 115 ),
( 3107, 3101, 4106, 225 ),
( 3117, 3111, 4116, 225 ),
( 3127, 3121, 4126, 225 ),
( 3137, 3131, 4136, 225 ),
( 3147, 3141, 4146, 225 ),
( 3157, 3151, 416, 225 ),
( 3167, 3161, 426, 225 ),
( 3177, 3171, 436, 335 ),
( 3187, 3181, 446, 335 ),
( 3197, 3191, 456, 335 ),
( 3207, 3201, 466, 335 );

-- Create queries to answer important business rules 

USE InNOut; 
-- Business Rule 1: Provide information on which employee handles the most orders.

SELECT 
	E.EmployeeID, 
	CONCAT_WS(' ',E.FirstName, E.LastName) AS EmployeeName, 
    COUNT(OrderID) AS OrdersHandled
FROM 
	Employees AS E 
    LEFT JOIN 
	Orders AS O ON O.EmployeeID = E.EmployeeID 
GROUP BY EmployeeID
ORDER BY OrdersHandled DESC;


-- Business Rule 2: Provide the first and last name of managers in their designated store location.
SELECT 
	S.StoreID, 
	S.StreetAddress, 
    E.ManagerID, 
    CONCAT_WS(' ',E.FirstName, E.LastName) AS ManagerName
FROM 
	Stores AS S 
	JOIN 
	Employees AS E ON E.ManagerID = S.ManagerID
WHERE E.EmployeeID = E.ManagerID
ORDER BY StoreID;


-- Business Rule 3: Provide a list of most purchased items.
SELECT 
	OI.ItemID, 
    MI.ItemName, 
    SUM(OI.Quantity) AS TotalQuantity
FROM 
	OrderItems AS OI
	JOIN 
    MenuItems AS MI ON OI.ItemID = MI.ItemID
GROUP BY ItemID
ORDER BY TotalQuantity DESC;


-- Business Rule 4: Provide the total month sales received in the past year.
SELECT 
	O.OrderDate, 
    SUM(OI.Quantity*MI.ItemPrice) AS TotalAmount
FROM 
	OrderItems AS OI
	JOIN 
    MenuItems AS MI ON MI.ItemID = MI.ItemID
	JOIN 
	Orders AS O ON OI.OrderID = O.OrderID 
WHERE OrderDate >= '2019-12-17'
GROUP BY OrderDate WITH ROLLUP;


-- Business Rule 5: Calculate the total purchases amount of each customer.
SELECT 
	C.CustomerID, 
    CONCAT_WS(' ',C.FirstName, C.LastName) AS CustomerName, 
    SUM(OI.Quantity*MI.ItemPrice) AS TotalAmount
FROM 
	Customers AS C 
    INNER JOIN 
	Orders AS O ON O.CustomerID = C.CustomerID 
	JOIN 
    OrderItems AS OI ON OI.OrderID = O.OrderID 
	JOIN
    MenuItems AS MI ON MI.ItemID = MI.ItemID
GROUP BY CustomerID
ORDER BY TotalAmount DESC;


-- VIEW #1
-- Business Rule 6: Calculate revenue made per item per order.

DROP VIEW IF EXISTS RevenuePerItemPerOrder;

CREATE VIEW RevenuePerItemPerOrder AS
SELECT
	OI.OrderID,
	OI.Quantity,
    MI.ItemPrice,
    MI.ItemName,
    SUM(MI.ItemPrice * OI.Quantity) AS 'Revenue Per Item'
FROM
	OrderItems AS OI
    JOIN
    MenuItems AS MI ON MI.ItemID = OI.ItemID    
GROUP BY OI.OrderId, OI.Quantity, MI.ItemPrice, MI.ItemName;

SELECT * FROM RevenuePerItemPerOrder;



----------------------------------------------------------------------------------------------------------------

-- VIEW #2
-- Business Rule 7: Provide a list of employees and their associated managers.

DROP VIEW IF EXISTS EmployeesManager; 

CREATE VIEW EmployeesManager AS
	SELECT 
		E.EmployeeID,
		CONCAT(E.FirstName, ' ', E.LastName) AS 'Employee',
        E.ManagerID AS 'ManagerID',
		S.StreetAddress AS Location
        
	FROM Employees AS E
		LEFT JOIN Stores AS S 	
			ON E.ManagerID = S.ManagerID
        LEFT JOIN Schedules as SC
			ON SC.EmployeeID = E.EmployeeID;
            

SELECT * FROM EmployeesManager;


-----------------------------------------------------------------------------------------------------------------

-- STORED PROCEDURE #1
-- Business Rule 8: Retrieve a customer's phone number to contact when order is ready.

DROP PROCEDURE IF EXISTS GetCustomerPhoneNumber;

delimiter //

CREATE PROCEDURE `GetCustomerPhoneNumber`(IN inCustomerName VARCHAR(25))
BEGIN
	SELECT 
		Phone,
        FirstName
	FROM
		Customers
	WHERE FirstName = inCustomerName;
END//
delimiter ;

CALL GetCustomerPhoneNumber('Grace');

--------------------------------------------------------------------------------
-- STORED PROCEDURE #2
-- Business Rule 9: Retrieve a list of employees working each day


DROP PROCEDURE IF EXISTS TodaysShifts;
delimiter //
CREATE PROCEDURE `TodaysShifts`(IN inShiftName VARCHAR(25))
BEGIN
	SELECT 
    S.ShiftName,
    S.ShiftStart,
    S.ShiftEnd,
    CONCAT(E.FirstName, ' ', E.LastName) AS Employee
FROM 
	Shifts AS S
	JOIN
    Schedules AS SC ON SC.ShiftID = S.ShiftID
    JOIN
	Employees AS E ON E.EmployeeID = SC.EmployeeID
WHERE ShiftName = inShiftName;
        
END//
delimiter ;

CALL TodaysShifts('Monday PM');
CALL TodaysShifts('Tuesday AM');
	

-----------------------------------------------------------------------------------------------------------------------------
-- STORED PROCEDURE #3
-- Business Rule 10: Change and update product prices when necessary.

DROP PROCEDURE IF EXISTS `UpdateItemPrice`;

delimiter //
CREATE PROCEDURE `UpdateItemPrice`(IN inItemID VARCHAR(25), IN inNewPrice DECIMAL(3,2))
BEGIN

	UPDATE MenuItems
    SET ItemPrice = inNewPrice
    WHERE ItemID = inItemID;

END //
delimiter ;


CALL UpdateItemPrice(223, 3.00);
SELECT * FROM MenuItems;













