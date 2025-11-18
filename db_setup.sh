DB_USER="root"
DB_PASSWORD="password"
DB_NAME="CareForCritters"
TABLE_FILE="create_tables.sql"
INSERT_DATA_FILE="insert_data.sql"

if [ ! -e "$TABLE_FILE" ] || [ ! -e "$INSERT_DATA_FILE" ]; then
    echo "SQL files not found"
    exit 1
fi

echo "Creating database $DB_NAME"
mariadb -u"$DB_USER" -p"$DB_PASSWORD" -e "DROP DATABASE IF EXISTS $DB_NAME"
mariadb -u"$DB_USER" -p"$DB_PASSWORD" -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"

echo "Importing data"
mariadb -u"$DB_USER" -p"$DB_PASSWORD" "$DB_NAME" < "$TABLE_FILE"
mariadb -u"$DB_USER" -p"$DB_PASSWORD" "$DB_NAME" < "$INSERT_DATA_FILE"

if [ $? -eq 0 ]; then 
    echo "Database set up successfully"
else 
    echo "Error setting up database"
fi
