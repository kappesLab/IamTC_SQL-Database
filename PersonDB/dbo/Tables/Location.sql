CREATE TABLE [dbo].[Location]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY,
	[LocationName] nvarchar(50) not null,
	[Location] nvarchar(50) not null, 
    [Country] NVARCHAR(50) NOT NULL DEFAULT ""
)
