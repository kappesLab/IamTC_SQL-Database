/*
QUERY Script di inserimento dei dati di test
per la tabella 'WorksDone'
*/

INSERT INTO dbo.WorksDone (EmployeeId, JobId, LocationId, HoursWorked, Description, DatePerformed)
VALUES (1, 1, 1, 7, 'I create most of backend database to support the TimeSheets app.', '1/15/2017'),
	(1, 1, 3, 3, 'I built the Angular front-end.', '1/18/2017'),
	(4, 2, 2, 9, 'I built the first floor.', '1/8/2017');


SELECT * FROM dbo.Employees;
SELECT * FROM dbo.Jobs;
SELECT * FROM dbo.Locations;