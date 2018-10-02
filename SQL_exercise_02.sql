CREATE DATABASE SQL_exercise_02
GO

USE SQL_exercise_02
GO

CREATE TABLE Departments
(
	Code INT PRIMARY KEY,
	Name NVARCHAR(50) NOT NULL UNIQUE,
	Budget DECIMAL(10,2) NOT NULL
)

CREATE TABLE Employees
(
	SSN INT PRIMARY KEY NOT NULL,
	Name NVARCHAR(50) NOT NULL,
	LastName NVARCHAR(50) NOT NULL,
	Department INT NOT NULL FOREIGN KEY(Department) REFERENCES Departments(Code)
)

INSERT INTO Departments(Code,Name,Budget) VALUES(14,'IT',65000);
INSERT INTO Departments(Code,Name,Budget) VALUES(37,'Accounting',15000);
INSERT INTO Departments(Code,Name,Budget) VALUES(59,'Human Resources',240000);
INSERT INTO Departments(Code,Name,Budget) VALUES(77,'Research',55000);

INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('123234877','Michael','Rogers',14);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('152934485','Anand','Manikutty',14);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('222364883','Carol','Smith',37);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('326587417','Joe','Stevens',37);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('332154719','Mary-Anne','Foster',14);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('332569843','George','ODonnell',77);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('546523478','John','Doe',59);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('631231482','David','Smith',77);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('654873219','Zacary','Efron',59);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('745685214','Eric','Goldsmith',59);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('845657245','Elizabeth','Doe',14);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('845657246','Kumar','Swamy',14);

-- LINK : https://en.wikibooks.org/wiki/SQL_Exercises/Employee_management
-- 2.1 Select the last name of all employees.
SELECT LastName FROM Employees

-- 2.2 Select the last name of all employees, without duplicates.
SELECT DISTINCT LastName FROM Employees

-- 2.3 Select all the data of employees whose last name is "Smith".
SELECT * FROM Employees
WHERE LastName = 'Smith'

-- 2.4 Select all the data of employees whose last name is "Smith" or "Doe".
SELECT * FROM Employees
WHERE LastName = 'Smith' OR LastName = 'Doe'

-- 2.5 Select all the data of employees that work in department 14.
SELECT * FROM Employees
WHERE Department = 14

-- 2.6 Select all the data of employees that work in department 37 or department 77.
SELECT * FROM Employees
WHERE Department = 37 OR Department = 77

SELECT * FROM Employees
WHERE Department IN (37,77)


-- 2.7 Select all the data of employees whose last name begins with an "S".
SELECT * FROM Employees
WHERE LastName LIKE 'S%'


-- 2.8 Select the sum of all the departments' budgets.
SELECT SUM(Budget) FROM Departments


-- 2.9 Select the number of employees in each department (you only need to show the department code and the number of employees).
SELECT Department, COUNT(*) FROM Employees
GROUP BY Department

-- 2.10 Select all the data of employees, including each employee's department's data.
SELECT E.Name, E.LastName, E.SSN, E.Department, D.Name, D.Budget FROM Employees E INNER JOIN Departments D
ON E.Department = D.Code


-- 2.11 Select the name and last name of each employee, along with the name and budget of the employee's department.
SELECT E.Name, E.LastName, D.Name AS 'Department', D.Budget FROM Employees E INNER JOIN Departments D
ON E.Department = D.Code


-- 2.12 Select the name and last name of employees working for departments with a budget greater than $60,000.
SELECT E.Name, E.LastName FROM Employees E INNER JOIN Departments D
ON E.Department = D.Code
AND D.Budget > 60000

SELECT Name, LastName FROM Employees
WHERE Department IN(
SELECT Code FROM Departments WHERE Budget > 60000)

-- 2.13 Select the departments with a budget larger than the average budget of all the departments.
SELECT * FROM Departments
WHERE Budget >
(SELECT AVG(Budget) FROM Departments)



-- 2.14 Select the names of departments with more than two employees.

SELECT Name FROM Departments
WHERE Code IN(
SELECT Department FROM Employees
GROUP BY Department
HAVING COUNT(*) > 2)

SELECT D.Name FROM Employees E INNER JOIN Departments D
ON E.Department = D.Code
GROUP BY D.Name
HAVING COUNT(*) > 2

-- 2.15 Very Important - Select the name and last name of employees working for departments with second lowest budget.
SELECT Name, LastName FROM Employees
WHERE Department =(
SELECT TOP 1 T.Code FROM(
SELECT TOP 2 * FROM Departments
ORDER BY Budget ASC) AS T
ORDER BY T.Budget DESC)

SELECT Name, LastName 
FROM Employees 
WHERE Department IN (
  SELECT Code 
  FROM Departments 
  WHERE Budget = (
    SELECT TOP 1 Budget 
    FROM Departments 
    WHERE Budget IN (
      SELECT DISTINCT TOP 2 Budget 
      FROM Departments 
     ORDER BY Budget ASC
    ) 
    ORDER BY Budget DESC
  )
)

-- 2.16  Add a new department called "Quality Assurance", with a budget of $40,000 and departmental code 11. 
INSERT INTO Departments(Code, Name, Budget) VALUES(11, 'Quality Assurance', 40000)

-- And Add an employee called "Mary Moore" in that department, with SSN 847-21-9811.
INSERT INTO Employees(SSN, Name, LastName, Department) VALUES('847219811', 'Mary', 'Moore', 11)

-- 2.17 Reduce the budget of all departments by 10%.
UPDATE Departments SET Budget = Budget *0.9

-- 2.18 Reassign all employees from the Research department (code 77) to the IT department (code 14).
UPDATE Employees SET Department = 14 WHERE Department = 77

-- 2.19 Delete from the table all employees in the IT department (code 14).
DELETE FROM Employees WHERE Department = 14


-- 2.20 Delete from the table all employees who work in departments with a budget greater than or equal to $60,000.
DELETE FROM Employees WHERE Department IN (SELECT Code FROM Departments WHERE Budget > 60000)

-- 2.21 Delete from the table all employees.
DELETE FROM Employees
