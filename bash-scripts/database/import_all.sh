#! /bin/bash

MYSQL_USER="root"
MYSQL_PASSWORD="secret"
echo -n "DB TIMESTAMP DIR: "
read TIMESTAMP
#TIMESTAMP=$(date +"%F")
BACKUP_DIR="/srv/db/$TIMESTAMP"
MYSQL=/usr/bin/mysql
MYSQLDUMP=/usr/bin/mysqldump

if [ ! -d "$BACKUP_DIR" ]; then
  # Control will enter here if $DIRECTORY doesn't exist.
  echo "DIRECTORY not exist: $BACKUP_DIR"
  exit 1
fi

file_count=0

#echo -n "DB Name (Using , for multiple databases): "
#read database_string

# to array
#IFS=',' read -a array <<< "$database_string"

FILES="$BACKUP_DIR/*.gz"
echo "$FILES"

for file in $FILES
do
 # do something on "$file"
	echo "Importing: $file"
    gunzip -c $file | mysql -u $MYSQL_USER -p$MYSQL_PASSWORD
    (( file_count++ ))
done

echo "$file_count databases imported"
