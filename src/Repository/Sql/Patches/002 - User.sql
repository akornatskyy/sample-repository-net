CREATE TABLE [Membership].[User] (
	[Id] [int] IDENTITY(1000, 1) NOT NULL,
	[CreatedOn] [datetime] NOT NULL CONSTRAINT [DF_User_CreatedOn]  DEFAULT (getutcdate()),
	[Email] [nvarchar](254) NOT NULL,
	[IsLocked] [bit] NOT NULL DEFAULT ((0)),
	CONSTRAINT [PK_Membership_User] PRIMARY KEY CLUSTERED 
	(
		[Id] ASC
	)
)
GO

CREATE UNIQUE NONCLUSTERED INDEX [IX_Email] ON [Membership].[User]
(
	[Email] ASC
)
INCLUDE ([Id], [IsLocked])
GO