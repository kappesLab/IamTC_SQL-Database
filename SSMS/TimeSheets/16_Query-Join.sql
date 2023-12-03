
select *
from Customers;


select *
from Locations;


-- inner join: only the records that match
select c.CompanyName, l.StreerAddress, l.City, l.[State], l.ZipCode
from dbo.Customers c
inner join  dbo.Locations l on c.id = l.CustomerId
order by c.CompanyName;


-- left join: all the records from the left table, and all the mathching records from the right table
select c.CompanyName, l.StreerAddress, l.City, l.[State], l.ZipCode
from dbo.Customers c
left join  dbo.Locations l on c.id = l.CustomerId
order by c.CompanyName;



-- right join: all the records from the right table, and all the mathching records from the left table
select c.CompanyName, l.StreerAddress, l.City, l.[State], l.ZipCode
from dbo.Customers c
right join  dbo.Locations l on c.id = l.CustomerId
order by c.CompanyName;



