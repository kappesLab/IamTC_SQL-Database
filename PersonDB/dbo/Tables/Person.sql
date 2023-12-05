CREATE TABLE [dbo].[Person]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY,
	[FirstName] nvarchar(50) not null, 
    [LastName]  nvarchar(50) not null, 
    [DateOfBirth] datetime2 not null, 
	[EmailAddress] nvarchar(100) not null
)
