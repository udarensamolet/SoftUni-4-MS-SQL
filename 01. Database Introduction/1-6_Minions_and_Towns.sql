--- Problem 01: Create Database
CREATE DATABASE [Minions]

USE [Minions]



--- Problem 02: Create Tables
CREATE TABLE [Minions] (
	[Id] INT NOT NULL,
	[Name] NVARCHAR(50) NOT NULL,
	[Age] INT
)

ALTER TABLE [Minions]
ADD CONSTRAINT PK_MinionsID PRIMARY KEY (Id)

CREATE TABLE [Towns](
	[Id] INT PRIMARY KEY NOT NULL,
	[Name] NVARCHAR(50) NOT NULL
)



--- Problem 03: Alter Minions Table
ALTER TABLE [Minions]
ADD [TownId] INT 

ALTER TABLE [Minions]
ADD CONSTRAINT FK_MinionsTownId FOREIGN KEY (TownId)  REFERENCES [Towns]([Id])



--- Problem 04: Insert Recordds in Both Tables
INSERT INTO [Towns]([Id], [Name]) VALUES
	(1, 'Sofia'),
	(2, 'Plovdiv'),
	(3, 'Varna')

INSERT INTO [Minions]([Id], [Name], [Age], [TownId]) VALUES
	(1, 'Kevin', 22, 1),
	(2, 'Bob', 15, 3),
	(3, 'Steward', NULL, 2)

	

--- Problem 05 Truncate Table Minions 
TRUNCATE TABLE [Minions]



--- Problem 06 Drop All Tables 
DROP TABLE [Minions]

DROP TABLE [Towns]














































