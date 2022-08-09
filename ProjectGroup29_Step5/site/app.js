/*
    SETUP
*/

// Express
var express = require('express');   // We are using the express library for the web server
var app     = express();            // We need to instantiate an express object to interact with the server in our code
app.use(express.json());
app.use(express.urlencoded({extended: true}))
PORT        = 4200;                // Set a port number at the top so it's easy to change in the future

// Database
var db = require('./database/db-connector');

// Handlebars
const { engine } = require('express-handlebars');
var exphbs = require('express-handlebars');     // Import express-handlebars
app.engine('.hbs', engine({extname: ".hbs"}));  // Create an instance of the handlebars engine to process templates
app.set('view engine', '.hbs');                 // Tell express to use the handlebars engine whenever it encounters a *.hbs file.

app.use(express.static(__dirname + '/public')); // This is needed to allow for the form to use the css style sheet


/*
    ROUTES
*/
app.get('/', function(req, res)
    {
        res.render('index');
    });

// Renders Categories page, querying database to display all Ticket Categories as their categoryID.
app.get('/categories', function(req, res) {
    let query1 = "SELECT Categories.categoryID FROM Categories;";

    db.pool.query(query1, function(error, rows, fields) {
        res.render('categories', {data: rows});
    })
});

// Renders the Artists page, querying the database to display all properties of all artists in the table.
app.get('/artists', function(req, res) {
    let query1 = "SELECT Artists.artistID, Artists.name, Artists.bio FROM Artists;";

    db.pool.query(query1, function(error, rows, fields){
        res.render('artists', {data: rows});
    })
});
 
// Renders the Employees page, querying the database to display all properties of all employees in the table.
app.get('/employees', function(req, res) {
    let query1 = "SELECT * FROM Employees;";
        
    db.pool.query(query1, function(error, rows, fields){
        res.render('employees', {data: rows});
    })
});

// Renders the Fans page, querying the database to display all properties of all fans in the table.
app.get('/fans', function(req, res) {
    let query1 = "SELECT * FROM Fans;";

    db.pool.query(query1, function(error, rows, fields){
        res.render('fans', {data: rows});
    })
});

// Renders the Concerts page, querying the database to display all concerts with the employees within the applicable concerts.
app.get('/concerts', function(req, res) {
    let query1 = ("SELECT Concerts.concertID, Concerts.concertDate, Concerts.numberOfTickets, Concerts.name, Concerts.description, Employees.lastName, Employees.employeeID FROM Concerts INNER JOIN Concerts_Employees on Concerts_Employees.concertID = Concerts.concertID INNER JOIN Employees on Concerts_Employees.employeeID = Employees.employeeID;");
    let query2 = "SELECT * FROM Artists;";
    let query3 = "SELECT * FROM Concerts;";
    let query4 = "SELECT * FROM Employees;";

    db.pool.query(query1, function(error, rows, fields) {
        let concerts_employees = rows;
        db.pool.query(query2, (error, rows, fields) => {
            let artists = rows;
            db.pool.query(query3, (error, rows, fields) => {
                let concerts_only = rows;
                db.pool.query(query4, (error, rows, fields) => {
                    let employees = rows;
                    return res.render('concerts', {data: concerts_employees, artists: artists, concerts_only: concerts_only, employees: employees});
                })
            })
        })
    })
});

// Renders the Tickets page, querying the database to display all tickets and their associated concerts and fans in the table.
app.get('/tickets', function(req, res) {
    let query1 = ("SELECT Tickets.ticketID, Tickets.duration, Tickets.price, Concerts.name AS concert, Fans.email AS fan, Tickets.categoryID AS category FROM Tickets INNER JOIN Concerts ON Concerts.concertID = Tickets.concertID INNER JOIN Fans ON Fans.fanID = Tickets.fanID ORDER BY Tickets.ticketID;");
    let query2 = "SELECT * FROM Concerts;";
    let query3 = "SELECT * FROM Fans;";
    let query4 = "SELECT * FROM Categories;";

    db.pool.query(query1, function(error, rows, fields){
        let tickets = rows;
        db.pool.query(query2, (error, rows, fields) => {
            let concerts = rows;
            db.pool.query(query3, (error, rows, fields) => {
                let fans = rows;
                db.pool.query(query4, (error, rows, fields) => {
                    let categories = rows;
                    return res.render('tickets', {data: tickets, concerts: concerts, categories: categories, fans: fans});
                })
            })
        })
    })
});



/*
    POST ROUTES
*/

// Adds a ticket category to the Categories table based on user input.
app.post('/add-category-form', function (req, res) {
    // Capture the incoming data and parse it back to a JS object
    let data = req.body;

    // Create the query and run it on the database
    let query1 = `INSERT INTO Categories (categoryID) VALUES ('${data['input-categoryID']}' );`;
    db.pool.query(query1, function (error, rows, fields) {

        // Check to see if there is an error
        if (error) {

            // Log the error to the terminal so we know what went wrong and send the visitor an HTTP response 400 indicating it was a bad request.
            console.log(error);
            res.sendStatus(400);
        }

        // If there was no error, we redirect back to our root route, which automatically repopulates the table with our SELECT * FROM Categories and presents it to the screen.
        else {
            res.redirect('/categories');
        }
    })
})

