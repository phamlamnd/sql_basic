CREATE DATABASE BasicTech_SQL_FinalTest_LamPV2
GO

USE BasicTech_SQL_FinalTest_LamPV2
GO

CREATE TABLE Department
(
	DepartmentID INT PRIMARY KEY IDENTITY,
	DepartmentName NVARCHAR(50) NOT NULL,
)

CREATE TABLE Vendor
(
	VendorID INT PRIMARY KEY IDENTITY,
	VendorName NVARCHAR(50) NOT NULL UNIQUE,
	Phone NVARCHAR(50) NOT NULL UNIQUE,
	Website NVARCHAR(50)
)

CREATE TABLE Product
(
	ProductID INT PRIMARY KEY IDENTITY,
	ProductName NVARCHAR(50) NOT NULL,
	DepartmentID INT FOREIGN KEY(DepartmentID) REFERENCES Department(DepartmentID),
	VendorID INT FOREIGN KEY (VendorID) REFERENCES Vendor(VendorID),
	Description_ NVARCHAR(50),
	RetailPrice DECIMAL(10,2) NOT NULL,
	WholeSalePrice DECIMAL(10,2) NOT NULL
)

CREATE TABLE Employee
(
	SSN CHAR(9) PRIMARY KEY,
	DepartmentID INT FOREIGN KEY(DepartmentID) REFERENCES Department(DepartmentID),
	ManagerID CHAR(9) FOREIGN KEY(SSN) REFERENCES Employee(SSN),
	FirstName NVARCHAR(50) NOT NULL,
	LastName NVARCHAR(50) NOT NULL,
	BirthDate DATE NOT NULL,
	HireDate DATE NOT NULL CHECK(HireDate < GETDATE()),
	HourlyWage DECIMAL(10,2) NOT NULL
)


CREATE TABLE Timesheet
(
	TimesheetID INT PRIMARY KEY IDENTITY,
	SSN CHAR(9) FOREIGN KEY(SSN) REFERENCES Employee(SSN),
	PayrollDate DATE NOT NULL,
	WorkingHours DECIMAL(10,2) NOT NULL
)

INSERT INTO Department VALUES(N'Sản xuất')
INSERT INTO Department VALUES(N'Nghiên cứu')
INSERT INTO Department VALUES(N'Chế tạo')
INSERT INTO Department VALUES(N'Phân tích')

INSERT INTO Vendor(VendorName, Phone) VALUES(N'Sam Sung', '0123456780')
INSERT INTO Vendor(VendorName, Phone) VALUES(N'Nokia', '0123456781')
INSERT INTO Vendor(VendorName, Phone) VALUES(N'Viettel', '0123456782')
INSERT INTO Vendor(VendorName, Phone) VALUES(N'FPT', '0123456783')
INSERT INTO Vendor(VendorName, Phone) VALUES(N'Google', '0123456784')
INSERT INTO Vendor(VendorName, Phone) VALUES(N'Microsoft', '0123456785')
INSERT INTO Vendor(VendorName, Phone) VALUES(N'Apple', '0123456786')
INSERT INTO Vendor(VendorName, Phone) VALUES(N'Mobiphone', '0123456787')
INSERT INTO Vendor(VendorName, Phone) VALUES(N'Foxconn', '0123456788')
INSERT INTO Vendor(VendorName, Phone) VALUES(N'LG', '0123456789')

INSERT INTO Product(ProductName,DepartmentID,VendorID,RetailPrice,WholeSalePrice) VALUES(N'Màn hình', 1, 1, 80, 85)
INSERT INTO Product(ProductName,DepartmentID,VendorID,RetailPrice,WholeSalePrice) VALUES(N'Tai nghe', 1, 1, 89, 100)
INSERT INTO Product(ProductName,DepartmentID,VendorID,RetailPrice,WholeSalePrice) VALUES(N'Camera', 2, 2, 70, 75)
INSERT INTO Product(ProductName,DepartmentID,VendorID,RetailPrice,WholeSalePrice) VALUES(N'Dây sạc', 3, 3, 10, 15)
INSERT INTO Product(ProductName,DepartmentID,VendorID,RetailPrice,WholeSalePrice) VALUES(N'Bộ nhớ RAM', 2, 4, 15, 20)
INSERT INTO Product(ProductName,DepartmentID,VendorID,RetailPrice,WholeSalePrice) VALUES(N'Bo mạch', 4, 5, 102, 105)
INSERT INTO Product(ProductName,DepartmentID,VendorID,RetailPrice,WholeSalePrice) VALUES(N'Vỏ', 1, 1, 30, 35)
INSERT INTO Product(ProductName,DepartmentID,VendorID,RetailPrice,WholeSalePrice) VALUES(N'Phần mềm Test', 2, 5, 40, 45)
INSERT INTO Product(ProductName,DepartmentID,VendorID,RetailPrice,WholeSalePrice) VALUES(N'Phần mềm OS', 3, 6, 50, 55)
INSERT INTO Product(ProductName,DepartmentID,VendorID,RetailPrice,WholeSalePrice) VALUES(N'Phần mềm diệt virus', 2, 7, 80, 85)


