--Create tables regarding car rental company--

CREATE TABLE Clients (c_id INTEGER PRIMARY KEY,first_name VARCHAR(32) NOT NULL,last_name VARCHAR(32) NOT NULL, client_rating INTEGER, age INTEGER,country VARCHAR(32));

CREATE TABLE Cars (car_id INTEGER PRIMARY KEY,model VARCHAR(32) NOT NULL,type VARCHAR(16));

CREATE TABLE Reserves (c_id INTEGER ,car_id INTEGER ,reservation_date DATE,PRIMARY KEY (c_id, car_id, reservation_date),FOREIGN KEY (c_id) REFERENCES Clients(c_id),FOREIGN KEY (car_id) REFERENCES Cars(car_id));

--Insert some values into the table Clients--

INSERT INTO Clients (c_id, first_name,last_name, client_rating, age,country) VALUES
(1, 'George','Dustin', 7, 45,'England'),
(2, 'Nick','Smith', 10, 32,'England'),
(3, 'John','Melt', 5, 35,'America'),
(4, 'Dionisis','Johnson', 8, 18,'Greece'),
(5,'Maria','Papadopoulou',9,25,'Greece'),
(6,'Maria','Andrew',5,29,'Cyprus'),
(7,'Alfreds','Futterkiste',10,25,'Germany'),
(8,'Lebron','Williams',10,33,'America'),
(9,'Mariah','Alexopoulos',10,50,'Greece'),
(10,'George','Luce',4,27,'Canada');

-- Display all the fields available in the table Clients--

SELECT * FROM Clients; 

--Find the average age of the clients--
SELECT AVG(age) AS average_age FROM clients; 

--Find the number of clients coming from each country--
SELECT country,COUNT(*) AS number_of_clients 
FROM Clients
GROUP BY country;

-- Find the clients coming from Greece--
SELECT c_id, first_name,last_name 
FROM Clients 
WHERE country='Greece'; 

-- Find the clients coming from England or America--
SELECT c_id, first_name,last_name 
FROM Clients 
WHERE country IN ('England','America');

-- Find the clients whose age is greater than the average age--
SELECT c_id, first_name,last_name 
FROM Clients 
WHERE age>(      
          SELECT AVG(age) 
          FROM Clients
          );


--Find the clients with rating 10--
SELECT first_name,last_name FROM clients    
WHERE client_rating=10;


-- Display the minimum age per rating--
SELECT  client_rating, MIN(age) AS minimum_age 
FROM Clients
GROUP BY client_rating;

--Insert some values into the table Cars--

INSERT INTO Cars (car_id,model, type) VALUES
(101, 'Audi R8 V10', 'gasoline'),
(102, 'Audi Q4 e-Tron', 'electric'),
(103, 'Toyota Yaris', 'hydrid'),
(104, 'Ford Fiesta', 'gasoline'),
(105, 'Aston Martin DBX707', 'gasoline'),
(106, 'Tesla model X', 'electric'),
(107,'FERRARI 812 GTS','gasoline'),
(108,'Jaguar F type','gasoline');

-- Number of cars per type--
SELECT type ,COUNT(type) AS number_of_cars
FROM Cars    
GROUP BY type
ORDER BY number_of_cars;


--Insert some values into the table Reserves--

INSERT INTO Reserves (c_id, car_id, reservation_date) VALUES
(1, 101, '2021-10-10'),
(1, 102, '2021-10-10'),
(1, 101, '2021-10-7'),
(2, 102, '2021-11-9'),
(2, 102, '2021-7-11'),
(3, 101, '2021-7-11'),
(3, 102, '2021-7-8'),
(4, 103, '2021-9-19'),
(4, 106, '2021-9-25'),
(9, 105, '2021-9-19'),
(9,108,'2021-9-24'),
(10,102,'2021-8-20');



--Display the first name and last name of the clients that reserved car with id 101--
SELECT C.first_name,C.last_name 
FROM Clients C, Reserves R
WHERE R.c_id = C.c_id
AND R.car_id = 101;

--The average age of clients that reserved Audi R8--
SELECT model,AVG(age) AS average_age 
FROM Clients C,Cars,Reserves R
WHERE Cars.car_id=R.car_id
AND R.c_id=C.c_id
AND Cars.model='Audi R8 V10'
GROUP BY model;

--Clients that reserved Audi Q4 or tesla model X--
SELECT DISTINCT first_name,last_name,model    
FROM Clients C,Reserves R, Cars
WHERE C.c_id=R.c_id
AND Cars.car_id=R.car_id
AND Cars.model IN ('Audi Q4 e-Tron','Tesla model X');

--Find the model and car id of the cars reserved for at least 2 times--
SELECT  C.car_id,C.model 
FROM Cars C,Reserves R
WHERE C.car_id=R.car_id
GROUP BY C.car_id
HAVING COUNT(*)>=2;

-- Display for each car the reservation date --
SELECT model,reservation_date       
FROM Cars c
INNER JOIN Reserves r ON c.car_id=r.car_id
ORDER BY reservation_date;