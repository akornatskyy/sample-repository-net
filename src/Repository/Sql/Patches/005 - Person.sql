CREATE TABLE [Membership].[Person] (
	[UserId] [int] NOT NULL,
	[GenderId] [int] NOT NULL CONSTRAINT [DF_Person_GenderId]  DEFAULT ((0)),
	[ModifiedOn] [datetime] NOT NULL CONSTRAINT [DF_Person_ModifiedOn]  DEFAULT (getutcdate()),
	[Firstname] [nvarchar](150) NOT NULL CONSTRAINT [DF_Person_Firstname]  DEFAULT (''),
	[Lastname] [nvarchar](150) NOT NULL CONSTRAINT [DF_Person_Lastname]  DEFAULT (''),
	[DateOfBirth] [date] NULL,
	CONSTRAINT [PK_Person] PRIMARY KEY CLUSTERED 
	(
		[UserId] ASC
	)
)
GO

ALTER TABLE [Membership].[Person]  WITH CHECK ADD  CONSTRAINT [FK_Person_Gender] FOREIGN KEY([GenderId])
REFERENCES [Membership].[Gender] ([Id])
GO

ALTER TABLE [Membership].[Person] CHECK CONSTRAINT [FK_Person_Gender]
GO

ALTER TABLE [Membership].[Person]  WITH CHECK ADD  CONSTRAINT [FK_Person_User] FOREIGN KEY([UserId])
REFERENCES [Membership].[User] ([Id])
GO

ALTER TABLE [Membership].[Person] CHECK CONSTRAINT [FK_Person_User]
GO