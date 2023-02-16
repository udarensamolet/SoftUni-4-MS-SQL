--- Problem 15: Hotel Database 
CREATE DATABASE [Hotel]

USE [Hotel]

CREATE TABLE [Employees] (
	[Id] INT UNIQUE NOT NULL,
	[FirstName] NVARCHAR(25) NOT NULL,
	[LastName] NVARCHAR(25) NOT NULL,
	[Title] NVARCHAR(4) NOT NULL,
	[Notes] NVARCHAR(MAX)
	CONSTRAINT PK_EmployeesId PRIMARY KEY (Id)
)

CREATE TABLE [Customers] (
	[AccountNumber] INT UNIQUE NOT NULL,
	[FirstName] NVARCHAR(25) NOT NULL,
	[LastName] NVARCHAR(25) NOT NULL,
	[PhoneNumber] BIGINT NOT NULL,
	[EmergencyName] NVARCHAR(50) NOT NULL,
	[EmergencyNumber] BIGINT NOT NULL,
	[Notes] NVARCHAR(MAX) NOT NULL
	CONSTRAINT PK_CustomersId PRIMARY KEY (AccountNumber)
)

CREATE TABLE [RoomStatus] (
	[RoomStatus] NVARCHAR(25) UNIQUE NOT NULL,
	[Notes] NVARCHAR(MAX)
	CONSTRAINT PK_RoomStatusId PRIMARY KEY (RoomStatus)
)

CREATE TABLE [RoomTypes] (
	[RoomType] NVARCHAR(30) UNIQUE NOT NULL,
	[Notes] NVARCHAR(MAX)
	CONSTRAINT PK_RoomTypeId PRIMARY KEY (RoomType)
)

CREATE TABLE [BedTypes] (
	[BedType] TINYINT UNIQUE NOT NULL,
	[Notes] NVARCHAR(MAX)
	CONSTRAINT PK_BedTypeId PRIMARY KEY (BedType)
)

CREATE TABLE [Rooms] (
	[RoomNumber] SMALLINT UNIQUE NOT NULL,
	[RoomType] NVARCHAR(30) NOT NULL,
	[BedType] TINYINT NOT NULL,
	[Rate] FLOAT NOT NULL,
	[RoomStatus] NVARCHAR(25) NOT NULL,
	[Notes] NVARCHAR(MAX)
	CONSTRAINT PK_RoomId PRIMARY KEY (RoomNumber)
	CONSTRAINT FK_RoomTypeId FOREIGN KEY (RoomType) REFERENCES [RoomTypes]([RoomType]),
	CONSTRAINT FK_BedTypeId FOREIGN KEY (BedType) REFERENCES [BedTypes]([BedType]),
	CONSTRAINT FK_RoomStatusId FOREIGN KEY (RoomStatus) REFERENCES [RoomStatus]([RoomStatus])
)

CREATE TABLE [Payments] (
	[Id] INT UNIQUE NOT NULL,
	[EmployeeId] INT UNIQUE NOT NULL,
	[PaymentDate] DATE NOT NULL,
	[AccountNumber] INT NOT NULL,
	[FirsDateOccupied] DATE NOT NULL,
	[LastDateOccupied] DATE NOT NULL,
	[TotalDays] SMALLINT NOT NULL,
	[AmountCharged] DECIMAL NOT NULL,
	[TaxRate] DECIMAL NOT NULL,
	[TaxAmount] DECIMAL NOT NULL,
	[PaymentTotal] DECIMAL NOT NULL,
	[Notes] NVARCHAR(MAX)
	CONSTRAINT PK_PaymentId PRIMARY KEY (Id),
	CONSTRAINT FK_EmployeeId FOREIGN KEY (EmployeeId) REFERENCES [Employees]([Id]),
	CONSTRAINT FK_AccountNumberId FOREIGN KEY (AccountNumber) REFERENCES [Customers]([AccountNumber])
)

