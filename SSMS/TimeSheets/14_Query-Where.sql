
-- 'a to z' (ascending)
-- 'z to a' (descending)


select FirstName, LastName, EmailAddress, PayRate, BillRate
from dbo.Employees
where PayRate > 110
order by LastName desc, FirstName desc

















