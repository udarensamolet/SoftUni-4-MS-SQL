USE Bank
GO



--- Problem 01: Create Table Logs
CREATE TABLE Logs (
	LogId INT PRIMARY KEY IDENTITY
	, AccountId INT FOREIGN KEY REFERENCES Accounts(Id) NOT NULL
	, OldSum DECIMAL (6, 2) NOT NULL
	, NewSum DECIMAL (6, 2) NOT NULL
)
GO

CREATE TRIGGER tr_UpdateLogsOnAccountUpdate
ON Accounts FOR UPDATE
AS
	INSERT INTO Logs(AccountId, OldSum, NewSum)
	     SELECT i.Id
		      , d.Balance
			  , i.Balance
		   FROM inserted AS i
		   JOIN deleted AS d 
		     ON i.Id = d.Id
		  WHERE i.Balance <> d.Balance
GO



--- Problem 02: Create Table Emails
CREATE TABLE NotificationEmails (
	Id INT PRIMARY KEY IDENTITY
	, Recipient INT FOREIGN KEY REFERENCES Accounts(Id) NOT NULL
	, [Subject] NVARCHAR(100)
	, Body NVARCHAR(100)
)
GO

CREATE TRIGGER tr_SendEmailOnAccountAddition
ON Logs FOR INSERT
AS
	INSERT INTO NotificationEmails(Recipient, [Subject], Body)
	SELECT i.AccountId
		, CONCAT('Balance change for account: ', i.AccountId)
		, CONCAT('On ', FORMAT(GETDATE(), 'MMM dd yyyy hh:mmtt') , ' your balance was changed from ', ROUND(i.OldSum, 2), ' to ', ROUND(i.NewSum, 2))
	FROM inserted AS i
GO



--- Problem 03: Deposit Money
CREATE PROC usp_DepositMoney(@AccountId INT, @MoneyAmount DECIMAL (9, 4))
AS
BEGIN TRANSACTION
	UPDATE Accounts
	SET Balance += @MoneyAmount
	WHERE @AccountId = Id
	IF(@MoneyAmount <= 0)
	BEGIN
		ROLLBACK
		RETURN
	END
COMMIT
GO




--- Problem 04: Withdraw Money Procedure
CREATE PROC usp_WithdrawMoney(@AccountId INT, @MoneyAmount DECIMAL (9, 4))
AS
BEGIN TRANSACTION
	UPDATE Accounts
	SET Balance -= @MoneyAmount
	WHERE @AccountId = Id
	IF(@MoneyAmount <= 0)
	BEGIN
		ROLLBACK
		RETURN
	END
COMMIT
GO



--- Problem 05: Money Transfer
CREATE PROC usp_TransferMoney(@SenderId INT, @ReceiverId INT, @Amount DECIMAL (9,4)) 
AS
BEGIN
	EXEC usp_WithdrawMoney @SenderId, @Amount
	EXEC usp_DepositMoney @ReceiverId, @Amount
END