// Adds an artist to the Artists table based on user input.
app.post('/add-artist-ajax', function (req, res) {

    // Capture the incoming data and parse it back to a JS object
    let data = req.body;

    // Create the query and run it on the database
    let query1 = `INSERT INTO Artists (name, bio) VALUES ('${data.name}', '${data.bio}')`;
    db.pool.query(query1, function (error, rows, fields) {

        // Check to see if there is an error
        if (error) {

            // Log the error to the terminal so we know what went wrong and send the visitor an HTTP response 400 indicating it was a bad request.
            console.log(error);
            res.sendStatus(400);
        }

        else {
            // If there was no error, perform a SELECT * on Artists
            query2 = `SELECT * FROM Artists;`;
            db.pool.query(query2, function (error, rows, fields) {

                // If there was an error on the second query, send a 400
                if (error) {

                    // Log the error to the terminal so we know what went wrong, and send the visitor an HTTP response 400 indicating it was a bad request.
                    console.log(error);
                    res.render('/artists')
                    res.sendStatus(400);
                }
                // If all went well, send the results of the query back.
                else {
                    res.send(rows);
                }
            })
        }
    })
});

// Adds an employee to the Employees table based on user input.
app.post('/add-employee-form', function(req, res){

    // Capture the incoming data and parse it back to a JS object
    let data = req.body;

    // Create the query and run it on the database
    query1 = `INSERT INTO Employees (firstName, lastName, role, email, phoneNumber) VALUES ('${data['input-firstName']}', '${data['input-lastName']}', '${data['input-role']}', '${data['input-email']}', '${data['input-phoneNumber']}');`;
    db.pool.query(query1, function(error, rows, fields){

        // Check to see if there was an error
        if (error) {

            // Log the error to the terminal so we know what went wrong, and send the visitor an HTTP response 400 indicating it was a bad request.
            console.log(error);
            res.sendStatus(400);
        }

        // If there was no error, we redirect back to our root route, which automatically runs the SELECT * FROM Employees and
        // presents it on the screen
        else
        {
            res.redirect('/employees');
        }
    })
})

// Adds a fan to the Fans table based on user input.
app.post('/add-fan-form', function(req, res){

    // Capture the incoming data and parse it back to a JS object
    let data = req.body;

    // Create the query and run it on the database
    query1 = `INSERT INTO Fans (firstName, lastName, email, phoneNumber, streetAddress, city, state, zipCode) VALUES ('${data['input-firstName']}', '${data['input-lastName']}', '${data['input-email']}', '${data['input-phoneNumber']}', '${data['input-streetAddress']}', '${data['input-city']}', '${data['input-state']}', '${data['input-zipCode']}');`;
    db.pool.query(query1, function(error, rows, fields){

        // Check to see if there was an error
        if (error) {

            // Log the error to the terminal so we know what went wrong, and send the visitor an HTTP response 400 indicating it was a bad request.
            console.log(error);
            res.sendStatus(400);
        }

        // If there was no error, we redirect back to our root route, which automatically runs the SELECT * FROM Fans and
        // presents it on the screen
        else
        {
            res.redirect('/fans');
        }
    })
})

// Adds a concert to the Concerts table based on user input.
app.post('/add-concert-form', function (req, res) {
    // Capture the incoming data and parse it back to a JS object
    let data = req.body;

    // Create the query and run it on the database
    let query1 = `INSERT INTO Concerts (concertDate, numberOfTickets, name, description, artistID) VALUES ('${data['input-new_concert-concertDate']}', '${data['input-new_concert-numberOfTickets']}', '${data['input-new_concert-name']}', '${data['input-new_concert-description']}', '${data['input-new_concert-artist']}');`;
    db.pool.query(query1, function (error, rows, fields) {

        // Check to see if there was an error
        if (error) {
            console.log(error);
            res.sendStatus(400);
        }

        // If there was no error, we redirect back to our root route (/concerts), which automatically runs the SELECT * FROM Concerts and presents it on the screen.
        else {
            res.redirect('/concerts');
        }
    })
})

// Adds an employee to an existing concert based on user input by adding an entry in the Concerts_Employees table.
app.post('/add-employee_to_concert-form', function (req, res) {
    // Capture the incoming data and parse it back to a JS object
    let data = req.body;

    // Create the query and run it on the database
    let query1 = `INSERT INTO Concerts_Employees (concertID, employeeID) VALUES ('${data['input-existing_concert-concertid']}', '${data['input-existing_concert-employeeid']}');`;
    db.pool.query(query1, function (error, rows, fields) {

        // Check to see if there was an error
        if (error) {
            console.log(error);
            res.sendStatus(400);
        }

        // If there was no error, we redirect back to our root route (/concerts), which automatically runs the SELECT * FROM Concerts and presents it on the screen.
        else {
            res.redirect('/concerts');
        }
    })
})

