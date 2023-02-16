--- Problem 07: Create Table People
CREATE DATABASE [People]

USE [People]

CREATE TABLE [People] (
	[Id]		INT UNIQUE IDENTITY NOT NULL,
	[Name]		NVARCHAR(200)		NOT NULL,
	[Picture]	VARBINARY(MAX),
	CHECK (DATALENGTH([Picture]) <= 16000000),
	[Height]	DECIMAL(3,2),
	[Weight]	DECIMAL(5,2),
	[Gender]	CHAR				NOT NULL,
	[Birthdate] DATE				NOT NULL,
	[Biography] NVARCHAR(MAX)
	CONSTRAINT PK_People PRIMARY KEY(Id)
)

INSERT INTO [People] ([Name], [Picture], [Height], [Weight], [Gender], [Birthdate], [Biography]) VALUES
	('Matsa', 101010101, 1.70, 77, 'f', '1989/09/27', 'blah blah blah'),
	('Pisa', 101010101, 1.69, 77.8, 'f', '1989/09/27', 'blah blah blah'),
	('Sharkie', 101010101, 1.71, 76.89, 'f', '1989/09/27', 'blah blah blah'),
	('Timon', 101010101, 1.73, 79.89, 'f', '1989/09/27', 'blah blah blah'),
	('Rosko', 101010101, 1.89, 77.00, 'm', '1989/09/27', 'blah blah blah')