CREATE TABLE [dbo].[Orders] (
    [Id]           INT           IDENTITY (1, 1) NOT NULL,
    [PurchaseDate] DATETIME2 (7) NULL,
    [Total]        MONEY         NULL,
    [PersonId] INT NOT NULL, 
    PRIMARY KEY CLUSTERED ([Id] ASC), 
    CONSTRAINT [FK_Orders_Person] FOREIGN KEY (PersonId) REFERENCES Person([Id])
);

