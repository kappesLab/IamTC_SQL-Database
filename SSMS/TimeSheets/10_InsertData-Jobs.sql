USE [TimeSheets]
GO

INSERT INTO [dbo].[Jobs]
           ([JobName]
           ,[CustomerId]
           ,[CreateDate]
           ,[UpdateDate])
     VALUES
           (<JobName, varchar(100),>
           ,<CustomerId, int,>
           ,<CreateDate, datetime2(7),>
           ,<UpdateDate, datetime2(7),>)
GO

