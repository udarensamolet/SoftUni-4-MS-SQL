--- Problem 06: University Database
CREATE TABLE Majors (
	MajorID INT PRIMARY KEY
	, [Name] NVARCHAR(50) NOT NULL
)

CREATE TABLE Subjects(
	SubjectID INT PRIMARY KEY
	, SubjectName NVARCHAR(50) NOT NULL
)

CREATE TABLE Students (
	StudentID INT PRIMARY KEY
	, StudentNumber INT NOT NULL
	, StudentName VARCHAR(50) NOT NULL
	, MajorID INT NOT NULL
	CONSTRAINT FK_Students_Majors FOREIGN KEY (MajorID) REFERENCES Majors(MajorID)
)

CREATE TABLE Agenda(
	StudentID INT NOT NULL,
	SubjectID INT NOT NULL,
	CONSTRAINT PK_Agenda PRIMARY KEY (StudentID, SubjectID)
	, CONSTRAINT FK_Agenda_Students FOREIGN KEY (StudentID) REFERENCES Students(StudentID)
	, CONSTRAINT FK_Agenda_Subjects FOREIGN KEY (SubjectID) REFERENCES Subjects(SubjectID)
)

CREATE TABLE Payments (
	PaymentID INT PRIMARY KEY
	, PaymentDate DATE NOT NULL
	, PaymentAmount MONEY NOT NULL
	, StudentID INT NOT NULL
	CONSTRAINT FK_Payments_Students FOREIGN KEY (StudentID) REFERENCES Students(StudentID)
)