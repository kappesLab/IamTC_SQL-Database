
-- UNION (ALL)

select FirstName, LastName
from dbo.Employees
UNION ALL
select FirstName, LastName
from dbo.Employees;



select FirstName, LastName
from dbo.Employees
UNION 
select FirstName, LastName
from dbo.Employees;
