
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================

CREATE PROCEDURE dbo.spCustomerLookup

AS
BEGIN
	SET NOCOUNT ON;

	select *
	from dbo.Customers;
END
GO
