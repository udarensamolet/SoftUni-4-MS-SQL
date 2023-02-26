--- Problem 01: Create Table Logs
CREATE TABLE Logs(
	LogId INT PRIMARY KEY IDENTITY
	, AccountId INT FOREIGN KEY REFERENCES Accounts(Id) NOT NULL
	, OldSum MONEY NOT NULL
	, NewSum MONEY NOT NULL
)

CREATE OR ALTER TRIGGER tr_AddToLogsOnAccountUpdate
ON Accounts FOR UPDATE
AS
	INSERT INTO Logs(AccountId, OldSum, NewSum)
	SELECT i.Id, d.Balance, i.Balance
	FROM inserted AS i
	JOIN deleted as d
	ON i.Id = d.Id
	WHERE i.Balance <> d.Balance
GO



--- Problem 02: Create Table Emails
CREATE TABLE NotificationEmails(
	Id INT PRIMARY KEY NOT NULL
	, Recipient INT FOREIGN KEY REFERENCES AccountHolders(Id) NOT NULL
	, [Subject] NVARCHAR(250) NOT NULL
	, Body NVARCHAR(250) NOT NULL
)

CREATE OR ALTER TRIGGER tr_SendEmailOnLogUpate
ON Logs FOR UPDATE
AS
	INSERT INTO NotificationEmails([Recipient], [Subject], Body)
	SELECT i.AccountId
		, CONCAT('Balance change for account: ', i.AccountId)
		, CONCAT('On ', FORMAT(GETDATE(), 'MMM dd yyyy hh:mmtt') , ' your balance was changed from ', ROUND(i.OldSum, 2), ' to ', ROUND(i.NewSum, 2))
	FROM inserted AS i
GO



--- Problem 03: Deposit Money
CREATE OR ALTER PROCEDURE usp_DepositMoney(@AccountId INT, @MoneyAmount DECIMAL(18,4))
AS
BEGIN TRANSACTION
UPDATE Accounts
SET Balance = Balance + @MoneyAmount
WHERE Id = @AccountId
IF (@MoneyAmount <= 0)
BEGIN
	ROLLBACK
	RETURN
END
COMMIT

EXEC usp_DepositMoney 1, 10



--- Problem 04: Withdraw Money Procedure
CREATE OR ALTER PROCEDURE usp_WithdrawMoney (@AccountId INT, @MoneyAmount DECIMAL(18,4))
AS
BEGIN TRANSACTION
UPDATE Accounts
SET Balance = Balance - @MoneyAmount
WHERE Id = @AccountId
IF (@MoneyAmount <= 0)
BEGIN
	ROLLBACK
	RETURN
END
COMMIT

EXEC usp_WithdrawMoney 5, 11



--- Problem 05: Money Transfer
CREATE OR ALTER PROCEDURE usp_TransferMoney(@SenderId INT, @ReceiverId INT, @Amount DECIMAL(18,4)) 
AS 
BEGIN TRANSACTION
	EXEC dbo.usp_DepositMoney @ReceiverId, @Amount
	EXEC dbo.usp_WithdrawMoney @SenderId, @Amount
	IF (@Amount <= 0)
	BEGIN
		ROLLBACK
		RETURN 
	END
COMMIT