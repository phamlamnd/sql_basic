CREATE DATABASE LAMPV2

CREATE TABLE Product
(
	ProductId NVARCHAR(50) PRIMARY KEY,
	ProductName NVARCHAR(50),
	CategoryId NVARCHAR(50),
	SupplierId NVARCHAR(50),
	UnitPrice FLOAT,
	Discontinued BIT

	FOREIGN KEY(CategoryId) REFERENCES Category(CategoryId),
	FOREIGN KEY(SupplierId) REFERENCES Supplier(SupplierId)
)

DROP TABLE Product

CREATE TABLE Category
(
	CategoryId NVARCHAR(50) PRIMARY KEY,
	CategoryName NVARCHAR(50)
)

DROP TABLE Category

CREATE TABLE Supplier
(
	SupplierId NVARCHAR(50) PRIMARY KEY,
	SupplierName NVARCHAR(50)
)

DROP TABLE Supplier
insert into Category values (1, N'Tivi')
insert into Category values (2, N'ĐIỆN THOẠI')
insert into Category values (3, N'LAPTOP')

insert into Supplier values (1, N'LG')
insert into Supplier values (2, N'LENOVO')
insert into Supplier values (3, N'SAMSUNG')

insert into Product values (1,N'Tivi s630',1,1, 8000000,1)
Insert into Product values (2,N'LAPTOP G40',3,2, 14000000,1)
Insert into Product values (3,N'SS G S5',2,3, 15000000,0)
Insert into Product values (4,N'LG X',1,2, 15000000,0)

SELECT * FROM Product order by UnitPrice desc
