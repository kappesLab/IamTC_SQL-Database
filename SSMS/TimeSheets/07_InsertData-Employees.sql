USE [TimeSheets]
GO

INSERT INTO [dbo].[Employees]
           ([FirstName]
           ,[LastName]
           ,[EmailAddress]
           ,[PayRate]
           ,[BillRate]
           ,[CreateDate]
           ,[UpdateDate])
     VALUES
           (<FirstName, varchar(50),>
           ,<LastName, varchar(50),>
           ,<EmailAddress, varchar(100),>
           ,<PayRate, money,>
           ,<BillRate, money,>
           ,<CreateDate, datetime2(7),>
           ,<UpdateDate, datetime2(7),>)
GO


