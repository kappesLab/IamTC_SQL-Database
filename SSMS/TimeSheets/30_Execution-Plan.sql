

-- Stimate Execution Plan (example)


select c.CompanyName, j.JobName
from dbo.Jobs j
inner join dbo.Customers c on j.CustomerId = c.id;














