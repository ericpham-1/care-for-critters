from flask import Flask, jsonify, render_template
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
def get_donation():
    return render_template('donate.html')

@app.route('/fundraisers')
def get_fundraisers():
    return render_template('fundraisers.html')

@app.route('/adopt')
def get_adoptions():
    return render_template('adopt.html')

@app.route('/shelters')
def get_shelters():
    """Get ALL shelters"""
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT ShelterID, PhoneNumber, PostalCode FROM Shelter")
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