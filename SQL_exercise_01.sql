--https://github.com/XD-DENG/SQL-exercise/tree/master/SQL_exercise_01
CREATE DATABASE SQL_exercise_01
GO

USE SQL_exercise_01
GO

CREATE TABLE Manufactures
(
	Manufactures_Code INT PRIMARY KEY IDENTITY,
	Manufactures_Name NVARCHAR(50) NOT NULL UNIQUE 
)

CREATE TABLE Products
(
	Products_Code INT PRIMARY KEY IDENTITY,
	Products_Name NVARCHAR(50) NOT NULL,
	Products_Price DECIMAL(10,2) NOT NULL,
	Manufactures_Code INT FOREIGN KEY(Manufactures_Code) REFERENCES Manufactures(Manufactures_Code)
)

INSERT INTO Manufactures VALUES('Sony');
INSERT INTO Manufactures VALUES('Creative Labs');
INSERT INTO Manufactures VALUES('Hewlett-Packard');
INSERT INTO Manufactures VALUES('Iomega');
INSERT INTO Manufactures VALUES('Fujitsu')
INSERT INTO Manufactures VALUES('Winchester')

INSERT INTO Products VALUES('Hard drive',240,5)
INSERT INTO Products VALUES('Memory',120,6)
INSERT INTO Products VALUES('ZIP drive',150,4)
INSERT INTO Products VALUES('Floppy disk',5,6)
INSERT INTO Products VALUES('Monitor',240,1)
INSERT INTO Products VALUES('DVD drive',180,2)
INSERT INTO Products VALUES('CD drive',90,2)
INSERT INTO Products VALUES('Printer',270,3)
INSERT INTO Products VALUES('Toner cartridge',66,3)
INSERT INTO Products VALUES('DVD burner',180,2)

-- 1.1 Select the names of all the products in the store.
SELECT Products.Products_Name FROM Products

-- 1.2 Select the names and the prices of all the products in the store.
SELECT Products.Products_Name, Products.Products_Price FROM Products

-- 1.3 Select the name of the products with a price less than or equal to $200.
SELECT Products.Products_Name FROM Products
WHERE Products.Products_Price <= 200

-- 1.4 Select all the products with a price between $60 and $120.
SELECT * FROM Products
WHERE Products.Products_Price BETWEEN 60 AND 120

-- 1.5 Select the name and price in cents (i.e., the price must be multiplied by 100).
-- 1.6 Compute the average price of all the products.
SELECT AVG(Products.Products_Price) FROM Products

-- 1.7 Compute the average price of all products with manufacturer code equal to 2.
SELECT AVG(Products.Products_Price) FROM Products
WHERE Products.Manufactures_Code = 2

-- 1.8 Compute the number of products with a price larger than or equal to $180.
SELECT COUNT(Products.Products_Code) FROM Products
WHERE Products.Products_Price >= 180


-- 1.9 Select the name and price of all products with a price larger than or equal to $180, 
--and sort first by price (in descending order), and then by name (in ascending order).
SELECT Products.Products_Name, Products.Products_Price FROM Products
WHERE Products.Products_Price >= 180
ORDER BY Products.Products_Price DESC, Products.Products_Name

-- 1.10 Select all the data from the products, including all the data for each product's manufacturer.
SELECT * FROM Products, Manufactures
WHERE Products.Manufactures_Code = Manufactures.Manufactures_Code

SELECT * FROM Products INNER JOIN Manufactures
ON Products.Manufactures_Code = Manufactures.Manufactures_Code

-- 1.11 Select the product name, price, and manufacturer name of all the products.
SELECT P.Products_Name, P.Products_Price, M.Manufactures_Name FROM Products P INNER JOIN Manufactures M
ON P.Manufactures_Code = M.Manufactures_Code

SELECT Products.Products_Name,Products.Products_Price,Manufactures.Manufactures_Name FROM Products,Manufactures
WHERE Products.Manufactures_Code = Manufactures.Manufactures_Code

-- 1.12 Select the average price of each manufacturer's products, showing only the manufacturer's code.
SELECT Products.Manufactures_Code, AVG(Products.Products_Price) AS 'Average price' FROM Products
GROUP BY Products.Manufactures_Code

-- 1.13 Select the average price of each manufacturer's products, showing the manufacturer's name.
SELECT Manufactures.Manufactures_Name, AVG(Products.Products_Price) FROM Products INNER JOIN Manufactures
ON Products.Manufactures_Code = Manufactures.Manufactures_Code
GROUP BY Manufactures.Manufactures_Name

-- 1.14 Select the names of manufacturer whose products have an average price larger than or equal to $150.
SELECT Manufactures.Manufactures_Name, AVG(Products.Products_Price) FROM Products INNER JOIN Manufactures
ON Products.Manufactures_Code = Manufactures.Manufactures_Code
GROUP BY Manufactures.Manufactures_Name
HAVING AVG(Products.Products_Price) >= 150

-- 1.15 Select the name and price of the cheapest product.
SELECT TOP 1 WITH TIES Products.Products_Name, Products.Products_Price FROM Products
ORDER BY Products.Products_Price ASC

SELECT Products.Products_Name, Products.Products_Price FROM Products
WHERE Products.Products_Price =(
SELECT MIN(Products.Products_Price) FROM Products)

-- 1.16 Select the name of each manufacturer along with the name and price of its most expensive product.
SELECT Products.Products_Name, Products.Products_Price,Manufactures.Manufactures_Name FROM Products INNER JOIN Manufactures
ON Products.Manufactures_Code= Manufactures.Manufactures_Code
WHERE Products.Products_Price =(
SELECT MAX(Products.Products_Price) FROM Products)


-- 1.17 Add a new product: Loudspeakers, $70, manufacturer 2.
INSERT INTO Products(Products_Name,Products_Price,Manufactures_Code) VALUES('Loudspeakers',70,2)

-- 1.18 Update the name of product 8 to "Laser Printer".
UPDATE Products SET Products_Name = 'Laser Printer' WHERE Products_Code = 8

-- 1.19 Apply a 10% discount to all products.
UPDATE Products SET Products_Price = Products_Price*0.9

-- 1.20 Apply a 10% discount to all products with a price larger than or equal to $120.
UPDATE Products SET Products_Price = Products_Price*0.9
WHERE Products_Price >= 120