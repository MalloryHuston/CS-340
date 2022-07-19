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


-- concerts_has_artists
-- get all concerts and the corresponding artists
SELECT Concerts.concertID, Artists.artistID as artist from Concerts
Inner JOIN Artists ON Concerts.concertID = Artists.artistID;

-- concerts_has_employees
-- get all concerts and the corresponding employees
SELECT Concerts.concertID, Employees.employeeID as employee from Concerts
Inner JOIN Artists ON Concerts.concertID = Employees.employeeID;

-- employees
-- get all employees
SELECT Employees.employeeID, Employees.firstName, Employees.lastName, Employees.role, Employees.email, Employees.phoneNumber FROM Employees;

-- fans
-- get all fans
SELECT Fans.fanID, Fans.firstName, Fans.lastName, Fans.email, Fans.phoneNumber, Fans.streetAddress, Fans.city, Fans.state, Fans.zipCode, Fans.concertID FROM Fans;


-- playlists
-- get all playlists and all songs within the playlist
SELECT Playlists.name, Playlists.streams, Playlists.description, Customers.username as user FROM Playlists_Songs
INNER JOIN Playlists on Playlists_Songs.playlistID = Playlists.playlistID
INNER JOIN Customers on Customers.customerID = Playlists.customerID;

-- CREATE OPERATIONS
-- create a new genre
INSERT INTO Genres (Genres.genreID) VALUES (:genreIdInput);

-- create a new Artist
INSERT INTO Artists (Artists.name, Artists.bio) VALUES (:nameInput, :bioInput);

-- create a new Album
INSERT INTO Albums (Albums.title, Albums.description, Albums.artistID) VALUES (:titleInput, :descriptionInput, :artistIDFromDropDown);

-- create a new Song
INSERT INTO Songs (Songs.title, Songs.duration, Songs.albumID, Songs.artistID, Songs.genreID) VALUES (:titleInput, :durationInput, :albumIDFromDropDown, :artistIDFromDropDown, :genreIDFromDropDown);

-- create a new Customer
INSERT INTO Customers (Customers.username, Customers.password, Customers.email, Customers.isPremium) VALUES (:usernameInput, :passwordInput, :emailInput, :isPremiumInput);

-- create a new Playlist
INSERT INTO Playlists (Playlists.name, Playlists.description, Playlists.customerID) VALUES (:nameInput, :descriptionInput, :customerIDFromDropDown);

-- add a song to a Playlist
INSERT INTO Playlists_Songs (Playlists_Songs.playlistID, Playlists_Songs.songID) VALUES (:playlistInput, :songInput)

-- UPDATE OPERATIONS
-- update a customer
UPDATE Customers
    SET username = :usernameInput, password = :passwordInput, email = :emailInput, isPremium = :isPremiumInput
    WHERE customerID = :selectedCustomerID

-- DELETE OPERATIONS
-- delete a song from a playlist
DELETE FROM Playlists_Songs WHERE
    (
        SELECT playlist_songID FROM Playlists_Songs
        WHERE playlistID = :selectedPlaylist AND songID = :selectedSong
    )