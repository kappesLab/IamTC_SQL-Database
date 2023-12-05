CREATE TABLE [dbo].[PhoneNumber]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY,
	[PhoneNumber] nvarchar(50) not null,
	[PersonId] int not null,
	[PrimaryNumber] bit NOT null DEFAULT 0, 
    CONSTRAINT [FK_PhoneNumber_Person] FOREIGN KEY (PersonId) REFERENCES Person(Id)
)
