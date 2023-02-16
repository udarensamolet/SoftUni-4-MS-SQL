--- Problem 16: Create SoftUni Database
CREATE DATABASE [SoftUni]

USE [SoftUni]

CREATE TABLE [Towns] (
	[Id] INT UNIQUE IDENTITY NOT NULL,
	[Name] NVARCHAR(85) NOT NULL
	CONSTRAINT [PK_TownId] PRIMARY KEY ([Id])
)

CREATE TABLE [Addresses] (
	[Id] INT UNIQUE IDENTITY NOT NULL,
	[AddressText] NVARCHAR(MAX) NOT NULL,
	[TownId] INT NOT NULL
	CONSTRAINT [PK_AddressId] PRIMARY KEY ([Id]),
	CONSTRAINT [FK_TownId] FOREIGN KEY ([TownId]) REFERENCES [Towns]([Id])
)

CREATE TABLE [Departments] (
	[Id] INT UNIQUE IDENTITY NOT NULL,
	[Name] NVARCHAR(MAX) NOT NULL
	CONSTRAINT [PK_DepartmentsId] PRIMARY KEY ([Id]),
)

CREATE TABLE [Employees] (
	[Id] INT UNIQUE IDENTITY NOT NULL,
	[FirstName] NVARCHAR(100) NOT NULL,
	[MiddleName] NVARCHAR(100) NOT NULL,
	[LastName] NVARCHAR(100) NOT NULL,
	[JobTitle] NVARCHAR(50) NOT NULL,
	[DepartmentId] INT NOT NULL,
	[HireDate] DATE NOT NULL,
	[Salary] DECIMAL NOT NULL, 
	[AddressId] INT NOT NULL
	CONSTRAINT [PK_EmployeeId] PRIMARY KEY ([Id]),
	CONSTRAINT [FK_DepartmentId] FOREIGN KEY ([DepartmentId]) REFERENCES [Departments]([Id]),
	CONSTRAINT [FK_AddressId] FOREIGN KEY ([AddressId]) REFERENCES [Departments]([Id])
)



--- Problem 17:	Backup Database 
BACKUP DATABASE [SoftUni]
TO DISK = 'c:\back-ups\SoftUni.bak'
   WITH FORMAT,
      MEDIANAME = 'SoftUni',
      NAME = 'Full Backup of SoftUni'

use [master]

drop database [SoftUni]



--- Problem 18:	Basic Insert 
USE [SoftUni]

INSERT INTO [Towns]([Name]) VALUES
	('Sofia'),
	('Plovdiv'),
	('Varna'),
	('Burgas')

INSERT INTO [Departments]([Name]) VALUES
	('Engineering'),
	('Sales'),
	('Marketing'),
	('Software Development'),
	('Quality Assurance')

ALTER TABLE [Employees] 
ALTER COLUMN [AddressId] INT NULL

INSERT INTO [Employees]([FirstName], [MiddleName], [LastName], [JobTitle], [DepartmentId], [HireDate], [Salary], [AddressId]) VALUES
	('Ivan', 'Ivanov', 'Ivanov', '.NET Developer', 4, '2013-02-01', 3500.00, null),
	('Petar', 'Petrov', 'Petrov', 'Senior Engineer', 1, '2004-03-02', 4000.00, null),
	('Maria', 'Petrova', 'Ivanova', 'Intern', 5, '2016-08-28', 525.25, null),
	('Georgi', 'Terziev', 'Ivanov', 'CEO', 2, '2007-12-09', 3000.00, null),
	('Peter', 'Pan', 'Pan', 'Intern', 3, '2016-08-28', 599.88, null)



--- Problem 19:	Basic Select All Fields 
SELECT * FROM [Towns]
SELECT * FROM [Departments]
SELECT * FROM [Employees]



--- Problem 20:	Basic Select All Fields and Order Them 
SELECT * FROM [Towns]
ORDER BY [Name] 
SELECT *FROM [Departments]
ORDER BY [Name]
SELECT * FROM [Employees]
ORDER BY [Salary] DESC



--- Problem 21:	Basic Select Some Fields 
SELECT [Name] FROM [Towns]
ORDER BY [Name] 
SELECT [Name] FROM [Departments]
ORDER BY [Name]
SELECT [FirstName], [LastName], [JobTitle], [Salary] FROM [Employees]
ORDER BY [Salary] DESC



--- Problem 22:	Increase Employees Salary 
UPDATE [Employees]
SET [Salary] = [Salary] * 1.10
SELECT [Salary] FROM [Employees]
