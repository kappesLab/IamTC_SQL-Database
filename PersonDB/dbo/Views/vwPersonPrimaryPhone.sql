CREATE VIEW [dbo].[vwPersonPrimaryPhone]
AS 
select [p].[FirstName], [p].[LastName], [p].[DateOfBirth], [p].[EmailAddress], ph.PhoneNumber
from dbo.Person p
left join dbo.PhoneNumber ph on p.id = ph.PersonId and  ph.PrimaryNumber = 1;
