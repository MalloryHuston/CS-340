-- These are some Database Manipulation queries for a partially implemented Project Website 
-- using the Clearwater Arena database.
-- Your submission should contain ALL the queries required to implement ALL the
-- functionalities listed in the Project Specs.


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

-- concerts_has_artists
-- get all concerts_has_artists
SELECT Concerts.concertID, Artists.artistID AS artist FROM Concerts
INNER JOIN Artists ON Concerts.concertID = Artists.artistID;

-- concerts_has_employees
-- get all concerts_has_employees
SELECT Concerts.concertID, Employees.employeeID AS employee FROM Concerts
INNER JOIN Employees ON Concerts.concertID = Employees.employeeID;

-- concerts
-- get all concerts and the corresponding artists and employees
SELECT Concerts.concertID, Concerts.concertDate, Concerts.numberOfTickets, Artists.name AS artist FROM Concerts
SELECT Concerts.concertID, Concerts.concertDate, Concerts.numberOfTickets, Employees.firstName, Employees.lastName AS employee FROM Concerts
INNER JOIN Artists ON Concerts.concertID = Artists.artistID
INNER JOIN Employees ON Concerts.concertID = Employees.employeeID;

-- tickets
-- get all tickets and the corresponding artists and fans
SELECT Tickets.ticketID, Tickets.concertID, Artists.name AS artist FROM Tickets
SELECT Tickets.ticketID, Tickets.fanID, Fans.firstName, Fans.lastName AS fan FROM Tickets
INNER JOIN Artists ON Tickets.concertID = Artists.artistID
INNER JOIN Fans ON Tickets.ticketID = Fans.fanID;


-- CREATE OPERATIONS
-- create a new Concert
INSERT INTO Concerts (Concerts.concertDate, Concerts.numberOfTickets) VALUES (:concertDateInput, :numberOfTicketsInput);

-- create a new Artist
INSERT INTO Artists (Artists.name, Artists.phoneNumber) VALUES (:nameInput, :phoneNumberInput);

-- create a new Ticket
INSERT INTO Tickets (Tickets.concertID, Tickets.fanID) VALUES (:concertIDInput, :fanIDInput);

-- create a new Employee
INSERT INTO Employees (Employees.firstName, Employees.lastName, Employees.role, Employees.email, Employees.phoneNumber) VALUES (:firstNameInput, :lastNameInput, :roleInput, :emailInput, :phoneNumberInput);

-- create a new Fan
INSERT INTO Fans (Fans.firstName, Fans.lastName, Fans.email, Fans.phoneNumber, Fans.streetAddress, Fans.city, Fans.state, Fans.zipCode) VALUES (:firstNameInput, :lastNameInput, :emailInput, :phoneNumberInput, :streetAddressInput, :cityInput, :stateInput, :zipCodeInput);

-- add a ticket to a Concert
INSERT INTO Tickets (Tickets.concertID, Tickets.ticketID) VALUES (:concertIDInput, :ticketIDInput)


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
DELETE FROM Employees WHERE
    (
        SELECT Employees.employeeID FROM Concert_has_Employees
        WHERE concertID = :selectedConcert AND employeeID = :selectedEmployee
    )
 
-- delete an artist from a concert
DELETE FROM Artists WHERE
    (
        SELECT Artists.artistID FROM Concert_has_Artists
        WHERE concertID = :selectedConcert AND artistID = :selectedArtist
    )

