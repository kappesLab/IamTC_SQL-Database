
-- gruop by 'Company Name'

select c.CompanyName, sum(w.HoursWorked) as 'Total Worked'
from dbo.WorksDone w
inner join dbo.Jobs j on w.JobId = j.id
inner join dbo.Customers c on j.CustomerId = c.id
group by c.CompanyName;


-- group by 'Company Name' and 'Employee'

select c.CompanyName, e.FirstName, sum(w.HoursWorked) as 'Total Worked'
from dbo.WorksDone w
inner join dbo.Jobs j on w.JobId = j.id
inner join dbo.Customers c on j.CustomerId = c.id
inner join dbo.Employees e on w.EmployeeId = e.id
group by c.CompanyName, e.FirstName
order by c.CompanyName;

















