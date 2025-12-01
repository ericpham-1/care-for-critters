# CPSC 471 Project T04-3
## Care For Critters 
Emma Djukic ~ 30213555 ~ emma.jukic@ucalgary.ca  
Erica Chow ~ 30205221 ~ erica.chow1@ucalgary.ca  
Eric Pham ~ 30210437 ~ eric.pham1@ucalgary.ca  

## Setup Instructions
### Prerequisites 
Our project uses mariadb, flask, and python. Ensure an up to date version is available to run this project. 

## Virtual Environment Setup
A virtual environment is required to run this project. For Windows, this can be done with `python -m venv cpsc471project` and for macOS/Linux, `python3 -m venv cpsc471project`. An isolated setup will be created in the folder. To activate the environment, use the command `source cpsc471project\Scripts\activate` or `source cpsc471project/bin/activate`. Ensure this virtual environment is run every time the project is run. Ensure the environment is setup by noting the (cpsc471project) at the command line prompt.  
Within the virtual environment, download the following libraries:  
`pip install flask`
`pip install flask_mysqldb`
`pip install python-dotenv`  

## Database Setup
Set up a .env file with the following contents:
~~~
FLASK_ENV=development
DB_HOST=localhost  
DB_USER=flaskuser  
DB_PASSWORD=password
DB_NAME=careforcritters
~~~
Ensure that the .env file is never committed to the repository.

The db_setup.sh script is necessary to set up an initial configuration of the database and add values to the tables. This script requires the create_tables.sql file and insert_data.sql file. Ensure these are downloaded and in the project directory.  
At the top of the db_setup.sh file, various DB variables are specified. Change the DB_PASSWORD variable to your mariadb root password.  
Run the script in the terminal using `./db_setup.sh`. A database careforcritters will be created on the local device. Any data added to the application will NOT be saved to this file, changes are temporary and data will reset to the base values added from the insert_data.sql file. 

## Running the Project
To run the project, ensure the database is setup (refer to the above steps) and the virtual environment is running. Run the application with `python app.py` or `python3 app.py` (machine dependent). Visit the web app at http://127.0.0.1:5000. 