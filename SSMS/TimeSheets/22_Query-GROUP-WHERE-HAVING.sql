
select c.CompanyName, e.FirstName, sum(w.HoursWorked) as 'Total Worked'
from dbo.WorksDone w
inner join dbo.Jobs j on w.JobId = j.id
inner join dbo.Customers c on j.CustomerId = c.id
inner join dbo.Employees e on w.EmployeeId = e.id
group by c.CompanyName, e.FirstName
order by c.CompanyName;



-- exclude one row of 7 hours on ABC Inc of Sue
-- where exclede the rows before the gruoping

select c.CompanyName, e.FirstName, sum(w.HoursWorked) as 'Total Worked'
from dbo.WorksDone w
inner join dbo.Jobs j on w.JobId = j.id
inner join dbo.Customers c on j.CustomerId = c.id
inner join dbo.Employees e on w.EmployeeId = e.id
where w.id != 8 
group by c.CompanyName, e.FirstName
order by c.CompanyName;




-- show the gruop with sum of hours > 5
-- Having works on grouping

select c.CompanyName, e.FirstName, sum(w.HoursWorked) as 'Total Worked'
from dbo.WorksDone w
inner join dbo.Jobs j on w.JobId = j.id
inner join dbo.Customers c on j.CustomerId = c.id
inner join dbo.Employees e on w.EmployeeId = e.id
group by c.CompanyName, e.FirstName
having sum(w.HoursWorked) > 5
order by c.CompanyName;



