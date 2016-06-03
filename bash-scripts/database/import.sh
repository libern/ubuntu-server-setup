#! /bin/bash

MYSQL_USER="root"
MYSQL_PASSWORD="abc123"
echo -n "DB TIMESTAMP DIR: "
read TIMESTAMP
#TIMESTAMP=$(date +"%F")
BACKUP_DIR="/srv/db/$TIMESTAMP"
MYSQL=/usr/bin/mysql
MYSQLDUMP=/usr/bin/mysqldump
 
#mkdir -p "$BACKUP_DIR"
 
#databases=`$MYSQL --user=$MYSQL_USER -p$MYSQL_PASSWORD -e "SHOW DATABASES;" | grep -Ev "(Database|information_schema|performance_schema)"`

#for db in $databases; do
#  $MYSQLDUMP --force --opt --user=$MYSQL_USER -p$MYSQL_PASSWORD --databases $db | gzip > "$BACKUP_DIR/mysql/$db.gz"
#done

if [ ! -d "$BACKUP_DIR" ]; then
  # Control will enter here if $DIRECTORY doesn't exist.
  echo "DIRECTORY not exist: $BACKUP_DIR"
  exit 1
fi

file_count=0

echo -n "DB Name (Using , for multiple databases): "
read database_string

# to array
IFS=',' read -a array <<< "$database_string"

for DB_name in "${array[@]}"
do
 	FILE="$BACKUP_DIR/$DB_name.gz"
    echo "IMPORTING DB: $DB_name ($FILE)"
 	# check file exists
	if [ ! -f $FILE ]
	then
	    echo "File not found! "
	else
		#echo "$FILE_UNZIPPED"
		#gzip -d $FILE
		#echo "File1: $FILE"
	    gunzip -c $FILE | mysql -u $MYSQL_USER -p$MYSQL_PASSWORD

	    (( file_count++ ))
	fi
done

echo "$file_count databases imported"