CREATE TABLE [Occupancies] (
	[Id] INT UNIQUE NOT NULL,
	[EmployeeId] INT NOT NULL,
	[DateOccupied] DATE NOT NULL,
	[AccountNumber] INT NOT NULL,
	[RoomNumber] SMALLINT NOT NULL,
	[RateApplied] FLOAT NOT NULL,
	[PhoneCharge] FLOAT NOT NULL,
	[Notes] NVARCHAR(25) NOT NULL,
	CONSTRAINT PK_OccupancyId PRIMARY KEY (Id),
	CONSTRAINT FK_Employee FOREIGN KEY (EmployeeId) REFERENCES [Employees]([Id]),
	CONSTRAINT FK_AccountNumber FOREIGN KEY (AccountNumber) REFERENCES [Customers]([AccountNumber]),
	CONSTRAINT FK_RoomNumber FOREIGN KEY (RoomNumber) REFERENCES [Rooms]([RoomNumber])
)

INSERT INTO [Employees] ([Id], [FirstName], [LastName], [Title], Notes) VALUES
	(1, 'Rositsa', 'Nenova', 'Miss', NULL),
	(2, 'Rositsa', 'Nenova', 'Miss', NULL),
	(3, 'Rositsa', 'Nenova', 'Miss', NULL)

INSERT INTO [Customers] ([AccountNumber], [FirstName], [LastName], [PhoneNumber], [EmergencyName], [EmergencyNumber], [Notes]) VALUES
	(123, 'Rositsa', 'Nenova', 0882345678, 'Viktor Dragomirov', 08823456789, 'ok'),
	(124, 'Rositsa', 'Nenova', 0882345678, 'Viktor Dragomirov', 08823456789, 'ok'),
	(125, 'Rositsa', 'Nenova', 0882345678, 'Viktor Dragomirov', 08823456789, 'ok')

INSERT INTO [RoomStatus] ([RoomStatus], [Notes]) VALUES
	('Being cleaned', NULL),
	('Ready', NULL),
	('Occupied', NULL)

INSERT INTO [RoomTypes] ([RoomType], [Notes]) VALUES
	('Double', NULL),
	('Triple', NULL),
	('Apartment', NULL)

INSERT INTO [BedTypes] ([BedType], [Notes]) VALUES
	(1, NULL),
	(2, NULL),
	(3, NULL)

INSERT INTO [Rooms] ([RoomNumber], [RoomType], [BedType], [Rate], [RoomStatus], [Notes]) VALUES
	(101, 'Double', 1, 5.69, 'Occupied', NULL),
	(102, 'Triple', 3, 8.79, 'Ready', NULL),
	(103, 'Apartment', 2, 9.59, 'Being cleaned', NULL)

INSERT INTO [Payments] ([Id], [EmployeeId], [PaymentDate], [AccountNumber], [FirsDateOccupied], [LastDateOccupied], [TotalDays], 
			[AmountCharged], [TaxRate], [TaxAmount], [PaymentTotal], [Notes]) VALUES
	(159, 1, '2021-10-09', 123, '2021-10-01', '2021-10-09', 9, 133.33, 20.00, 26.66, 159.99, NULL),
	(357, 2, '2021-10-09', 124, '2021-10-01', '2021-10-09', 9, 133.33, 20.00, 26.66, 159.99, NULL),
	(852, 3, '2021-10-09', 125, '2021-10-01', '2021-10-09', 9, 133.33, 20.00, 26.66, 159.99, NULL)

INSERT INTO [Occupancies] ([Id], [EmployeeId], [DateOccupied], [AccountNumber], [RoomNumber], [RateApplied], [PhoneCharge], [Notes]) VALUES
	(789, 1, '2021-10-01', 123, 101, 5.69, 1.59, 'blah'),
	(456, 2, '2021-10-01', 124, 102, 3.89, 1.47, 'blah'),
	(123, 3, '2021-10-01', 125, 103, 1.59, 5.98, 'blah')

USE [Hotel]



--- Problem 23:	Decrease Tax Rate 
UPDATE [Payments]
SET [TaxRate] = [TaxRate] / 1.03
SELECT [TaxRate] from [Payments]



--- Problem 24: Delete All Records
TRUNCATE TABLE [Occupancies]