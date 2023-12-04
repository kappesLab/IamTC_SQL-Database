
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================

CREATE PROCEDURE dbo.spCustomer_Insert
	@CompanyName varchar(100),
	@PhoneNumber varchar(20),
	@EmailAddrees varchar(100)
AS
BEGIN
	SET NOCOUNT ON;

	insert into dbo.Customers(CompanyName, PhoneNumber, EmailAddress)
	values (@CompanyName, @PhoneNumber, @EmailAddrees);
END
GO
