use TravelAgency4
go

--deletes all the employees with a not null salary
DELETE FROM Employees
WHERE Salary IS NOT NULL
select * from Employees

--delets all the hotels with the manager id equal to 12, 18 or 90
DELETE FROM Hotels
WHERE Mid in (12, 18, 90)
select * from Hotels

--deletes all the managers with No of hotels between 2 and 5
DELETE FROM Manager 
WHERE NoOfH BETWEEN 2 AND 5
select * from Manager