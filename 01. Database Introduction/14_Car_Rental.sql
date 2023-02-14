--- Problem 14: Car Rental Database ---

CREATE DATABASE [CarRental]

USE [CarRental]

CREATE TABLE [Categories] (
	[Id] INT UNIQUE NOT NULL,
	[CategoryName] NVARCHAR(25) NOT NULL,
	[DailyRate] FLOAT NOT NULL,
	[WeeklyRate] FLOAT NOT NULL,
	[MonthlyRate] FLOAT NOT NULL,
	[WeekendRate] FLOAT NOT NULL
	CONSTRAINT PK_CategoriesId PRIMARY KEY (Id)	
)

CREATE TABLE [Cars] (
	[Id] INT UNIQUE NOT NULL,
	[PlateNumber] NVARCHAR(10) NOT NULL,
	[Manufacturer] NVARCHAR(25) NOT NULL,
	[Model] NVARCHAR(25) NOT NULL,
	[CarYear] INT NOT NULL,
	[CategoryId] INT NOT NULL,
	[Doors] TINYINT NOT NULL,
	[Picture] VARBINARY(MAX) NOT NULL,
	[Condition] NVARCHAR(MAX) NOT NULL,
	[Available] BIT NOT NULL
	CONSTRAINT PK_CarsId PRIMARY KEY (Id),
	CONSTRAINT FK_CategoryId FOREIGN KEY (CategoryId) REFERENCES [Categories]([Id])
)

CREATE TABLE [Employees] (
	[Id] INT UNIQUE NOT NULL,
	[FirstName] NVARCHAR(MAX) NOT NULL,
	[LastName] NVARCHAR(MAX) NOT NULL,
	[Title] NVARCHAR(5) NOT NULL,
	[Notes] NVARCHAR(MAX)
	CONSTRAINT PK_EmployeesId PRIMARY KEY (Id)
)

CREATE TABLE [Customers] (
	[Id] INT UNIQUE NOT NULL,
	[DriversLicenceNumber] BIGINT NOT NULL,
	[FullName] NVARCHAR(MAX) NOT NULL,
	[Address] NVARCHAR(MAX) NOT NULL,
	[City] NVARCHAR(MAX) NOT NULL,
	[ZIPCode] INT NOT NULL,
	[Notes] NVARCHAR(MAX)
	CONSTRAINT PK_CustomersId PRIMARY KEY (Id)
)

CREATE TABLE [RentalOrders] (
	[Id] INT UNIQUE IDENTITY NOT NULL,
	[EmployeeId] INT NOT NULL,
	[CustomerId] INT NOT NULL,
	[CarId] INT NOT NULL,
	[TankLevel] TINYINT NOT NULL,
	[KilometrageStart] INT NOT NULL,
	[KilometrageEnd] INT NOT NULL,
	[TotalKilometrage] INT NOT NULL,
	[StartDate] DATE NOT NULL,
	[EndDate] DATE NOT NULL,
	[TotalDays] INT NOT NULL,
	[RateApplied] FLOAT NOT NULL,
	[TaxRate] FLOAT NOT NULL,
	[OrderStatus] NVARCHAR(10) NOT NULL,
	[Notes] NVARCHAR(MAX)
	CONSTRAINT PK_RentalOrderId PRIMARY KEY (Id)
	CONSTRAINT FK_EmployeeId FOREIGN KEY (EmployeeId) REFERENCES [Employees]([Id]),
	CONSTRAINT FK_CustomerId FOREIGN KEY (CustomerId) REFERENCES [Customers]([Id]),
	CONSTRAINT FK_CarId FOREIGN KEY (CarId) REFERENCES [Cars]([Id])
)

INSERT INTO [Categories] ([Id], [CategoryName], [DailyRate], [WeeklyRate], [MonthlyRate], [WeekendRate]) VALUES
	(1, 'Car', 19.99, 129.99, 599.99, 37.99),
	(2, 'Van', 24.99, 169.99, 759.99, 47.99),
	(3, 'Electromobile', 17.99, 119.99, 539.99, 33.99)

INSERT INTO [Cars] ([Id], [PlateNumber], [Manufacturer], [Model], [CarYear], [CategoryId], [Doors], [Picture], [Condition], [Available]) VALUES 
	(1, 'CB7293HK', 'Volvo', 'FX', 2019, 1, 4, 1001, 'New', 0),
	(2, 'CB7294HK', 'Fiat', 'Doblo', 2020, 2, 5, 1001, 'Dirty', 1),
	(3, 'CB7295HK', 'RENAULT', 'Boerner', 2021, 3, 4, 1001, 'Almost clean', 1)

INSERT INTO [Employees] ([Id], [FirstName], [LastName], [Title], [Notes]) VALUES
	(1, 'Rositsa', 'Nenova', 'Miss', NULL),
	(2, 'Viktor', 'Dragomirov', 'Mr', NULL),
	(3, 'Ivanka', 'Atanasova', 'Mrs', NULL)

INSERT INTO [Customers] ([Id], [DriversLicenceNumber], [FullName], [Address], [City], [ZIPCode], [Notes]) VALUES
	(1, 2815367895, 'Batman the bat man', 'Batcave','Gotham', 1258, NULL),
	(2, 2815364781, 'Superman', 'Louis Lane', 'Metropolis', 1259, NULL),
	(3, 2815364788, 'The Flash', 'Too Fast str', 'Central City', 1257, NULL)

INSERT INTO [RentalOrders] ([EmployeeId], [CustomerId], [CarId], [TankLevel], [KilometrageStart], [KilometrageEnd], [TotalKilometrage],
						   [StartDate], [EndDate], [TotalDays], [RateApplied], [TaxRate], [OrderStatus], [Notes]) VALUES
	(1, 1, 1, 40, 123456, 123654, 198, '2021-10-01', '2021-10-03', 3, 19.99, 59.97, 'Paid', NULL),
	(2, 2, 2, 45, 123123, 123321, 198, '2021-10-03', '2021-10-09', 7, 169.99, 169.99, 'Pending', NULL),
	(3, 3, 3, 10, 123789, 123987, 198, '2021-10-09', '2021-10-09', 1, 17.99, 17.99, 'Paid', NULL)
 





