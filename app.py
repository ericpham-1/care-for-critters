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
    cursor.execute("SELECT EventName, EventLocation, EventDate FROM FUNDRAISER ORDER BY EventDate")
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
    return render_template('fundraisers.html')

@app.route('/adopt')
def get_adoptions():
    return render_template('adopt.html')

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

@app.route('/animals')
def get_animals():
    """Get ALL animals"""
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT PetID, Name, Age, Description, Diet FROM Animal")
    animals = cursor.fetchall()
    cursor.close()
    conn.close()
    return jsonify(animals)

@app.route('/mammals')
def get_mammals():
    """Get only mammals"""
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("""
        SELECT a.Name, a.Age, m.Species, m.Weight
        FROM Animal a
        JOIN Mammal m ON a.PetID = m.PetID
    """)
    mammals = cursor.fetchall()
    cursor.close()
    conn.close()
    return jsonify(mammals)

@app.route('/fish')
def get_fish():
    """Get only fish"""
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("""
        SELECT a.Name, a.Age, f.Species, f.WaterType
        FROM Animal a
        JOIN Fish f ON a.PetID = f.PetID
    """)
    fish = cursor.fetchall()
    cursor.close()
    conn.close()
    return jsonify(fish)

@app.route('/exotic')
def get_exotic():
    """Get only exotic animals"""
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("""
        SELECT a.Name, a.Age, e.Species, e.HabitatRequirements
        FROM Animal a
        JOIN Exotic e ON a.PetID = e.PetID
    """)
    exotic = cursor.fetchall()
    cursor.close()
    conn.close()
    return jsonify(exotic)

if __name__ == '__main__':
    app.run(debug=True)