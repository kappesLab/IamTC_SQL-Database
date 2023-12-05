CREATE TABLE [dbo].[LocationVisit]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY,
	[PersonId] int not null,
	[LocationId] int not null,
	[VisitDate] DATETIME2 not null, 
    CONSTRAINT [FK_LocationVisit_Person] FOREIGN KEY (PersonId) REFERENCES Person(Id), 
    CONSTRAINT [FK_LocationVisit_Location] FOREIGN KEY (LocationId) REFERENCES [Location](Id)
)
