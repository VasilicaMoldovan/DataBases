use TrainSchedule 
go

create table TrainType(
TTid int Primary Key,
Description varchar(50))

create table Train(
Tid int Primary Key,
Name varchar(50),
TTid int Foreign Key References TrainType(TTid))

create table Station(
Sid int Primary Key,
Name varchar(50) unique)

drop table StationList
drop table TrainRoutes

create table TrainRoutes(
Rid int Primary Key identity,
Name varchar(50),
Tid int Foreign Key References Train(Tid))

create table StationList(
Sid int Foreign Key References Station(Sid),
Rid int Foreign Key References TrainRoutes(Rid),
Constraint pk_SL Primary Key (Sid, Rid),
Arrival time,
Departure time)

--2)
insert into TrainType values (1, 'Fast'), (2, 'Not so fast')
insert into Train values (12, 'Cluj-Napoca - Galati', 2), (13, 'Iasi-Timisoara', 2)
insert into Station values (3, 'Cluj-Napoca'), (4, 'Beclean pe Somes')
insert into TrainRoutes values ('Nasaud', 12), ('Salva', 13)
insert into StationList values (3, 1, '11:17', '11:20'), (4, 2, '07:53', '08:00')

select * from TrainType
select * from Train 
select * from Station
select * from TrainRoutes
select * from StationList

alter procedure addOrUpdateRoute 
@Route varchar(50),
@Station varchar(50),
@Arrival time, 
@Departure time
as
begin
	declare @existStation int = (select s.Sid from Station s where s.Name = @Station)
	if @existStation is null
	begin 
		print 'Invalid station'
		return 1
	end

	declare @existRoute int = (select r.Rid from TrainRoutes r where r.Name = @Route)
	declare @routeId int
	declare @SListId int
	if @existRoute is null 
	begin
		insert into TrainRoutes values (@Route, 12)
		set @routeId = (select r.Rid from TrainRoutes r where r.Name = @Route)
		insert into StationList values (@existStation, @routeId, @Arrival, @Departure)
	end
	if @existRoute is not null
	begin 
		set @SListId = (select sl.Sid from Station S, StationList sl where s.Sid = sl.sid and sl.Rid = @existRoute and s.Name = @Station)
		if @SListId is null
		begin 
			insert into StationList values (@existStation, @existRoute, @Arrival, @Departure)
		end
		if @SListId is not null
		begin
			update StationList
			set Arrival = @Arrival, Departure = @Departure
			where StationList.Sid = @SListId and StationList.Rid = @existRoute
		end
	end
end
go

exec addOrUpdateRoute 'Nasaud', 'Cluj-Napoca', '12:54', '13:00'
exec addOrUpdateRoute 'Salva', 'Beclean pe Somes', '00:23', '03:18'
exec addOrUpdateRoute 'Bistrita', 'Cluj-Napoca', '06:45', '07:02'


--3
alter view RoutesView
as
select T.Name
from TrainRoutes T
inner join StationList SL on SL.Rid = T.Rid
group by T.Name
having ((select count(SL.Sid) as nr) = (select count(*) as E1 from Station))
go

insert into StationList values (4, 1, '12:00', '13:00')

select * from TrainRoutes
select * from Station
select * from StationList
select * from RoutesView

go

--4)

create function StationRoutes(@R int)
returns table
as
	return
		select distinct S.Name
		from Station S
		where (select count(*) from StationList where StationList.Sid = S.Sid) >= @R
go

select *
from StationRoutes(1)
