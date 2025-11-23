from flask import Flask, jsonify, render_template, request, redirect, url_for, session
from functools import wraps
import os
from dotenv import load_dotenv
import MySQLdb
from MySQLdb.cursors import DictCursor

load_dotenv()
app = Flask(__name__)

# secret key for session management, cookie related
# Generate a random secret key: python -c "import os; print(os.urandom(24).hex())"
app.config['SECRET_KEY'] = os.getenv("SECRET_KEY", "your-secret-key-here-change-this")

# -- MySQL Configuration --
app.config['MYSQL_HOST'] = os.getenv("DB_HOST")
app.config['MYSQL_USER'] = os.getenv("DB_USER")
app.config['MYSQL_PASSWORD'] = os.getenv("DB_PASSWORD")
app.config['MYSQL_DB'] = os.getenv("DB_NAME")

def get_db_connection():
    """Create a new database connection for each request"""
    return MySQLdb.connect(
        host=app.config['MYSQL_HOST'],
        user=app.config['MYSQL_USER'],
        passwd=app.config['MYSQL_PASSWORD'],
        db=app.config['MYSQL_DB'],
        cursorclass=DictCursor
    )

# new stuff for login
# decorator to protect routes that require login
def login_required(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if 'logged_in' not in session:
            return redirect(url_for('get_login'))
        return f(*args, **kwargs)
    return decorated_function

# Login routes
@app.route('/login', methods=['GET', 'POST'])
def get_login():
    """Handle supervisor login"""
    # If already logged in, redirect to dashboard
    if 'logged_in' in session:
        return redirect(url_for('supervisor_dashboard'))
    
    if request.method == 'POST':
        username = request.form.get('username')
        password = request.form.get('password')
        
        conn = get_db_connection()
        cursor = conn.cursor()
        
        # Check if account exists with matching username and password
        cursor.execute("""
            SELECT a.AccountID, a.SupervisorID, w.Name
            FROM Account a
            JOIN Supervisor s ON a.SupervisorID = s.WorkerID
            JOIN Worker w ON s.WorkerID = w.WorkerID
            WHERE a.Username = %s AND a.Password = %s
        """, (username, password))
        
        account = cursor.fetchone()
        cursor.close()
        conn.close()
        
        if account:
            # Login successful, create session
            session['logged_in'] = True
            session['supervisor_id'] = account['SupervisorID']
            session['supervisor_name'] = account['Name']
            session['account_id'] = account['AccountID']
            
            return redirect(url_for('supervisor_dashboard'))
        else:
            # Login failed
            return render_template('login.html', error='Invalid username or password')
    
    # GET request - show login form
    return render_template('login.html')

@app.route('/logout')
def logout():
    """Handle supervisor logout"""
    session.clear()
    return redirect(url_for('index'))

@app.route('/dashboard')
@login_required
def supervisor_dashboard():
    """Protected supervisor dashboard - requires login"""
    supervisor_name = session.get('supervisor_name', 'Supervisor')
    return render_template('supervisor_dashboard.html', supervisor_name=supervisor_name)


@app.route('/')
def index():
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT EventName, EventLocation, EventDate FROM FUNDRAISER WHERE EventDate >= CURDATE() ORDER BY EventDate")
    events = cursor.fetchall()
    cursor.execute("""        
        SELECT a.Name, a.Age, m.Species
        FROM Animal a
        JOIN Mammal m ON a.PetID = m.PetID""")
    mammals = cursor.fetchall()
    cursor.execute("""        
        SELECT a.Name, a.Age, m.Species
        FROM Animal a
        JOIN Exotic m ON a.PetID = m.PetID""")
    exotics = cursor.fetchall()
    cursor.execute("""        
        SELECT a.Name, a.Age, m.Species
        FROM Animal a
        JOIN Fish m ON a.PetID = m.PetID""")
    fishies = cursor.fetchall()
    cursor.close()
    conn.close()
    return render_template('index.html', events=events, mammals=mammals, exotics=exotics, fishies=fishies)

@app.route('/donate')
def donate_step1():
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("" \
    "SELECT ShelterName " \
    "FROM Shelter")
    shelters = cursor.fetchall()
    cursor.close()
    conn.close()
    return render_template('donate.html', shelters=shelters)

@app.route("/donate/2", methods=["POST"])
def donate_step2():
    conn = get_db_connection()
    cursor = conn.cursor()
    # read values from step1
    amount = request.form.get("amount")
    shelter = request.form.get("shelter")

    # quick validation
    if not amount or not shelter:
        cursor.execute("" \
        "SELECT ShelterName " \
        "FROM Shelter")
        shelters = cursor.fetchall()
        cursor.close()
        conn.close()
        return render_template("donate.html", shelters=shelters, error="Please choose amount and shelter")
    else:
        cursor.close()
        conn.close()
        return render_template("donate2.html", amount=amount, shelter=shelter)

@app.route("/donate/3", methods=['GET', 'POST'])
def donate_step3():
    conn = get_db_connection()
    cursor = conn.cursor()

    if request.method == 'POST':
        # Grab all form data from donate2.html
        first_name = request.form.get('first_name')
        last_name = request.form.get('last_name')
        email = request.form.get('email')
        phone_number = request.form.get('phone_number')
        amount = request.form.get('amount')
        shelter = request.form.get('shelter')

        # Check if sponsor exists
        cursor.execute("""
            SELECT SponsorID
            FROM Sponsor
            WHERE Email =  %s
            """, (email,)
        )
        sponsor = cursor.fetchone()

        if sponsor:
            sponsor_id = sponsor['SponsorID']
        else:
            #Create new sponsor
            cursor.execute("""
                INSERT INTO Sponsor (Fname, Lname, Email, PhoneNumber)
                VALUES (%s, %s, %s, %s)""",
                (first_name, last_name, email, phone_number)
            )
            sponsor_id = cursor.lastrowid
        
        # New donation
        cursor.execute("""
            INSERT INTO Donation (SponsorID, ShelterName, AmountDonated)
            VALUES (%s, %s, %s)""",
            (sponsor_id, shelter, amount)
        )

        # Show new donor/donation
        print(f"Inserted Donation: {cursor.lastrowid}")
        conn.commit()
        cursor.close()
        conn.close()
        return render_template("donate3.html")
    else:
        cursor.close()
        conn.close()
        return render_template("donate1.html")
    
@app.route('/donations')
def get_donations():
    """Get ALL Donations"""
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM Donation")
    donations = cursor.fetchall()
    cursor.close()
    conn.close()
    return jsonify(donations)

@app.route('/sponsors')
def get_sponsors():
    """Get ALL Sponsors"""
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM Sponsor")
    sponsors = cursor.fetchall()
    cursor.close()
    conn.close()
    return jsonify(sponsors)

@app.route('/fundraisers')
def get_fundraisers():
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT EventName, EventLocation, EventDate, ShelterName FROM Fundraiser WHERE EventDate >= CURDATE() ORDER BY EventDate ASC")
    events = cursor.fetchall()
    cursor.execute("SELECT ShelterName FROM Shelter")
    shelters = cursor.fetchall()
    cursor.close()
    conn.close()
    return render_template('fundraisers.html', events=events, locations=shelters)

@app.route('/fundraisers/filter', methods=['POST'])
def get_filtered_fundraisers():
    selected_location = request.form['shelter_locations']
    past_event = request.form.getlist('past')
    print(past_event)
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT ShelterName FROM Shelter")
    shelters = cursor.fetchall()
    if selected_location == "all":
         if len(past_event) == 0 :
             query = ("""SELECT EventName, EventLocation, EventDate, ShelterName 
                      FROM Fundraiser
                      WHERE EventDate >= CURDATE() 
                      ORDER BY EventDate ASC""")
         else:
             query = ("""SELECT EventName, EventLocation, EventDate, ShelterName 
                      FROM Fundraiser
                      ORDER BY EventDate ASC""")
         cursor.execute(query)
    else:
        if len(past_event) == 0:
            query = ("""SELECT EventName, EventLocation, EventDate, ShelterName 
                      FROM Fundraiser
                      WHERE ShelterName = %s AND EventDate >= CURDATE() 
                      ORDER BY EventDate ASC""")
        else:
            query = ("""SELECT EventName, EventLocation, EventDate, ShelterName 
                      FROM Fundraiser
                      WHERE ShelterName = %s 
                     ORDER BY EventDate ASC""")
        cursor.execute(query, (selected_location,))
    result = cursor.fetchall()

    return render_template('fundraisers.html', events=result, locations=shelters)


@app.route('/adopt')
def get_adoptions():

    # conn = get_db_connection()
    # cursor = conn.cursor()
    # cursor.execute("""SELECT a.PetID, Name, Age, Species FROM (Animal a JOIN Mammal m ON a.PetID=m.PetID) 
    #                UNION SELECT a.PetID, Name, Age, Species FROM (Animal a JOIN Fish f ON a.PetID=f.PetID) 
    #                UNION SELECT a.PetID, Name, Age, Species FROM (Animal a JOIN Exotic e ON a.PetID=e.PetID);""")
    # animals = cursor.fetchall()
    # cursor.close()
    # conn.close()
    return render_template('adopt.html', animal_type="Animals")

@app.route('/adoptForm')
def adopt_form():
    return render_template('adoptForm.html')


@app.route('/shelters')
def get_shelters():
    """Get ALL shelters"""
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT ShelterName, PhoneNumber, PostalCode FROM Shelter")
    shelters = cursor.fetchall()
    cursor.close()
    conn.close()
    return jsonify(shelters)

@app.route('/animals', methods=['GET', 'POST'])
def get_animals():
    """Get ALL animals"""
    if request.method == 'POST':
        selected_location = request.form['shelter_locations']
    else:
        selected_location = "None"
    print(selected_location)
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT ShelterName FROM Shelter")
    shelters = cursor.fetchall()
    query = ("""SELECT * FROM (
                   SELECT a.PetID, Name, Age, Species, ShelterLocation FROM (Animal a JOIN Mammal m ON a.PetID=m.PetID) 
                   UNION SELECT a.PetID, Name, Age, Species, ShelterLocation FROM (Animal a JOIN Fish f ON a.PetID=f.PetID) 
                   UNION SELECT a.PetID, Name, Age, Species, ShelterLocation FROM (Animal a JOIN Exotic e ON a.PetID=e.PetID)) AS allPets""")
    if selected_location != "None":
        query = query + f" WHERE ShelterLocation = '{selected_location}'" 
    cursor.execute(query)
    animals = cursor.fetchall()
    cursor.close()
    conn.close()
    return render_template('adopt.html', animal_type="animals", animals=animals, locations=shelters)

@app.route('/mammals', methods=['GET', 'POST'])
def get_mammals():
    """Get only mammals"""
    if request.method == 'POST':
        selected_location = request.form['shelter_locations']
    else:
        selected_location = "None"
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT ShelterName FROM Shelter")
    shelters = cursor.fetchall()
    query = ("""
        SELECT * FROM (SELECT a.PetID, Name, Age, Species, ShelterLocation FROM (Animal a JOIN Mammal m ON a.PetID=m.PetID)) AS allPets
    """)
    if selected_location != "None":
        query = query + f" WHERE ShelterLocation = '{selected_location}'" 
    cursor.execute(query)
    mammals = cursor.fetchall()
    cursor.close()
    conn.close()
    return render_template('adopt.html', animal_type="mammals", animals=mammals, locations=shelters)

@app.route('/fish', methods=['GET', 'POST'])
def get_fish():
    """Get only fish"""
    if request.method == 'POST':
        selected_location = request.form['shelter_locations']
    else:
        selected_location = "None"
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT ShelterName FROM Shelter")
    shelters = cursor.fetchall()
    query = ("""
        SELECT * FROM (SELECT a.PetID, Name, Age, Species, ShelterLocation FROM (Animal a JOIN Fish f ON a.PetID=f.PetID)) AS allPets
    """)
    if selected_location != "None":
        query = query + f" WHERE ShelterLocation = '{selected_location}'" 
    cursor.execute(query)
    fish = cursor.fetchall()
    cursor.close()
    conn.close()
    return render_template('adopt.html', animal_type="fish", animals=fish, locations=shelters)

@app.route('/exotics', methods=['GET', 'POST'])
def get_exotic():
    """Get only exotic animals"""
    if request.method == 'POST':
        selected_location = request.form['shelter_locations']
    else:
        selected_location = "None"
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT ShelterName FROM Shelter")
    shelters = cursor.fetchall()
    query = ("""
        SELECT * FROM (SELECT a.PetID, Name, Age, Species, ShelterLocation FROM (Animal a JOIN Exotic e ON a.PetID=e.PetID)) AS allPets
    """)
    if selected_location != "None":
        query = query + f" WHERE ShelterLocation = '{selected_location}'" 
    cursor.execute(query)
    exotic = cursor.fetchall()
    cursor.close()
    conn.close()
    return render_template('adopt.html', animal_type="exotics", animals=exotic, locations=shelters)


# Volunteer routes
@app.route('/manage-volunteers')
@login_required
def manage_volunteers():
    """Display all volunteers with their information"""
    conn = get_db_connection()
    cursor = conn.cursor()
    
    # Get all volunteers with their worker information
    cursor.execute("""
        SELECT w.WorkerID, w.Name, w.Email, w.PhoneNumber, w.ShelterName,
               v.HoursWorked, v.Responsibilities
        FROM Worker w
        JOIN Volunteer v ON w.WorkerID = v.WorkerID
        ORDER BY w.Name
    """)
    volunteers = cursor.fetchall()
    
    # Get all shelters for the dropdown filters
    cursor.execute("SELECT ShelterName FROM Shelter")
    shelters = cursor.fetchall()
    
    cursor.close()
    conn.close()
    
    return render_template('manage_volunteers.html', 
                         volunteers=volunteers, 
                         shelters=shelters)

@app.route('/manage-volunteers/add', methods=['POST'])
@login_required
def add_volunteer():
    """Add a new volunteer to the database"""
    conn = get_db_connection()
    cursor = conn.cursor()
    
    try:
        # Get form data
        name = request.form.get('name')
        email = request.form.get('email')
        phone = request.form.get('phone')
        shelter = request.form.get('shelter')
        hours = request.form.get('hours', 0)
        responsibilities = request.form.get('responsibilities', '')
        
        # Get address data
        building_no = request.form.get('building_no')
        street = request.form.get('street')
        city = request.form.get('city')
        province = request.form.get('province')
        postal_code = request.form.get('postal_code')
        
        # First, insert address
        cursor.execute("""
            INSERT INTO Address (BuildingNo, Street, City, Province, PostalCode)
            VALUES (%s, %s, %s, %s, %s)
        """, (building_no, street, city, province, postal_code))
        
        address_id = cursor.lastrowid
        
        # Then, insert into Worker table with the new AddressID
        cursor.execute("""
            INSERT INTO Worker (Name, Email, PhoneNumber, ShelterName, AddressID)
            VALUES (%s, %s, %s, %s, %s)
        """, (name, email, phone, shelter, address_id))
        
        worker_id = cursor.lastrowid
        
        # Finally, insert into Volunteer table
        cursor.execute("""
            INSERT INTO Volunteer (WorkerID, HoursWorked, Responsibilities)
            VALUES (%s, %s, %s)
        """, (worker_id, hours, responsibilities))
        
        conn.commit()
        print(f"Added new volunteer: {name} (WorkerID: {worker_id}, AddressID: {address_id})")
        
    except Exception as e:
        conn.rollback()
        print(f"Error adding volunteer: {e}")
    
    finally:
        cursor.close()
        conn.close()
    
    return redirect(url_for('manage_volunteers'))

@app.route('/manage-volunteers/update', methods=['POST'])
@login_required
def update_volunteer():
    """Update existing volunteer information"""
    conn = get_db_connection()
    cursor = conn.cursor()
    
    try:
        # Get form data
        worker_id = request.form.get('worker_id')
        name = request.form.get('name')
        shelter = request.form.get('shelter')
        hours = request.form.get('hours')
        responsibilities = request.form.get('responsibilities')
        
        # Update Worker table (name and shelter location)
        cursor.execute("""
            UPDATE Worker
            SET Name = %s, ShelterName = %s
            WHERE WorkerID = %s
        """, (name, shelter, worker_id))
        
        # Update Volunteer table (hours and responsibilities)
        cursor.execute("""
            UPDATE Volunteer
            SET HoursWorked = %s, Responsibilities = %s
            WHERE WorkerID = %s
        """, (hours, responsibilities, worker_id))
        
        conn.commit()
        print(f"Updated volunteer: {name} (WorkerID: {worker_id})")
        
    except Exception as e:
        conn.rollback()
        print(f"Error updating volunteer: {e}")
    
    finally:
        cursor.close()
        conn.close()
    
    return redirect(url_for('manage_volunteers'))


if __name__ == '__main__':
    app.run(debug=True)