CREATE TABLE [dbo].[OrderDetails] (
    [Id]      INT           IDENTITY (1, 1) NOT NULL,
    [OrderId] INT           NOT NULL,
    [Item]    NVARCHAR (50) NULL,
    [Price]   MONEY         NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

