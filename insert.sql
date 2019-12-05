use TravelAgency4
go

insert into Manager values (34, 'Julia Roberts', 'juliar@hotmail.com', 10)
insert into Transport(Tid, Type, Company) values (22, 'car', 'MagicBus'), (78, 'boat', 'Titanic'), (91, 'subway','HappySubway')
insert into Transport values (13, 'car', 'MysteryCar') 

insert into Employees values (14, 'Emanuel', 10000)
insert into Employees values (21, 'Lorena', 20000)
insert into Employees values (19, 'Georgiana', 30000)
insert into EH values (14, 444)
insert into EH values (21, 469)


INSERT INTO Address(Adid, Country, County, City, Street, Nr) VALUES ( 178, 'Romania', 'Cluj', 'Cluj-Napoca', 'Str. Fantanele', 13)
INSERT INTO Address(Adid, Country, County, City, Street, Nr) VALUES ( 17, 'Romania', 'Cluj', 'Cluj-Napoca', 'Str. Fericirii', 4)
INSERT INTO Manager VALUES (12, 'Paul Popescu', 'paulpopescu@yahoo.com', 3)
INSERT INTO Hotels(Hid, Name, Capacity, NoOfGuests, Mid, Adid) VALUES (469, 'Intercontinental', 200, 147, 12, 178)
--INSERT INTO Hotels(Hid, Name, Capacity, NoOfGuests, Mid, Adid) VALUES (469, 'Intercontinental', 200, 147, 12, 17)
INSERT INTO Customers(Cid, Name, Email) VALUES (100, 'Anastasia Soare', 'anastasias@gmail.com')
INSERT INTO Transport(Type, Company, Tid) VALUES ('aerian', 'BlueAir', 43)
--INSERT INTO Manager VALUES (15, 'Paula Popescu', 'paulapopescu@yahoo.com', 2)
INSERT INTO Manager VALUES (123, 'Audrey Hapburn', 'audreyH@gmail.com', 7)
INSERT INTO Hotels(Hid, Name, Capacity, NoOfGuests, Mid, Adid) VALUES (46, 'Continental', 178, 14, 12, 178)
INSERT INTO Employees(Eid, Name, Salary) VALUES (55, 'Marilyn Monroe', 1000)
INSERT INTO Manager(Mid, Name,Email, NoOfH) VALUES (77, 'Grace Kelly', 'grace2k@gmail.com', 2)
INSERT INTO Hotels(Hid, Name, Capacity, NoOfGuests, Mid, Adid) VALUES (444, 'FSHEGA', 400, 237, 77, 17)

select* from Manager
select* from Hotels