
-- inner join: only the records that match
-- left join: all the records from the left table, and all the mathching records from the right table
-- right join: all the records from the right table, and all the mathching records from the left table

-- WorksDone table query

select *
from dbo.WorksDone;


select c.CompanyName
	, j.JobName
	, e.FirstName + ' ' + e.LastName as 'FullName'
	, w.[Description]
	, w.HoursWorked 
	, l.City
	, l.[State]
	, l.ZipCode
from dbo.WorksDone w
inner join dbo.Employees e on w.EmployeeId = e.id
inner join dbo.Jobs j on w.JobId = j.id
inner join dbo.Locations l on w.LocationId = l.id
inner join dbo.Customers c on j.CustomerId = c.id;


