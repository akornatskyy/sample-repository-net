IF OBJECT_ID(N'[Membership].[AddUser]', N'P') IS NULL 
	EXEC('CREATE PROCEDURE [Membership].[AddUser] AS SELECT 1')
GO

ALTER PROCEDURE [Membership].[AddUser]
(
	@Email nvarchar(254)
)
AS
BEGIN
	DECLARE @User TABLE (Id int, CreatedOn datetime);

	INSERT INTO [Membership].[User]
		(CreatedOn, Email)
	OUTPUT
		inserted.Id, inserted.CreatedOn
	INTO 
		@User (Id, CreatedOn)
	VALUES 
		(DEFAULT, LOWER(@Email));

	INSERT INTO [Membership].[Address]
	(
		UserId, ModifiedOn
	)
	SELECT
		u.Id, u.CreatedOn
	FROM @User u;

	INSERT INTO [Membership].[Person]
	(
		UserId, ModifiedOn
	)
	OUTPUT
		inserted.UserId UserId
	SELECT
		u.Id, u.CreatedOn
	FROM @User u;
END
GO

GRANT EXECUTE ON [Membership].[AddUser] TO [rw]
GO