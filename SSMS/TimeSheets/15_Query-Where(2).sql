-- LastName == 'Smith'
select FirstName, LastName, EmailAddress, PayRate, BillRate
from dbo.Employees
where LastName = 'Smith'
order by LastName desc, FirstName desc


-- LastName start with 'S'
select FirstName, LastName, EmailAddress, PayRate, BillRate
from dbo.Employees
where LastName like 'S%'
order by LastName desc, FirstName desc


-- emal ends to '.net'
select FirstName, LastName, EmailAddress, PayRate, BillRate
from dbo.Employees
where EmailAddress like '%.net'
order by LastName desc, FirstName desc



-- email contains 'o'
select FirstName, LastName, EmailAddress, PayRate, BillRate
from dbo.Employees
where EmailAddress like '%o%'
order by LastName desc, FirstName desc
















