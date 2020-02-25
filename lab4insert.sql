use TravelAgency4
go

alter procedure insert_in_tables
	@NoOfRows int,
	@t varchar(30)
as 
begin
	declare @n int
	declare @aux varchar(30)
	declare @fk int

	select top 1 @fk=Mid from Manager

	--select top 1 @NoOfRows = NoOfRows From TestTables
	--set @NoOfRows=8
	set @n=1

	while @n<@NoOfRows
	begin
		if @t = 'Employee'
		begin
			set @aux = 'Employee' + convert(varchar(5), @n)
			insert into Employees(Eid, Name, Salary) values (@n, @aux, 100)
		end
		if @t = 'Hotels'
		begin
			set @aux = 'Hotel' + convert(varchar(5), @n)
			insert into Hotels(Hid, Name, Capacity, NoOfGuests, Mid, Adid) values (@n + 1, @aux, 625, 400, @fk, 178)
		end
		if @t = 'EH'
		begin
			insert into EH(Eid, Hid) values (@n, @n + 1)
		end
		set @n=@n+1
	end
end


exec insert_in_tables '20', 'EH'


