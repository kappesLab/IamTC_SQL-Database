
-- UNION (ALL)

select c.CompanyName as 'Name', c.EmailAddress
from dbo.Customers c
UNION ALL
select e.FirstName + ' ' + e.LastName as 'Name', e.EmailAddress
from dbo.Employees e;


select c.EmailAddress
from dbo.Customers c
UNION 
select  e.EmailAddress
from dbo.Employees e;