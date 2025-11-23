from flask import Flask, jsonify, render_template, request
import os
from dotenv import load_dotenv
import MySQLdb
from MySQLdb.cursors import DictCursor

load_dotenv()
app = Flask(__name__)

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


@app.route('/login')
def get_login():
    return render_template('login.html')

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

if __name__ == '__main__':
    app.run(debug=True)