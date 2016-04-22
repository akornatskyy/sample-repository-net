CREATE TABLE [Membership].[Address] (
	[UserId] [int] NOT NULL,
	[ModifiedOn] [datetime] NOT NULL CONSTRAINT [DF_Address_ModifiedOn]  DEFAULT (getutcdate()),
	[AddressLine1] [nvarchar](150) NOT NULL CONSTRAINT [DF_Address_AddressLine1]  DEFAULT (''),
	[AddressLine2] [nvarchar](150) NOT NULL CONSTRAINT [DF_Address_AddressLine2]  DEFAULT (''),
	[AddressLine3] [nvarchar](150) NOT NULL CONSTRAINT [DF_Address_AddressLine3]  DEFAULT (''),
	[AddressLine4] [nvarchar](150) NOT NULL CONSTRAINT [DF_Address_AddressLine4]  DEFAULT (''),
	[City] [nvarchar](150) NOT NULL CONSTRAINT [DF_Address_City]  DEFAULT (''),
	[Country] [nvarchar](50) NOT NULL CONSTRAINT [DF_Address_Country]  DEFAULT (''),
	[Zipcode] [nchar](10) NOT NULL CONSTRAINT [DF_Address_Zipcode]  DEFAULT (''),
	CONSTRAINT [PK_Address] PRIMARY KEY CLUSTERED 
	(
		[UserId] ASC
	)
)
GO

ALTER TABLE [Membership].[Address]  WITH CHECK ADD  CONSTRAINT [FK_Address_User] FOREIGN KEY([UserId])
REFERENCES [Membership].[User] ([Id])
GO

ALTER TABLE [Membership].[Address] CHECK CONSTRAINT [FK_Address_User]
GO