use TravelAgency4
go

select * from Employees
select * from Hotels
select * from Manager
select * from Transport
select * from Review

ALTER PROCEDURE version_up_0
AS
BEGIN
	ALTER TABLE Hotels
	ALTER COLUMN NoOfGuests int NOT NULL
	print('0\n')
END

--modify the type of a column
ALTER PROCEDURE version_up_1
AS
BEGIN
	ALTER TABLE Hotels
	ALTER COLUMN NoOfGuests int NOT NULL
	print('1\n')
END

EXEC version_1

--modify the type of a column
ALTER PROCEDURE version_down_1
AS
BEGIN
	ALTER TABLE Hotels
	ALTER COLUMN NoOfGuests int NULL
	print('1-1\n')
END

ALTER PROCEDURE version_down_0
AS
BEGIN
	ALTER TABLE Hotels
	ALTER COLUMN NoOfGuests int 
	print('0-0\n')
END

--add a new column
ALTER PROCEDURE version_up_2
AS
BEGIN
	ALTER TABLE Hotels
	ADD Stars int
	print('2\n')
END

EXEC version_up_2

--remove an existing column
ALTER PROCEDURE version_down_2
AS
BEGIN
	ALTER TABLE Hotels
	DROP COLUMN Stars
	print('2-2\n')
END

EXEC version_down_2

--add a default constraint
ALTER PROCEDURE version_up_3
AS
BEGIN
	ALTER TABLE Employees
	ADD CONSTRAINT salary DEFAULT 10000 FOR Salary
	print('3\n')
END

EXECUTE version_up_3

--remove a default constraint
ALTER PROCEDURE version_down_3
AS
BEGIN
	ALTER TABLE Employees
	DROP CONSTRAINT salary
	print('3-3\n')
END

EXECUTE version_down_3

CREATE PROCEDURE version_up2_3
AS
BEGIN
	ALTER TABLE Manager
	ADD Age int DEFAULT 28
	ALTER TABLE Manager
	ADD CONSTRAINT age20 DEFAULT 20 FOR Age
END

--EXECUTE version_down2_3

CREATE PROCEDURE version_down2_3
AS
BEGIN
	ALTER TABLE Manager
	DROP CONSTRAINT age20
END

--EXECUTE version_down2_3

--add a primary key 
ALTER PROCEDURE version_up_4
AS
BEGIN
	ALTER TABLE EH
	ADD CONSTRAINT pk_EH PRIMARY KEY(Eid, Hid)
	print('4\n')
END

EXECUTE version_up_4

--remove a primary key
ALTER PROCEDURE version_down_4
AS
BEGIN
	ALTER TABLE EH
	DROP CONSTRAINT pk_EH
	print('4-4\n')
END

EXECUTE version_down_4

CREATE PROCEDURE version_up_51
AS
BEGIN
	CREATE TABLE Review(
	Rid INT NOT NULL
	CONSTRAINT uk_Review UNIQUE(Rid));
END

EXECUTE version_up_51

--add a candidate key
ALTER PROCEDURE version_up_5
AS
BEGIN
	--EXECUTE version_down_5
	ALTER TABLE Review
	ADD CONSTRAINT uk_Review UNIQUE(Rid)
	print('5\n')
END

EXECUTE version_down_5

--remove a candidate key
ALTER PROCEDURE version_down_5
AS
BEGIN
	--EXECUTE version_up_5
	ALTER TABLE Review
	DROP CONSTRAINT uk_Review
	print('5-5\n')
END

EXECUTE version_down_5

ALTER PROCEDURE version_up_6
AS
BEGIN
	--EXECUTE version_down_6
	ALTER TABLE Hotels
	ADD CONSTRAINT fk_Hotels FOREIGN KEY(Mid) REFERENCES Manager(Mid)
	print('6\n')
END

EXECUTE version_up_6

ALTER PROCEDURE version_down_6
AS
BEGIN
	--EXECUTE version_up_6
	ALTER TABLE Hotels
	DROP CONSTRAINT fk_Hotels
	print('6-6\n')
END

EXECUTE version_down_6

CREATE PROCEDURE version_up_7
AS
BEGIN
	CREATE TABLE Review(
	Rid INT NOT NULL PRIMARY KEY,
	Author varchar(50),
	RDate DATE)
	print('7\n')
END

EXECUTE version_up_7

ALtER PROCEDURE version_down_7
AS
BEGIN
	DROP TABLE Review
END

EXECUTE version_down_7