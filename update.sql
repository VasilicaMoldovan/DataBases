use TravelAgency4
go 

--updates all the addresses where the country starts with R and number is smaller than 10, setting the country to Germany  
UPDATE Address
SET Country='Germany'
WHERE Country Like 'R%' AND Nr < 10
select * from Address

--updates all the managers whose number of hotels is between 2 and 6, setting the name to Good Manager
UPDATE Manager
SET Name='Good Manager'
WHERE NoOfH > 2 AND NoOfH <= 6
select * from Manager

--updates all the hotels whose number of guests is 2, 7, 147 or 25, setting the capacity to 333
UPDATE Hotels
SET Capacity=333
WHERE NoOfGuests IN (2, 7, 147, 25)
select * from Hotels