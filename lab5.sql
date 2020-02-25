use TravelAgency4
go


create table Tourist
(Tid int Primary Key,
Age int Unique,
Name varchar(50))

create table Guide
(Gid int Primary Key,
Experience int)

create table Schedule
(Sid int Primary Key,
Tid int Foreign Key References Tourist(Tid),
Gid int Foreign Key References Guide(Gid))

insert into Tourist values (1, 15, 'Ana'), (2, 45, 'Maria'), (3, 24, 'Laura'), (4, 60, 'Ioana')

--clustered index scan;
select * from Tourist
order by Tid

--clustered index seek;
select * from Tourist
where Tid = 3
order by Tid

--nonclustered index scan;
if exists (select name from sys.indexes where name = N'N_idx_Name')
drop index N_idx_Name on Tourist 
go

create nonclustered index N_idx_Name on Tourist(Name);
go

--nonclustered index seek;
select Name
from Tourist
where Name = 'Laura'
go

--key lookup
select *
FROM Tourist with(index = 2)
Where Name like '_%A'

insert into Guide values (1, 5), (2, 6), (3, 3), (4, 2), (5, 5), (6, 5)
insert into Schedule values (1, 1, 1), (2, 2, 3), (3, 4, 2), (4, 4, 6) 

--b)
select * from Guide
where Experience = 5

if exists (select name from sys.indexes where name = N'N_idx_Experience')        
drop index N_idx_Experience on Guide;    
go
create nonclustered index N_idx_Experience on Guide(Experience);    
go

set nocount on; 
GO 
SET SHOWPLAN_ALL ON; 
GO 
SELECT * FROM Guide WHERE Experience BETWEEN 2 AND 15
GO 

SET SHOWPLAN_ALL OFF 
GO


--c)
alter view test 
as 
select t.Name, t.Age, g.Experience
from Tourist t INNER JOIN Schedule s ON t.Tid=s.Tid 
INNER JOIN Guide g ON g.Gid=s.Gid 
Where Age BETWEEN 7 and 63 OR Experience>2 
go 
 
select * from test 

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'N_idx_Name2')       
DROP INDEX N_idx_Name2 ON Tourist;    
GO  
CREATE NONCLUSTERED INDEX N_idx_Name2 ON Tourist(Name);    
GO 

select t.Name 
from Tourist t INNER JOIN Schedule s ON t.Tid=s.Tid 
INNER JOIN Guide g ON g.Gid=s.Gid 
Where Age BETWEEN 7 and 60 OR Experience > 3

EXEC sp_helpindex 'Tourist'