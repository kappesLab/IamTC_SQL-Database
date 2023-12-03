
-- select top worker for each customer


-- STEP #1
select c.*
from dbo.Customers c


-- STEP #2
select sum(w.HoursWorked), l.CustomerId, e.FirstName + ' ' + e.LastName
from dbo.WorksDone w 
inner join dbo.Locations l on w.LocationId = l.id
inner join dbo.Employees e on w.EmployeeId = e.id
group by l.CustomerId, e.FirstName, e.LastName
order by sum(w.HoursWorked) desc


-- STEP #3.A
select top 1 e.FirstName + ' ' + e.LastName
from dbo.WorksDone w 
inner join dbo.Locations l on w.LocationId = l.id
inner join dbo.Employees e on w.EmployeeId = e.id
where l.CustomerId = 3
group by e.FirstName, e.LastName
order by sum(w.HoursWorked) desc


-- STEP #3.B
select top 1 e.FirstName + ' ' + e.LastName
from dbo.WorksDone w 
inner join dbo.Locations l on w.LocationId = l.id
inner join dbo.Employees e on w.EmployeeId = e.id
where l.CustomerId = 2
group by e.FirstName, e.LastName
order by sum(w.HoursWorked) desc

/*
Quando si usa una DYNAMIC TABLE nella clausula SELECT, questa deve 
avere una sola riga (top 1) che viene riapplicta (ricalcolata) su ogni
riga della query esterna
*/

-- STEP #4
select c.CompanyName
  ,(select top 1 e.FirstName + ' ' + e.LastName
	from dbo.WorksDone w 
	inner join dbo.Locations l on w.LocationId = l.id
	inner join dbo.Employees e on w.EmployeeId = e.id
	where l.CustomerId = c.id
	group by e.FirstName, e.LastName
	order by sum(w.HoursWorked) desc) as 'TopWorker'
from dbo.Customers c