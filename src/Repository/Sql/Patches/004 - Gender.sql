CREATE TABLE [Membership].[Gender] (
	[Id] [int] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	CONSTRAINT [PK_Gender] PRIMARY KEY CLUSTERED 
	(
		[Id] ASC
	)
)
GO

INSERT INTO [Membership].[Gender]
SELECT 0, 'Unknown'
UNION ALL SELECT 1, 'Male'
UNION ALL SELECT 2, 'Female'