// Adds a ticket to the Tickets table based on user input.
app.post('/add-ticket-form', function (req, res) {
    // Capture the incoming data and parse it back to a JS object
    let data = req.body;

    // Capture NULL values
    let category = String(data['input-category']);

    // Create the query and run it on the database
    query1 = `INSERT INTO Tickets (duration, price, concertID, fanID, categoryID) VALUES ('${data['input-duration']}', '${data['input-price']}', '${data['input-concert']}', '${data['input-fan']}', '${category}');`;
    db.pool.query(query1, function (error, rows, fields) {

        // Check to see if there was an error
        if (error) {

            // Log the error to the terminal so we know what went wrong, and send the visitor an HTTP response 400 indicating it was a bad request.
            console.log(error);
            res.sendStatus(400);
        }

        // If there was no error, we redirect back to our root route, which automatically runs the SELECT * FROM Tickets and
        // presents it on the screen
        else {
            res.redirect('/tickets');
        }
    })
})



/*
    DELETE ROUTES
*/

// Deletes an employee from the Employees table based on user input.
app.delete('/delete-employee-ajax/', function (req, res, next) {
    console.log('test')
    let data = req.body;
    let employeeID = parseInt(data.employeeID);
    let deleteEmployees = `DELETE FROM Employees WHERE employeeID = ?`;
    console.log('test')
    // Run the 1st query
    db.pool.query(deleteEmployees, [employeeID], function (error, rows, fields) {
        if (error) {
            // Log the error to the terminal so we know what went wrong, and send the visitor an HTTP response 400 indicating it was a bad request.
            console.log(error);
            res.sendStatus(400);
        }
        else {
            res.redirect('/employees');
        }
    })
});

// Deletes an employee from the Concerts_Employees table based on user input.
app.delete('/delete-employee-from-concert-ajax/', function (req, res, next) {
    let data = req.body;
    let concertID = parseInt(data.concertID);
    let employeeID = parseInt(data.employeeID);
    let deleteConcerts_Employees = `DELETE FROM Concerts_Employees WHERE concertID = ? AND employeeID = ?`;

    // Run the 1st query
    db.pool.query(deleteConcerts_Employees, [concertID, employeeID], function (error, rows, fields) {
        if (error) {

            // Log the error to the terminal so we know what went wrong, and send the visitor an HTTP response 400 indicating it was a bad request.
            console.log(error);
            res.sendStatus(400);
        } else {
            res.sendStatus(204);
        }

    })
});



/*
    PUT ROUTES
*/

// Updates an artist in the Artists table based on user input.
app.put('/put-artist-ajax', function (req, res, next) {
    let data = req.body;
    console.log(data)

    let artistID = parseInt(data.artistID)
    console.log(artistID)

    let queryUpdateWorld = `UPDATE Artists
    SET name = ?, bio= ?
    WHERE artistID = ?;`;
    let selectWorld = `SELECT * FROM Artists WHERE artistID = ?`

    // Run the 1st query
    db.pool.query(queryUpdateWorld, [data.name, data.bio, artistID], function (error, rows, fields) {
        if (error) {

            // Log the error to the terminal so we know what went wrong, and send the visitor an HTTP response 400 indicating it was a bad request.
            console.log(error);
            res.sendStatus(400);
        }

        // If there was no error, we run our second query and return that data so we can use it to update the artists'
        // table on the front-end
        else {
            // Run the second query
            db.pool.query(selectWorld, [artistID], function (error, rows, fields) {
                console.log(rows)
                if (error) {
                    console.log(error);
                    res.sendStatus(400);
                } else {
                    res.send(rows);
                }
            })
        }
    })
});

// Updates a ticket in the Tickets table based on user input.
app.put('/put-ticket-ajax', function (req, res, next) {
    let data = req.body;
    console.log(data)

    let ticketID = parseInt(data.ticketID)
    console.log(ticketID)

    let queryUpdateWorld = `
    UPDATE Tickets
    SET categoryID = NULL
    WHERE ticketID = ?;`
    let query1 = (`SELECT Tickets.ticketID, Tickets.duration, Tickets.price, Concerts.name AS concert, Fans.email AS fan, Tickets.categoryID AS category FROM Tickets INNER JOIN Concerts ON Concerts.concertID = Tickets.concertID INNER JOIN Fans ON Fans.fanID = Tickets.fanID ORDER BY Tickets.ticketID;`)

    // Run the 1st query
    db.pool.query(queryUpdateWorld, [ticketID], function (error, rows, fields) {
        if (error) {

            // Log the error to the terminal so we know what went wrong, and send the visitor an HTTP response 400 indicating it was a bad request.
            console.log(error);
            res.sendStatus(400);
        }

        // If there was no error, we run our second query and return that data so we can use it to update the tickets'
        // table on the front-end
        else {
            // Run the second query
            db.pool.query(query1, [ticketID], function (error, rows, fields) {
                console.log(rows)
                if (error) {
                    console.log(error);
                    res.sendStatus(400);
                } else {
                    res.send(rows);
                }
            })
        }
    })
});



/*
    LISTENER
*/
app.listen(PORT, function(){
    console.log('Express started on http://localhost:' + PORT + '; press Ctrl-C to terminate.')
});