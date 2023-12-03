

select *
from dbo.Customers;

-- AND OR

select *
from dbo.Customers c 
where (c.CompanyName like 'A%' AND c.EmailAddress like '%.org') OR c.id = 1;

