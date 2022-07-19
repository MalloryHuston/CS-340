-- These are some Database Manipulation queries for a partially implemented Project Website 
-- using the Clearwater Arena database.
-- Your submission should contain ALL the queries required to implement ALL the
-- functionalities listed in the Project Specs.

-- READ OPERATIONS
-- concerts
-- get all concerts
SELECT * FROM Concerts;

-- artists
-- get all artists
SELECT * FROM Artists;

-- tickets
-- get all tickets
SELECT * FROM Tickets;


-- concerts_has_artists
-- get all concerts and the corresponding artists
SELECT Concerts.concertID, Artists.artistID as artist from Concerts
Inner JOIN Artists ON Concerts.concertID = Artists.artistID;

-- concerts_has_employees
-- get all concerts and the corresponding employees
SELECT Concerts.concertID, Employees.employeeID as employee from Concerts
Inner JOIN Employees ON Concerts.concertID = Employees.employeeID;

-- employees
-- get all employees
SELECT Employees.employeeID, Employees.firstName, Employees.lastName, Employees.role, Employees.email, Employees.phoneNumber FROM Employees;

-- fans
-- get all fans
SELECT Fans.fanID, Fans.firstName, Fans.lastName, Fans.email, Fans.phoneNumber, Fans.streetAddress, Fans.city, Fans.state, Fans.zipCode, Fans.concertID FROM Fans;


-- tickets
-- get all concerts and fans within the tickets
SELECT Tickets.ticketID, Fans.fanID, Concerts.concertID as ticketID FROM Tickets
INNER JOIN Fans on Tickets.ticketID = Fans.fanID
INNER JOIN Concerts on Tickets.ticketID = Concerts.concertID;

-- CREATE OPERATIONS
-- create a new Concert
INSERT INTO Genres (Genres.genreID) VALUES (:genreIdInput);

-- create a new Artist
INSERT INTO Artists (Artists.name, Artists.bio) VALUES (:nameInput, :bioInput);

-- create a new Ticket
INSERT INTO Albums (Albums.title, Albums.description, Albums.artistID) VALUES (:titleInput, :descriptionInput, :artistIDFromDropDown);

-- create a new Employee
INSERT INTO Songs (Songs.title, Songs.duration, Songs.albumID, Songs.artistID, Songs.genreID) VALUES (:titleInput, :durationInput, :albumIDFromDropDown, :artistIDFromDropDown, :genreIDFromDropDown);

-- create a new Fan
INSERT INTO Customers (Customers.username, Customers.password, Customers.email, Customers.isPremium) VALUES (:usernameInput, :passwordInput, :emailInput, :isPremiumInput);

-- add a ticket to a Concert
INSERT INTO Tickets (Concerts.concertID, Tickets.ticketID) VALUES (:concertInput, :ticketInput)

-- UPDATE OPERATIONS
-- update a fan
UPDATE Fans
    SET username = :usernameInput, password = :passwordInput, email = :emailInput, isPremium = :isPremiumInput
    WHERE customerID = :selectedCustomerID
    
-- UPDATE OPERATIONS
-- update an employee
UPDATE Employees
    SET username = :usernameInput, password = :passwordInput, email = :emailInput, isPremium = :isPremiumInput
    WHERE customerID = :selectedCustomerID

-- DELETE OPERATIONS
-- delete a ticket from a concert
DELETE FROM Tickets WHERE
    (
        SELECT Concerts.concertID FROM Tickets
        WHERE concertID = :selectedConcert AND ticketID = :selectedTicket
    )
