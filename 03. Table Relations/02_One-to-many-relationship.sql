--- Problem 02: One-to-Many Relationship
CREATE TABLE Manufacturers (
	ManufacturerID INT PRIMARY KEY
	, [Name] NVARCHAR(30) NOT NULL
	, EstablishedOn DATE NOT NULL
)

INSERT INTO Manufacturers(ManufacturerID,[Name], EstablishedOn) VALUES
	(1, 'BMW', '1916-03-07')
	, (2, 'Tesla', '2003-01-01')
	, (3, 'Lada', '1966-05-01')

CREATE TABLE Models (
	ModelID INT PRIMARY KEY 
	, [Name] NVARCHAR(30) NOT NULL
	, ManufacturerID INT NOT NULL
	CONSTRAINT FK_Models_Manufacturers FOREIGN KEY(ManufacturerID) REFERENCES Manufacturers(ManufacturerID)
)

INSERT INTO Models(ModelID, [Name], ManufacturerID) VALUES
	(101, 'X1', 1)
	, (102, 'I6', 1)
	, (103, 'Model S', 2)
	, (104, 'Model X', 2)
	, (105, 'Model 3', 2)
	, (106, 'Nova', 3)
