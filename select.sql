use TravelAgency4
go

select * from Address
select * from Agent
select * from Customers
select * from Hotels
select * from Employees
select * from EH
select * from Manager
select * from Transport

--union
--it selects the hotels whose names start with I or have the capacity greater than 180 people
SELECT h1.Hid, h1.Name FROM Hotels h1
WHERE Name like 'I_%'
UNION
SELECT h2.Hid, h2.Name FROM Hotels h2
WHERE Capacity >= 180

--selects the managers whose names start with G or who have No Of Hotels between 2 and 5
SELECT * FROM Manager
WHERE Name like 'G_%'
UNION
SELECT * FROM Manager
WHERE NoOfH BETWEEN 2 AND 5
ORDER BY Name Desc

--intersect
--selects all the managers whose id is smaller than 100 and number of hotels is 2,5,7 or 9, and orders the result by name
SELECT m1.Name FROM Manager m1
WHERE Mid <= 100
INTERSECT 
SELECT m2.Name FROM Manager m2
WHERE NoOfH IN ( 2, 5, 7, 9)
ORDER BY m1.Name

--selects the first hotel which has the number of guests greater than 100 and the capacity between 180 and 500, being ordered by name
SELECT TOP 1 h1.Hid, h1.Name, h1.Capacity FROM Hotels h1
WHERE NoOfGuests >= 100
INTERSECT 
SELECT h2.Hid, h2.Name, h2.Capacity FROM Hotels h2
WHERE Capacity BETWEEN 180 AND 500
ORDER BY h1.Name

--except
--selects all the hotels which have the number of guests greater than 50 except those which have the capacity smaller than 210, and orders them by name
SELECT h1.Name FROM Hotels h1
WHERE NoOfGuests >= 50
EXCEPT 
SELECT h2.Name FROM Hotels h2
WHERE Capacity <= 210
ORDER BY h1.Name

--selects (the first) managers whose mid is greater than 10 except those whose number of hotels is 3, 56 or 42 
SELECT TOP 1 m1.Name, m1.Email FROM Manager m1
WHERE Mid > 10
EXCEPT 
SELECT m2.Name, m2.Email FROM Manager m2
WHERE NoOfH IN ( 3, 56, 42)

--inner join, left join, right join and full join

select * 
from Manager m INNER JOIN Hotels h ON
m.Mid = h.Mid

select *
from Manager m LEFT OUTER JOIN Hotels h ON 
m.Mid = h.Mid

select *
from Manager m RIGHT OUTER JOIN Hotels h ON
m.Mid = h.Mid

select *
from Manager m FULL OUTER JOIN Hotels h ON
m.Mid = h.Mid

select * from Hotels
select * from Employees
select * from EH

select *
from Employees e 
INNER JOIN EH eh ON e.Eid = eh.Eid
INNER JOIN Hotels h ON eh.Hid = h.Hid

--e)
--selects all the distinct hotels which have the number of guests greater than 10 and the mid is in the manager table as well
SELECT DISTINCT h.Mid --,h.Name
FROM Hotels h
WHERE NoOfGuests > 10 and h.Mid IN ( SELECT m.Mid FROM Manager m)

--selects all the employees who have the salary greater than 500 and who work at a hotel which has the number of guests greater than 100 
SELECT e.Eid, e.Name
FROM Employees e
WHERE Salary > 5000 and e.Eid IN 
	(SELECT eh.Eid 
	FROM EH eh
	WHERE eh.Hid IN 
		(SELECT h.Hid 
		 FROM Hotels h
		 WHERE NoOfGuests > 100))

--exists
--selects all the managers whose mid is greater than 3 and mid exists in the Hotels table as well
SELECT m.Mid, m.Name
FROM Manager m
WHERE Mid > 3 and EXISTS (SELECT * FROM Hotels h
							WHERE h.Mid = m.Mid)

