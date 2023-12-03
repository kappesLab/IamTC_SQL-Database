USE [TimeSheets]
GO

INSERT INTO [dbo].[Locations]
           ([StreerAddress]
           ,[City]
           ,[State]
           ,[ZipCode]
           ,[CustomerId]
           ,[CreateDate]
           ,[UpdateDate])
     VALUES
           (<StreerAddress, varchar(100),>
           ,<City, varchar(50),>
           ,<State, varchar(20),>
           ,<ZipCode, varchar(20),>
           ,<CustomerId, int,>
           ,<CreateDate, datetime2(7),>
           ,<UpdateDate, datetime2(7),>)
GO

