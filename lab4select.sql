use TravelAgency4
go

alter procedure select_from_tables
	@view_name varchar(25)
as
begin
	set nocount on;
	if @view_name = 'View_1'
	begin
		select * from View_1
	end
	if @view_name = 'View_2'
	begin
		select * from View_2
	end
	if @view_name = 'View_3'
	begin
		select * from View_3
	end
end

exec select_from_tables 'View_3'
