-- These are some Database Manipulation queries for a partially implemented Project Website 
-- using the Clearwater Arena database.
-- Your submission should contain ALL the queries required to implement ALL the
-- functionalities listed in the Project Specs.

-- CREATE OPERATIONS
-- create a new Concert
INSERT INTO Concerts (Concerts.concertDate, Concerts.numberOfTickets) VALUES (:concertDateInput, :numberOfTicketsInput);

-- create a new Artist
INSERT INTO Artists (Artists.name, Artists.phoneNumber) VALUES (:nameInput, :phoneNumberInput);

-- create a new Ticket
INSERT INTO Tickets (Tickets.concertID, Tickets.fanID) VALUES (:concertIDFromDropDown, :fanIDFromDropDown);

-- create a new Employee
INSERT INTO Employees (Employees.firstName, Employees.lastName, Employees.role, Employees.email, Employees.phoneNumber) VALUES (:firstNameInput, :lastNameInput, :roleInput, :emailInput, :phoneNumberInput);

-- create a new Fan
INSERT INTO Fans (Fans.firstName, Fans.lastName, Fans.email, Fans.phoneNumber, Fans.streetAddress, Fans.city, Fans.state, Fans.zipCode) VALUES (:firstNameInput, :lastNameInput, :emailInput, :phoneNumberInput, :streetAddressInput, :cityInput, :stateInput, :zipCodeInput);

-- add a ticket to a Concert
INSERT INTO Tickets (Tickets.concertID, Tickets.ticketID) VALUES (:concertInput, :ticketInput)


-- READ OPERATIONS
-- artists
-- get all artists
SELECT * FROM Artists;

-- employees
-- get all employees
SELECT * FROM Employees;

-- fans
-- get all fans
SELECT * FROM Fans;

-- concerts
-- get all concerts
SELECT * FROM Concerts;

-- concerts_has_artists
-- get all concerts and the corresponding artists and employees
SELECT Concerts.concertID, Artists.artistID AS artist from Concerts
INNER JOIN Artists ON 
SELECT Concerts.concertID, Concerts.concertDate, Concerts.numberOfTickets, Artists.artistID, Artists.name AS artist FROM Concerts_has_Artists
SELECT Concerts.concertID, Concerts.concertDate, Concerts.numberOfTickets, Employees.employeeID, Employees.firstName, Employees.lastName AS employee FROM Concerts_has_Employees
INNER JOIN Artists ON Concerts_has_Artists.artistID = Artists.artistID
INNER JOIN Concerts ON Concerts_has_Artists.concertID = Concerts.concertID
INNER JOIN Employees ON Concerts_has_Employees.employeeID = Employees.employeeID
INNER JOIN Concerts ON Concerts_has_Employees.concertID = Concerts.concertID;

-- tickets
-- get all tickets and the corresponding concerts and fans
SELECT Tickets.ticketID, Tickets.concertID, Concerts.concertID, Concerts.concertDate, Concerts.numberOfTickets AS concert FROM Tickets
SELECT Tickets.ticketID, Tickets.fanID, Fans.fanID, Fans.firstName, Fans.lastName AS fan FROM Tickets
INNER JOIN Concerts ON Tickets.concertID = Concerts.concertID
INNER JOIN Fans ON Tickets.fanID = Fans.fanID;

-- filter by artist name
SELECT Artists.name, Concerts.concertDate, Concerts.numberOfTickets FROM Concerts_has_Artists
WHERE Artists.name = :artistnamefilter;


-- UPDATE OPERATIONS
-- update a fan
UPDATE Fans
    SET firstName = :firstNameInput, lastName = :lastNameInput, email = :emailInput, streetAddress = :streetAddressInput, city = :cityInput, state = :stateInput, zipCode = :zipCodeInput
    WHERE fanID = :selectedFanID
    
-- update an employee
UPDATE Employees
    SET firstName = :firstNameInput, lastName = :lastNameInput, role = :roleInput, email = :emailInput, phoneNumber = :phoneNumberInput
    WHERE employeeID = :selectedEmployeeID
    
-- update an artist
UPDATE Artists
    SET name = :nameInput, phoneNumber = :phoneNumberInput
    WHERE artistID = :selectedArtistID


-- DELETE OPERATIONS
-- delete a ticket from a concert
DELETE FROM Tickets WHERE
    (
        SELECT Tickets.concertID FROM Tickets
        WHERE concertID = :selectedConcert AND ticketID = :selectedTicket
    )

-- delete an employee from a concert
DELETE FROM Concerts_has_Employees WHERE
    (
        SELECT Employees.employeeID FROM Concerts_has_Employees
        WHERE concertID = :selectedConcert AND employeeID = :selectedEmployee
    )
 
-- delete an artist from a concert
DELETE FROM Concerts_has_Artists WHERE
    (
        SELECT Artists.artistID FROM Concerts_has_Artists
        WHERE concertID = :selectedConcert AND artistID = :selectedArtist
    )
