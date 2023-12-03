

-- Stimate Execution Plan 


-- Example #1
select c.CompanyName, j.JobName
from dbo.Jobs j
inner join dbo.Customers c on j.CustomerId = c.id;



-- Example #2
select c.CompanyName, j.JobName
from dbo.Jobs j
inner join dbo.Customers c on j.CustomerId = c.id
where c.CompanyName like '%cme%';










