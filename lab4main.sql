use TravelAgency4
go

delete from Tables
delete from Views

delete from EH
delete from Employees
delete from Hotels

insert into dbo.Tables values ( 'Employees')
insert into dbo.Tables values ( 'Hotels')
insert into dbo.Tables values ( 'EH')
insert into dbo.Views values ( 'View_1')
insert into dbo.Views values ( 'View_2')
insert into dbo.Views values ( 'View_3')



alter procedure mainTest
	-- Add the parameters for the stored procedure here
	@nb_of_rows varchar(30)
as
begin
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	set nocount on;

    -- Insert statements for procedure here
	if ISNUMERIC(@nb_of_rows) != 1
	begin
		print('Not a number')
		return 1 
	end
	
	--SET @nb_of_rows = cast(@nb_of_rows as INT)

	declare @all_start datetime
	set @all_start = GETDATE();

	declare @employees_delete_start datetime
	set @employees_delete_start = GETDATE()
	execute delete_from_tables @nb_of_rows, 'Employees'
	declare @employees_delete_end datetime
	set @employees_delete_end = GETDATE()

	declare @hotels_delete_start datetime
	set @hotels_delete_start = GETDATE()
	execute delete_from_tables @nb_of_rows, 'Hotels'
	declare @hotels_delete_end datetime
	set @hotels_delete_end = GETDATE()

	declare @eh_delete_start datetime
	set @eh_delete_start = GETDATE()
	execute delete_from_tables @nb_of_rows, 'EH'
	declare @eh_delete_end datetime
	set @eh_delete_end = GETDATE()



	declare @hotels_insert_start datetime
	set @hotels_insert_start = GETDATE()
	execute insert_in_tables @nb_of_rows, 'Hotels'
	declare @hotels_insert_end datetime
	set @hotels_insert_end = GETDATE()

	declare @employees_insert_start datetime
	set @employees_insert_start = GETDATE()
	execute insert_in_tables @nb_of_rows, 'Employee'
	declare @employees_insert_end datetime
	set @employees_insert_end = GETDATE()

	
	declare @eh_insert_start datetime
	set @eh_insert_start = GETDATE()
	execute insert_in_tables @nb_of_rows, 'EH'
	declare @eh_insert_end datetime
	set @eh_insert_end = GETDATE()

	declare @view_1_table_start datetime
	set @view_1_table_start = GETDATE()
	execute select_from_tables 'View_1'
	declare @view_1_table_end datetime
	set @view_1_table_end = GETDATE()

	declare @view_2_tables_start datetime
	set @view_2_tables_start = GETDATE()
	execute select_from_tables 'View_2'
	declare @view_2_tables_end datetime
	set @view_2_tables_end = GETDATE()

	declare @view_2_tables_group_by_start datetime
	set @view_2_tables_group_by_start = GETDATE()
	execute select_from_tables 'View_3'
	declare @view_2_tables_group_by_end datetime
	set @view_2_tables_group_by_end = GETDATE()

	declare @all_stop datetime 
	set @all_stop = getdate() 

	declare @description varchar(100)
	set @description = 'TestRun' + convert(varchar(7), (select max(TestRunID) from TestRuns)) + 'delete, insert' + @nb_of_rows + 'rows, select all views'

	insert into TestRuns(Description, StartAt, EndAt)
	values(@description, @all_start, @all_stop);

	declare @lastTestRunID int; 
	set @lastTestRunID = (select max(TestRunID) from TestRuns);


	insert into TestRunTables
	values(@lastTestRunID, 22, @hotels_delete_start, @hotels_insert_end)

	insert into TestRunTables
	values(@lastTestRunID, 23, @employees_delete_start, @employees_insert_end)

	insert into TestRunTables
	values(@lastTestRunID, 24, @eh_delete_start, @eh_insert_end)

	insert into TestRunViews
	values(@lastTestRunID, 22, @view_1_table_start, @view_1_table_end)
	
	insert into TestRunViews
	values(@lastTestRunID, 23, @view_2_tables_start, @view_2_tables_end)

	insert into TestRunViews
	values(@lastTestRunID, 24, @view_2_tables_group_by_start, @view_2_tables_group_by_end)
end

exec mainTest '1000'

Select*
from TestRuns

Select*
from TestRunTables

Select*
from TestRunViews

