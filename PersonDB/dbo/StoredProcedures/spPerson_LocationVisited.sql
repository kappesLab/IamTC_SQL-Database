CREATE PROCEDURE [dbo].[spPerson_LocationVisited]
	@PersonId int

AS

begin

	set nocount on;

	select [l].[LocationName], [l].[Location], [v].VisitDate
	from dbo.Person p
	inner join dbo.LocationVisit v on p.Id = v.PersonId
	inner join dbo.[Location] l on v.LocationId = l.Id
	where p.Id = @PersonId;

end