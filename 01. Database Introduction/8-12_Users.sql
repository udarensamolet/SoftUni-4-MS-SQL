--- Problem 08: Create Table Users
CREATE DATABASE [Users]

USE [Users]

CREATE TABLE [Users] (
	[Id] BIGINT UNIQUE IDENTITY NOT NULL,
	[Username] VARCHAR(30) UNIQUE NOT NULL,
	CHECK (DATALENGTH([Username]) <= 3),
	[Password] VARCHAR(26) NOT NULL,
	CHECK (DATALENGTH([Password]) <= 5),
	[ProfilePicture] VARBINARY(900), 
	CHECK (DATALENGTH([ProfilePicture]) <= 900000),
	[LastLoginTime] DATETIME2 DEFAULT GETDATE(),
	[IsDeleted]	BIT,
	CONSTRAINT PK_UsersId PRIMARY KEY (Id)
)

INSERT INTO [Users] ([Username], [Password], [ProfilePicture], [LastLoginTime], [IsDeleted]) VALUES
	('udarensamolet', 'udarensamoletPass123!', 01010, '2021-10-07 00:43:57', 0),
	('udarensamolett', 'udarensamoletPass123!', 01010, '2021-10-07 00:43:57', 1),
	('udarensamolettt', 'udarensamoletPass123!', 01010, '2021-10-07 00:43:57', 0),
	('udarensamoletttt', 'udarensamoletPass123!', 01010, '2021-10-07 00:43:57', 1),
	('udarensamolettttt', 'udarensamoletPass123!', 01010, '2021-10-07 00:43:57', 0)



--- Problem 09: Change Primary Key
ALTER TABLE [Users]
DROP CONSTRAINT PK_UsersId

ALTER TABLE [Users]
ADD CONSTRAINT PK_UsersIdUsername PRIMARY KEY ([Id], [Username])




--- Problem 10:	Add Check Constraint
ALTER TABLE [Users]
ADD CONSTRAINT [Password] CHECK (Len([Password]) >= 5)



--- Problem 11: Set Default Value of a Field
ALTER TABLE [Users]
ADD CONSTRAINT [LastLoginTime] DEFAULT GETDATE() FOR [LastLoginTime]



--- Problem 12: Set Unique Field
ALTER TABLE [Users]
DROP CONSTRAINT PK_UsersIdUsername

ALTER TABLE [Users]
ADD CONSTRAINT PK_UsersId PRIMARY KEY (Id)

ALTER TABLE [Users]
ADD CONSTRAINT PK_UsersId CHECK (LEN([Username]) >= 3)
