-- READ OPERATIONS
-- categories
-- get all types of ticket categories
SELECT Categories.categoryID FROM Categories;

-- employees
-- get all employees
SELECT * FROM Employees;

-- fans
-- get all fans
SELECT * FROM Fans;

-- artists
-- get all artists
SELECT Artists.artistID, Artists.name, Artists.bio FROM Artists;

-- concerts
-- get all concerts and all employees within the concert
SELECT Concerts.concertID, Concerts.concertDate, Concerts.numberOfTickets, Concerts.name, Concerts.description, Employees.lastName FROM Concerts
INNER JOIN Concerts_Employees on Concerts_Employees.concertID = Concerts.concertID
INNER JOIN Employees on Concerts_Employees.employeeID = Employees.employeeID;

-- tickets
-- get all tickets and the corresponding concert, fan, and type of ticket category
SELECT Tickets.ticketID, Tickets.duration, Concerts.name AS concert, Fans.email AS fan, Categories.categoryID AS category FROM Tickets
INNER JOIN Concerts ON Concerts.concertID = Tickets.concertID
INNER JOIN Fans ON Fans.fanID = Tickets.fanID
INNER JOIN Categories ON Categories.categoryID = Tickets.categoryID;

-- filter by concert name
SELECT Concerts.name, Concerts.concertDate, Concerts.description, Artists.name FROM Concerts_Employees
WHERE Concerts.name = :concertnamefilter;


-- CREATE OPERATIONS
-- create a new type of Ticket Category
INSERT INTO Categories (Categories.categoryID) VALUES (:categoryIDInput);

-- create a new Concert
INSERT INTO Concerts (Concerts.concertDate, Concerts.numberOfTickets, Concerts.name, Concerts.description, Concerts.artistID) VALUES (:concertDateInput, :numberOfTicketsInput, :nameInput, :descriptionInput, :artistIDFromDropDown);

-- create a new Artist
INSERT INTO Artists (Artists.name, Artists.bio) VALUES (:nameInput, :bioInput);

-- create a new Ticket
INSERT INTO Tickets (Tickets.duration, Tickets.price, Tickets.concertID, Tickets.fanID, Tickets.categoryID) VALUES (:durationInput, :priceInput, :concertIDFromDropDown, :fanIDFromDropDown, :categoryIDFromDropDown);

-- create a new Employee
INSERT INTO Employees (Employees.firstName, Employees.lastName, Employees.role, Employees.email, Employees.phoneNumber) VALUES (:firstNameInput, :lastNameInput, :roleInput, :emailInput, :phoneNumberInput);

-- create a new Fan
INSERT INTO Fans (Fans.firstName, Fans.lastName, Fans.email, Fans.phoneNumber, Fans.streetAddress, Fans.city, Fans.state, Fans.zipCode) VALUES (:firstNameInput, :lastNameInput, :emailInput, :phoneNumberInput, :streetAddressInput, :cityInput, :stateInput, :zipCodeInput);

-- add an employee to a Concert
INSERT INTO Concerts_Employees (Concerts_Employees.concertID, Concerts_Employees.employeeID) VALUES (:concertInput, :employeeInput);


-- UPDATE OPERATIONS
-- update an artist
UPDATE Artists
    SET name = :nameInput, bio = :bioInput
    WHERE artistID = :selectedArtistID;


-- DELETE OPERATIONS
-- delete an employee from a concert
DELETE FROM Concerts_Employees WHERE concertID = :selectedConcert AND employeeID = :selectedEmployee;

-- delete an entire concert from the Concerts table, all associated entries in the Concerts_Employees table should be deleted by CASCADE
DELETE FROM Concerts
WHERE concertID = :selectedConcert;


-- set a category in a ticket to be null
UPDATE Tickets
    SET Tickets.categoryID = NULL
    WHERE Tickets.ticketID = :selectedTicketID;
