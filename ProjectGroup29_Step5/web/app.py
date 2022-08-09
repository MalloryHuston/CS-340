from flask import Flask, render_template
from flask import request, redirect
from flask_mysqldb import MySQL
from database.db_credentials import host, user, passwd, db
from database.db_connector import connect_to_database, execute_query
import os

app = Flask(__name__)

app.config['MYSQL_HOST'] = host
app.config['MYSQL_USER'] = user
app.config['MYSQL_PASSWORD'] = passwd
app.config['MYSQL_DB'] = db

mysql = MySQL(app)


# Routes
@app.route('/')
def home():
    db_connection = connect_to_database()

    query1 = "SELECT * FROM Employees;"
    query2 = "SELECT * FROM Artists;"
    query3 = "SELECT * FROM Fans;"
    
    employees = execute_query(db_connection, query1).fetchall()
    artists = execute_query(db_connection, query2).fetchall()
    fans = execute_query(db_connection, query3).fetchall()

    return render_template("/home.html", employee = employees, artist = artists, fan = fans)

@app.route('/add-employee/', methods=['POST', 'GET'])
def add_employee():
    db_connection = connect_to_database()

    if request.method == 'GET':
        query = 'SELECT * from Employees;'
        result = execute_query(db_connection, query).fetchall()
        return render_template("/employees_page.html", res = result)

    elif request.method == 'POST':
        f_name = request.form['fname']
        l_name = request.form['lname']
        role = request.form['role']
        email = request.form['email']
        phone_number = request.form['phone_number']

        query = 'INSERT INTO Employees (firstName, lastName, role, email, phoneNumber) VALUES (f_name, l_name, email, phone_number)'
        execute_query(db_connection, query)
        return("/home")
        


@app.route('/add-artist/', methods=['POST', 'GET'])
def add_artist():
    db_connection = connect_to_database()
    if request.method == 'GET':
        query = 'SELECT * from Artists;'
        result = execute_query(db_connection, query).fetchall()
        return render_template("/artists_page.html", res = result)

    elif request.method == 'POST':
        artist_name = request.form['name']
        phone_number = request.form['numb']

        query = 'INSERT INTO Artists (name, phoneNumber) VALUES (artist_name, phone_number)'
        execute_query(db_connection, query)
        return("/home")



@app.route('/add-fan/', methods=['POST', 'GET'])
def add_fan():
    db_connection = connect_to_database()

    if request.method =='GET':
        query = 'SELECT * from Fans;'
        result = execute_query(db_connection, query).fetchall()
        return render_template("/fans_page.html", res = result)

    elif request.method == 'POST':
        first_name = request.form['fname']
        last_name = request.form['lname']
        email = request.form['email']
        phone_number = request.form['numb']
        address = request.form['address']
        city = request.form['city']
        state = request.form['state']
        zip = request.form['zip']

        query = 'INSERT INTO Fans (firstName, lastName, email, phoneNumber, streetAddress, city, state, zipCode) VALUES (first_name, last_name, email, phone_number, address, city, state, zip)'
        execute_query(db_connection, query)
        return("/home")

@app.route('/update-employee/<int:id>', methods=['POST', 'GET'])
def update_employee(id):
    db_connection = connect_to_database()

    if request.method == 'GET':
        query = "SELECT * FROM Employees WHERE employeeID = %s;"
        res = execute_query(db_connection, query, (id,)).fetchone()
        if res == None:
            return redirect("/404" )
        
        return render_template("/update-employee/", result=res)
    
    elif request.method == 'POST':
        role = request.form['role']
        email = request.form['email']
        phone_number = request.form['phonenumber']
        query = 'UPDATE Employees SET role = %s, email = %s, phoneNumber = %s WHERE employeeID = %s;'
        data = (role, email, phone_number)
        execute_query(db_connection, query, data)
        return('/add-employee')

    

@app.route('/update-artist/<int:id>', methods=['POST', 'GET'])
def update_artist(id):
    db_connection = connect_to_database()

    if request.method == 'GET':
        query = "SELECT * FROM Artists WHERE artistID = %s;"
        res = execute_query(db_connection, query, (id,)).fetchone()
        if res == None:
            return redirect('/404')

        return render_template("/update-artist", result=res)
        
    elif request.method == 'POST':
        phone_number = request.form['phonenumber']
        query = 'UPDATE Artists SET phoneNumber = %s WHERE artistID = %s;'
        execute_query(db_connection, query, phone_number)
        return('/add-artist')



@app.route('/update-fan/<int:id>', methods=['POST', 'GET'])
def update_fan(id):
    db_connection = connect_to_database()

    if request.method == 'GET':
        query = "SELECT * FROM Fans WHERE fanID = %s;"
        res = execute_query(db_connection, query, (id,)).fetchone()
        if res == None:
            return redirect('/404')
        return render_template('/update-fan', result=res)

    elif request.method == 'POST':
        phone_number = request.form['phonenumber']
        query = 'UPDATE Artists SET phoneNumber = %s WHERE artistID = %s;'
        execute_query(db_connection, query, phone_number)
        return('/add-fan')


    

@app.route('/delete-employee/<int:id>')
def delete_employee(id):
    db_connection = connect_to_database()
    query = "DELETE FROM Employees WHERE id = %s;"

    execute_query(db_connection, query, (id,))
    print("Deleted")
    return redirect("/employees-page")

@app.route('/delete-artist/<int:id>')
def delete_artist(id):
    db_connection = connect_to_database()
    query = "DELETE FROM Artists WHERE id = %s;"
    execute_query(db_connection, query, (id,))
    print("Deleted")
    return redirect("/artists-page")

@app.route('/delete-fan/<int:id>')
def delete_fan(id):
    db_connection = connect_to_database()
    query = "DELETE FROM Fans WHERE id = %s;"
    execute_query(db_connection, query, (id,))
    print("Deleted")
    return redirect("/fans-page")



    


# Listener
if __name__ == "__main__":
    port = int(os.environ.get('PORT', 52870)) 
    app.run(port=port, debug=True) 