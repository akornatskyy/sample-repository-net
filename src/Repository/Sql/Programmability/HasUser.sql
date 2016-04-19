IF OBJECT_ID(N'[Membership].[HasUser]', N'P') IS NULL 
	EXEC('CREATE PROCEDURE [Membership].[HasUser] AS SELECT 1')
GO

ALTER PROCEDURE [Membership].[HasUser]
(
	@Email nvarchar(254)
)
AS
BEGIN
	SELECT 1 FROM [Membership].[User]
	WHERE Email = @Email	
END
GO

GRANT EXECUTE ON [Membership].[HasUser] TO [ro]
GO