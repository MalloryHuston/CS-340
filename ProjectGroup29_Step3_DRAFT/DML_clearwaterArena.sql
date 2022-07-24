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
SELECT Fans.fanID, Fans.firstName, Fans.lastName, Fans.email, Fans.phoneNumber, Fans.streetAddress, Fans.city, Fans.state, Fans.zipCode FROM Fans;


-- tickets
-- get all concerts and fans within the tickets
SELECT Tickets.ticketID, Fans.fanID, Concerts.concertID as ticketID FROM Tickets
INNER JOIN Fans on Tickets.ticketID = Fans.fanID
INNER JOIN Concerts on Tickets.ticketID = Concerts.concertID;

-- CREATE OPERATIONS
-- create a new Concert
INSERT INTO Concerts (Concerts.concertDate, Concerts.numberOfTickets) VALUES (:concertDateInput, :numberOfTicketsInput);

-- create a new Artist
INSERT INTO Artists (Artists.name, Artists.artistID, Artists.phoneNumber) VALUES (:nameInput, :artistIDFromDropDown, :phoneNumberInput);

-- create a new Ticket
INSERT INTO Tickets (Tickets.concertID, Tickets.fanID) VALUES (:concertIDInput, :fanIDInput);

-- create a new Employee
INSERT INTO Employees (Employees.firstName, Employees.lastName, Employees.role, Employees.email, Employees.phoneNumber) VALUES (:firstNameInput, :lastNameInput, :roleFromDropDown, :emailInput, :phoneNumberInput);

-- create a new Fan
INSERT INTO Fans (Fans.firstName, Fans.lastName, Fans.email, Fans.phoneNumber, Fans.streetAddress, Fans.city, Fans.state, Fans.zipCode, Fans.concertID) VALUES (:firstNameInput, :lastNameInput, :emailInput, :phoneNumberInput, :streetAddressInput, :cityInput, :stateInput, :zipCodeInput, :concertIDFromDropDown);

-- add a ticket to a Concert
INSERT INTO Tickets (Tickets.concertID, Tickets.ticketID) VALUES (:concertIDInput, :ticketIDInput)

-- UPDATE OPERATIONS
-- update a fan
UPDATE Fans
    SET firstName = :firstNameInput, lastName = :lastNameInput, email = :emailInput, streetAddress = :streetAddressInput, city = :cityInput, state = :stateInput, zipCode = :zipCodeInput, concertID = :concertIDInput
    WHERE fanID = :selectedFanID
    
-- UPDATE OPERATIONS
-- update an employee
UPDATE Employees
    SET firstName = :firstNameInput, lastName = :lastNameInput, role = :roleInput, phoneNumber = :phoneNumberInput
    WHERE employeeID = :selectedEmployeeID

-- DELETE OPERATIONS
-- delete a ticket from a concert
DELETE FROM Tickets WHERE
    (
        SELECT Concerts.concertID FROM Tickets
        WHERE concertID = :selectedConcert AND ticketID = :selectedTicket
    )
