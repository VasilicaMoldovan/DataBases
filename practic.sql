use Games
go

drop table Currencies
drop table Banknotes
drop table GameUser
drop table Product 
drop table Transaction1 
drop table BanknotesList 

create table Currencies(
Cid int Primary Key identity,
Name varchar(50),
Country varchar(50))

create table Banknotes(
Bid int Primary Key identity,
Value int,
Cid int Foreign Key References Currencies(Cid))

create table GameUser(
Uid int Primary Key identity,
Name varchar(50) unique)

create table Product(
Pid int Primary Key identity,
Name varchar(50),
Price int,
Cid int Foreign Key References Currencies(Cid))

create table Transaction1(
Tid int Primary Key identity,
Uid int Foreign Key References GameUser(Uid),
Pid int Foreign Key References Product(Pid),
Date date,
Time time)

create table BanknotesList(
Bid int Foreign Key References Banknotes(Bid),
Tid int Foreign Key References Transaction1(Tid),
Constraint pk_BL Primary Key (Bid, Tid))

insert into Currencies values ('lei', 'Romania'), ('euro', 'Germany'), ('dolar', 'USA')
insert into Banknotes values (25, 1), (10, 2), (10, 3)
insert into GameUser values  ('Ana'), ('Maria'), ('Dan')
insert into Product values ('Temple Run', 100, 1), ('Alladin', 200, 2), ('Barbie', 150, 3)  
insert into Transaction1 values (1, 1, '04-04-2018', '12:06:00')
insert into Transaction1 values (2, 2, '05-05-2017', '19:46:40'), (3, 3, '06-10-2015', '10:45:23')
insert into BanknotesList values (4, 1), (5, 2), (6, 3) 
insert into Transaction1 values(3, 2, '09-04-2010', '10:36:23')

create procedure deleteUser 
@UserName varchar(50)
as
begin
	declare @UserId int = (select U.Uid from GameUser U where U.Name = @UserName)
	if @UserId is null 
	begin 
		print 'The user does not exist'
	end

	if @UserId is not null
	begin 
		declare @TId int = (select top 1 T.Tid from Transaction1 T where T.Uid = @UserId)
		delete from BanknotesList where BanknotesList.Tid = @TId
		delete from Transaction1 where Transaction1.Tid = @TId
		delete from GameUser where GameUser.Uid = @UserId
	end
end

select * from GameUser
select * from Transaction1
select * from BanknotesList

exec deleteUser 'Ana'
go 

--3)

select count(P.Name)
from Product P, Currencies C
where P.Cid = C.Cid
group by P.Name

create or alter view CurrencyView
as
	select Currencies.Name, count(Product.Cid) as nr from Currencies
	left join Product on Product.CId = Currencies.Cid
	group by Currencies.Name
go

select * from CurrencyView


create or alter function ActiveUsers()
returns table
as
	return 
	select top 1 GameUser.Name, count(Transaction1.Uid) as nr  from Currencies, GameUser
	left join Transaction1 on Transaction1.Uid = GameUser.Uid
	group by GameUser.Name

go

select * from ActiveUsers()


create function ActiveUsers()
returns table
as
	return
		select distinct U.Name
		from GameUser U
		where (select count(*) from Transaction1 where Transaction1.Uid = U.Uid) >= 0
go

select *
from ActiveUsers()

select *
from ActiveUsers()

create table Zona


create or alter view ParkingView
as
	select P.Nume, P.Zona, P.Categorie, count(P.Nr) as nrLocLibere
	from Parcare P left join MasinaParcare M on M.cod_p = P.cod_p
	where (M.ora_sosirii > '16:00' or M.ora_plecarii < '14:00')
	group by P.Nume
end
	
select * from ParkingView