INSERT INTO Employee VALUES('000000001',1,NULL,N'Phạm Văn',N'Lâm','1990-09-29','2006-08-23',100)
INSERT INTO Employee VALUES('000000002',2,'000000001',N'Trần Văn',N'Bằng','1996-01-29','2006-08-23',100)
INSERT INTO Employee VALUES('000000003',3,'000000001',N'Ngô Văn',N'Thuấn','1996-02-29','2006-08-23',100)
INSERT INTO Employee VALUES('000000004',4,'000000001',N'Hoàng Văn',N'Anh','1997-03-29','2006-08-23',100)
INSERT INTO Employee VALUES('000000005',1,'000000002',N'Đỗ Văn',N'Nam','1991-04-29','2006-08-23',100)
INSERT INTO Employee VALUES('000000006',2,'000000002',N'Lưu Văn',N'Đoàn','1992-04-29','2006-08-23',90)
INSERT INTO Employee VALUES('000000007',3,'000000002',N'Nguyễn Văn',N'Hà','1993-04-29','2006-08-23',100)
INSERT INTO Employee VALUES('000000008',4,'000000003',N'Bùi Văn',N'Hùng','1994-06-29','2006-08-23',120)
INSERT INTO Employee VALUES('000000009',1,'000000005',N'Phạm Văn',N'Hào','1995-07-29','2006-08-23',100)
INSERT INTO Employee VALUES('000000010',1,'000000005',N'Nguyễn Văn',N'Trưởng','1990-08-29','2006-08-23',130)


INSERT INTO Timesheet VALUES('000000001', '2006-1-23',2)
INSERT INTO Timesheet VALUES('000000002', '2006-2-24',3)
INSERT INTO Timesheet VALUES('000000003', '2006-3-25',2)
INSERT INTO Timesheet VALUES('000000004', '2006-3-23',3)
INSERT INTO Timesheet VALUES('000000005', '2006-4-23',2)
INSERT INTO Timesheet VALUES('000000006', '2006-4-23',4)
INSERT INTO Timesheet VALUES('000000007', '2006-6-23',1)
INSERT INTO Timesheet VALUES('000000008', '2006-7-23',1)
INSERT INTO Timesheet VALUES('000000009', '2006-8-23',1)
INSERT INTO Timesheet VALUES('000000010', '2006-8-23',1)



--Q2:Writes a query to list out all employee who has HourlyWage less than Hourlywage average,
--showing FirstName, LastName, SSN and HourlyWage
SELECT E.FirstName, E.LastName, E.SSN, E.HourlyWage FROM Employee E
WHERE E.HourlyWage >
(SELECT AVG(E.HourlyWage) FROM Employee E)



--Q3:Specify the departments which have >= 3 employees
SELECT D.DepartmentName FROM Department D
WHERE D.DepartmentID IN(
SELECT E.DepartmentID FROM Employee E
GROUP BY E.DepartmentID
HAVING COUNT(E.SSN) >= 3)


--Q4:Print out total working hours for each month of 2006. Sort the result descending base on month
SELECT MONTH(T.PayrollDate) AS 'Month', SUM(T.WorkingHours) AS 'Total working hours' FROM Timesheet T
WHERE YEAR(T.PayrollDate) = 2006
GROUP BY MONTH(T.PayrollDate)
ORDER BY SUM(T.WorkingHours) DESC


--Q5: Delete managers who has HourlyWage more than 100
--Trước tiên xóa những người quản lý có Hourlywage > 100 trong bảng Timesheet có chứa mã số trong bảng Employee
DELETE FROM Timesheet
WHERE Timesheet.SSN IN(
SELECT E.SSN FROM Employee E INNER JOIN Timesheet T
ON (E.SSN = Timesheet.SSN AND E.ManagerID = T.SSN)
WHERE E.HourlyWage > 100)
--Sau đó mới xóa được những người quản lý có Hourlywage > 100 trong bảng Employee 
DELETE FROM Employee 
WHERE (Employee.HourlyWage > 100) AND Employee.SSN IN
(SELECT E.ManagerID FROM Employee E)
