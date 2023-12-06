CREATE PROCEDURE [dbo].[Location_PeopleVisited]
	@locationId int

AS

begin

	set nocount on;

	select [p].[FirstName], [p].[LastName], p.EmailAddress
	from dbo.[Location] l
	inner join dbo.LocationVisit v on l.Id = v.LocationId
	inner join dbo.Person p on v.PersonId = p.Id
	where l.Id = @locationId;

end