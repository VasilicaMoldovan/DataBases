use TravelAgency4
go

CREATE TABLE Version(
Vid Int PRIMARY KEY);

insert into Version values(1)
insert into Version values(2)
insert into Version values(3)
insert into Version values(4)
insert into Version values(5)
insert into Version values(6)
insert into Version values(7)

ALTER PROCEDURE main
@version int
AS
BEGIN

	--SET NOCOUNT ON;
	print('buna')
	DECLARE @nextVersion varchar(50)
	DECLARE @currentVersion int
	SET @currentVersion = (SELECT TOP 1 Vid from Version)

	print('buna2')
	if @version < 0 or @version > 7
	BEGIN
		print('Invalid number')
		return 
	END
	print('buna3')
	WHILE @currentVersion < @version
	BEGIN
		print('buna8')
		SET @currentVersion = @currentVersion + 1
		SET @nextVersion = 'version_up_' + CONVERT(varchar(1), @currentVersion)
		EXECUTE @nextVersion
		--EXECUTE @nextVersion
		UPDATE Version
		SET Vid = @currentVersion
		--EXECUTE @nextVersion
	END

	WHILE @currentVersion > 1
	BEGIN
		print('buna5')
		SET @currentVersion = @currentVersion - 1
		SET @nextVersion = 'version_down_' + CONVERT(varchar(1), @currentVersion)
		EXECUTE @nextVersion
		--EXECUTE @nextVersion
		UPDATE Version
		SET Vid = @currentVersion
	END

	TRUNCATE TABLE Version
	insert into Version values(@version)
END
go

EXECUTE version_up_1
EXECUTE version_up_2
EXECUTE version_up_3
EXECUTE version_up_4
EXECUTE version_up_5
EXECUTE version_up_6
EXECUTE version_up_7

EXEC main @version=5
