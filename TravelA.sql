--Create database TravelAgency4
--go
use TravelAgency4
go

CREATE TABLE Employees(
Eid INT PRIMARY KEY,
Name VARCHAR(50),
Salary INT NOT NULL)

CREATE TABLE Customers(
Cid INT PRIMARY KEY,
Name VARCHAR(50),
Email VARCHAR(50))

CREATE TABLE Agent(
Aid INT PRIMARY KEY,
Name VARCHAR(50),
Email VARCHAR(50),
Phone VARCHAR(50))

CREATE TABLE Address(
Adid INT PRIMARY KEY,
Country VARCHAR(50),
County VARCHAR(50),
City VARCHAR(50),
Street VARCHAR(50),
Nr INT NOT NULL)

CREATE TABLE Transport(
Tid INT PRIMARY KEY,
Type VARCHAR(50),
Company VARCHAR(50))

CREATE TABLE Manager(
Mid INT PRIMARY KEY,
Name VARCHAR(50),
Email VARCHAR(50),
NoOfH INT NOT NULL)

CREATE TABLE Hotels(
Hid INT PRIMARY KEY,
Name VARCHAR(50),
Capacity INT NOT NULL, 
NoOfGuests INT,
Mid INT FOREIGN KEY REFERENCES Manager(Mid),
Adid INT FOREIGN KEY REFERENCES Address(Adid))

CREATE TABLE EH(
Eid INT FOREIGN KEY REFERENCES Employees(Eid),
Hid INT FOREIGN KEY REFERENCES Hotels(Hid),
CONSTRAINT pk_EH PRIMARY KEY (Eid, Hid))

CREATE TABLE Offer(
Oid INT PRIMARY KEY,
Price INT CHECK ( Price >= 100 and Price <= 5000),
Destination VARCHAR(50),
StartDate DATE,
EndDate DATE,
Tid INT FOREIGN KEY REFERENCES Transport(Tid),
Hid INT FOREIGN KEY REFERENCES Hotels(Hid))

CREATE TABLE Payment(
Pid INT PRIMARY KEY,
PayDate DATE,
Cid INT FOREIGN KEY REFERENCES Customers(Cid),
Aid INT FOREIGN KEY REFERENCES Agent(Aid))


CREATE TABLE Booking(
Oid INT FOREIGN KEY REFERENCES Offer(Oid),
Cid INT FOREIGN KEY REFERENCES Customers(Cid),
CONSTRAINT pk_Booking PRIMARY KEY (Oid, Cid))

INSERT INTO Address(Adid, Country, County, City, Street, Nr) VALUES ( 178, 'Romania', 'Cluj', 'Cluj-Napoca', 'Str. Fantanele', 13)
select * from Address
