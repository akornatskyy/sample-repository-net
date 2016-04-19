CREATE SCHEMA [Membership]
GO

-- Users

CREATE USER [sample-ro] FOR LOGIN [sample-ro]
GO

CREATE USER [sample-rw] FOR LOGIN [sample-rw]
GO

-- Roles

CREATE ROLE [ro]
GO

ALTER ROLE [ro] ADD MEMBER [sample-ro]
GO

ALTER ROLE [ro] ADD MEMBER [sample-rw]
GO

CREATE ROLE [rw]
GO

ALTER ROLE [rw] ADD MEMBER [sample-rw]
GO