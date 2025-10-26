from flask import Flask, jsonify
import os
from dotenv import load_dotenv
import MySQLdb

load_dotenv()
app = Flask(__name__)

# -- SQL Configuration --
app.config['MYSQL_HOST'] = os.getenv("DB_HOST")
app.config['MYSQL_USER'] = os.getenv("DB_USER")
app.config['MYSQL_PASSWORD'] = os.getenv("DB_PASSWORD")
app.config['MYSQL_DB'] = os.getenv("DB_NAME")

# Initialize MySQL
mysql = MySQLdb.connect(host=app.config['MYSQL_HOST'],
                        user=app.config['MYSQL_USER'],
                        passwd=app.config['MYSQL_PASSWORD'],
                        db=app.config['MYSQL_DB'])

@app.route('/')
def index():
    cursor = mysql.cursor()
    cursor.execute("SELECT 'Hello, World!'")
    result = cursor.fetchone()
    return jsonify(result[0])

if __name__ == '__main__':
    app.run(debug=True)
