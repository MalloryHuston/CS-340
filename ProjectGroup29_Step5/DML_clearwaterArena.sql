-- READ OPERATIONS
-- ticket_types
-- get all types of tickets
SELECT Ticket_Types.ticket_typeID FROM Ticket_Types;

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
-- get all concerts and all artists and employees within the concert
SELECT Concerts.concertID, Concerts.concertDate, Concerts.numberOfTickets, Artists.name AS artist, Employees.lastName AS employee FROM Concerts
INNER JOIN Concerts_Artists on Concerts_Artists.concertID = Concerts.concertID
INNER JOIN Artists on Concerts_Artists.artistID = Artists.artistID
INNER JOIN Concerts_Employees on Concerts_Employees.concertID = Concerts.concertID
INNER JOIN Employees on Concerts_Employees.employeeID = Employees.employeeID;

-- tickets
-- get all tickets and the corresponding concert, fan, and type of ticket
SELECT Tickets.ticketID, Tickets.duration, Concerts.concertDate AS concert, Fans.email AS fan, Ticket_Types.ticket_typeID AS ticket_type FROM Tickets
INNER JOIN Concerts ON Concerts.concertID = Tickets.concertID
INNER JOIN Fans ON Fans.fanID = Tickets.fanID
INNER JOIN Ticket_Types ON Ticket_Types.ticket_typeID = Tickets.ticket_typeID;

-- filter by concert date
SELECT Concerts.concertDate, Concerts.numberOfTickets, Artists.name FROM Concerts_Artists
SELECT Concerts.concertDate, Concerts.numberOfTickets, Employees.lastName FROM Concerts_Employees
WHERE Concerts.concertDate = :concertdatefilter;


-- CREATE OPERATIONS
-- create a new type of Ticket
INSERT INTO Ticket_Types (Ticket_Types.ticket_typeID) VALUES (:ticket_typeIDInput);

-- create a new Concert
INSERT INTO Concerts (Concerts.concertDate, Concerts.numberOfTickets) VALUES (:concertDateInput, :numberOfTicketsInput);

-- create a new Artist
INSERT INTO Artists (Artists.name, Artists.phoneNumber) VALUES (:nameInput, :phoneNumberInput);

-- create a new Ticket
INSERT INTO Tickets (Tickets.duration, Tickets.concertID, Tickets.fanID, Tickets.ticket_typeID) VALUES (:durationInput, :concertIDFromDropDown, :fanIDFromDropDown, :ticket_typeIDFromDropDown);

-- create a new Employee
INSERT INTO Employees (Employees.firstName, Employees.lastName, Employees.role, Employees.email, Employees.phoneNumber) VALUES (:firstNameInput, :lastNameInput, :roleInput, :emailInput, :phoneNumberInput);

-- create a new Fan
INSERT INTO Fans (Fans.firstName, Fans.lastName, Fans.email, Fans.phoneNumber, Fans.streetAddress, Fans.city, Fans.state, Fans.zipCode) VALUES (:firstNameInput, :lastNameInput, :emailInput, :phoneNumberInput, :streetAddressInput, :cityInput, :stateInput, :zipCodeInput);

-- add an artist to a Concert
INSERT INTO Concerts_Artists (Concerts_Artists.concertID, Concerts_Artists.artistID) VALUES (:concertInput, :artistInput);

-- add an employee to a Concert
INSERT INTO Concerts_Employees (Concerts_Employees.concertID, Concerts_Employees.employeeID) VALUES (:concertInput, :employeeInput);


-- UPDATE OPERATIONS
-- update a fan
UPDATE Fans
    SET firstName = :firstNameInput, lastName = :lastNameInput, email = :emailInput, phoneNumber = :phoneNumberInput, streetAddress = :streetAddressInput, city = :cityInput, state = :stateInput, zipCode = :zipCodeInput
    WHERE fanID = :selectedFanID;


-- DELETE OPERATIONS
-- delete an employee from a concert
DELETE FROM Concerts_Employees WHERE concertID = :selectedConcert AND employeeID = :selectedEmployee;
 
-- delete an artist from a concert
DELETE FROM Concerts_Artists WHERE concertID = :selectedConcert AND artistID = :selectedArtist;

-- delete an entire concert from the Concerts table, all associated entries in both the Concerts_Artists and Concerts_Employees tables should be deleted by CASCADE
DELETE FROM Concerts
WHERE concertID = :selectedConcert;


-- set a category in a ticket to be null
UPDATE Tickets
    SET Tickets.ticket_typeID = NULL
    WHERE Tickets.ticketID = :selectedTicketID;
