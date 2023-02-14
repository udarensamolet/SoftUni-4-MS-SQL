--- Problem 13:	Movies Database ---
CREATE DATABASE [Movies]
USE [Movies]

CREATE TABLE [Directors] (
	[Id] INT PRIMARY KEY NOT NULL,
	[DirectorName] NVARCHAR(100) NOT NULL,
	[Notes] NVARCHAR(MAX)
)

CREATE TABLE [Genres] (
	[Id] INT PRIMARY KEY NOT NULL,
	[GenreName] NVARCHAR(100) NOT NULL,
	[Notes] NVARCHAR(MAX)
)

CREATE TABLE [Categories] (
	[Id] INT PRIMARY KEY NOT NULL,
	[CategoryName] NVARCHAR(100) NOT NULL,
	[Notes] NVARCHAR(MAX)
)

CREATE TABLE [Movies] (
	[Id] INT PRIMARY KEY NOT NULL,
	[Title] NVARCHAR(100) NOT NULL,
	[DirectorId] INT NOT NULL, 
	[CopyrightYear] DATE,
	[Length] INT,
	[GenreId] INT NOT NULL,
	[CategoryId] INT NOT NULL,
	[Rating] DECIMAL,
	[Notes] NVARCHAR(MAX),
	CONSTRAINT FK_DirectorId FOREIGN KEY ([DirectorId]) REFERENCES [Directors]([Id]),
	CONSTRAINT FK_GenreId FOREIGN KEY ([GenreId]) REFERENCES [Genres]([Id]),
	CONSTRAINT FK_CategoryId FOREIGN KEY ([CategoryId]) REFERENCES [Categories]([Id])
)

INSERT INTO [Directors] ([Id], [DirectorName], [Notes]) VALUES
	(1, 'Guy Ritchie', 'blah'),
	(2, 'Quentin Tarantino', 'blahh'),
	(3, 'udaren samolet', 'blah'),
	(4, 'udaren samolet', 'blah'),
	(5, 'udaren samolet', 'blah')

INSERT INTO [Genres] ([Id], [GenreName], [Notes]) VALUES
	(210, 'Classic Comedy Humor', NULL),
	(211, 'Dark Humor', NULL),
	(212, 'Jake Peralta Humor', NULL),
	(213, 'Sarcastic Humor', NULL),
	(214, 'Witty Humor', NULL)

INSERT INTO [Categories] ([Id], [CategoryName], [Notes]) VALUES
	(310, 'Best Comedy Ever', NULL),
	(311, 'Worst Comedy Ever', NULL),
	(312, 'Mediocre Comedy', NULL),
	(313, 'Funniest Comedy Tv Series Ever', NULL),
	(314, 'Wittiest Comedy Ever', NULL)

INSERT INTO [Movies] ([Id], [Title], [DirectorId], [CopyrightYear], [Length], [GenreId], [CategoryId], [Rating], [Notes]) VALUES
	(1, 'Brooklyn Nine-nine', 3, '2013-01-01', 1231, 212, 313, 10, null),
	(2, 'Snatch', 1, '2013-01-01', 1233, 214, 314, 10, null),
	(3, 'Kill Bill', 2, '2013-01-01', 1233, 211, 310, 10, null),
	(4, 'Blah Blah', 4, '2013-01-01', 1233, 213, 312, 10, null),
	(5, 'Blah Blah 2', 5, '2013-01-01', 1233, 210, 311, 10, null)







