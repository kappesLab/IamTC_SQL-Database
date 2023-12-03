
select c.CompanyName, e.FirstName, sum(w.HoursWorked) as 'Total Worked'
from dbo.WorksDone w
inner join dbo.Jobs j on w.JobId = j.id
inner join dbo.Customers c on j.CustomerId = c.id
inner join dbo.Employees e on w.EmployeeId = e.id
group by c.CompanyName, e.FirstName
order by c.CompanyName;


-- count, sum, min, max, avg

select c.CompanyName
	, e.FirstName
	, sum(w.HoursWorked) as 'Total Worked'
	, count(1) as 'Number of Entries'
	, min(w.HoursWorked) as 'Minimun'
	, max(w.HoursWorked) as 'Maximum'
	, avg(w.HoursWorked) as 'Average'
from dbo.WorksDone w
inner join dbo.Jobs j on w.JobId = j.id
inner join dbo.Customers c on j.CustomerId = c.id
inner join dbo.Employees e on w.EmployeeId = e.id
group by c.CompanyName, e.FirstName
order by c.CompanyName;


select c.CompanyName
	--, e.FirstName
	, sum(w.HoursWorked) as 'Total Worked'
	, count(1) as 'Number of Entries'
	, min(w.HoursWorked) as 'Minimun'
	, max(w.HoursWorked) as 'Maximum'
	, avg(w.HoursWorked) as 'Average'
from dbo.WorksDone w
inner join dbo.Jobs j on w.JobId = j.id
inner join dbo.Customers c on j.CustomerId = c.id
inner join dbo.Employees e on w.EmployeeId = e.id
group by c.CompanyName--, e.FirstName
order by c.CompanyName;