--selects all the employees whose salary is greater than 3500 and whose eid exists in the EH table as well
SELECT e.Eid, e.Name
FROM Employees e
WHERE Salary > 3500 and EXISTS (SELECT * FROM EH eh
								WHERE eh.Eid = e.Eid)

--g
--selects all the managers who work in hotels with more than 100 guests 
SELECT H.Mid, H.Name
FROM (SELECT m.Mid, m.Name, h.NoOfGuests 
	  FROM Manager m INNER JOIN Hotels h ON m.Mid=h.Mid
	  WHERE NoOfGuests > 100) H

--selects all the employees(showing the eid and the hid(hotel id)) who have a salary greater than 10000
SELECT E.Eid, E.Hid
FROM (SELECT h.Eid, h.Salary, m.Hid
	  FROM Employees h INNER JOIN EH m ON h.Eid=m.Eid
	  WHERE Salary > 10000) E

--h
--selects all the hotels who have an mid which is also in the hotel table, grouping them by mid and name
SELECT h.Mid, h.Name
FROM Hotels h INNER JOIN Manager m ON
h.Mid = m.Mid
GROUP BY h.Mid, h.Name

--selects all the managers whose hotels have an AVG(number of guests) smaller than 200
SELECT m.Mid, AVG(h.NoOfGuests)
FROM Manager m INNER JOIN Hotels h ON
m.Mid = h.Mid
GROUP BY m.Mid
HAVING AVG(h.NoOfGuests) < 200 

--selects all the hotels (showing the mid, the name and the hid) which have employees with salary greater than 10000
SELECT h.Mid, h.Name, h.Hid
FROM Hotels h INNER JOIN Manager m ON
h.Mid = m.Mid
GROUP BY h.Mid, h.Name, h.Hid
HAVING h.Hid IN (SELECT eh.hid FROM EH eh INNER JOIN 
				 Employees e ON eh.Eid = e.Eid
				 WHERE e.Salary > 10000)

--selects all the hotels which are not in a country which start with the letter R
SELECT h.Adid, h.Name, (h.Mid + 2) * 10
FROM Hotels h INNER JOIN Manager m ON
h.Mid = m.Mid
GROUP BY h.Mid, h.Name, h.Adid
HAVING h.Adid NOT IN (SELECT a.Adid FROM Address a
					  WHERE Country LIKE 'R_%')

--i
--selects all the hotels which have the number of guests greater than the maximum number of guests
SELECT h.Name, h.NoOfGuests
FROM Hotels h
WHERE h.NoOfGuests > ALL(SELECT h1.NoOfGuests
                         FROM Hotels h1
						 WHERE h.Hid = h1.Hid)

--selects all the hotels which have the number of guests greater than the maximum number of guests
SELECT h.Name, h.NoOfGuests
FROM Hotels h
WHERE h.NoOfGuests>(SELECT MAX(h1.NoOfGuests)
					FROM Hotels h1
					WHERE h1.Hid = h.Hid)

--selects all the transports(showing a different column which computes an arithmetic operation) which have equals Tid 
SELECT t.Company, (t.Tid - 3) * 4
FROM Transport t
WHERE t.Tid = ANY(SELECT t1.Tid
                   FROM Transport t1
				   WHERE t1.Tid = t.Tid)

--selects all the transports(showing a different column which computes an arithmetic operation) which have equals Tid 
SELECT t.Company, (t.Tid + 12)/3
FROM Transport t
WHERE t.Tid IN (SELECT t1.Tid 
				FROM Transport t1
				WHERE t1.Tid = t.Tid)

--selects all the distinct addresses which don't have a number equal to 2,3,4 or 5 
select DISTINCT a.County
FROM Address a
WHERE  Nr NOT IN (2,3,4,5)

--selects all the distinct transports in which the company starts with letter M or with letter B
select DISTINCT t.Type
FROM Transport t
WHERE Company Like 'M_%' OR Company Like 'B_%'

