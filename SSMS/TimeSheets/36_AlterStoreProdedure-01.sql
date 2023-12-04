
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================

ALTER PROCEDURE dbo.spCustomerLookup
	@CustomerId int
AS
BEGIN
	SET NOCOUNT ON;

	select *
	from dbo.Customers
	where id = @CustomerId;
END
GO
