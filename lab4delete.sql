use TravelAgency4
go

alter procedure delete_from_tables
	-- Add the parameters for the stored procedure here
	@nb_of_rows varchar(30),
	@table_name varchar(30)
as
begin
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	set nocount on;

    -- Insert statements for procedure here
	
	set @nb_of_rows = cast(@nb_of_rows as INT)

	declare @last_row int
	if @table_name = 'EH'
		begin
			set @last_row = (select MAX(Eid) from EH) - @nb_of_rows
			
			delete from EH
		end
		
		if @table_name = 'Employees'
		begin
			set @last_row =(select MAX(Eid) from Employees) - @nb_of_rows
			delete from EH
			delete from Employees
			where Eid > @last_row
		end

		if @table_name = 'Hotels'
		begin
			delete from EH
			delete from Hotels
		end
end
