#! /bin/bash

MYSQL_USER="root"
MYSQL_PASSWORD="abc123"

TIMESTAMP=$(date +"%F")
BACKUP_DIR="/srv/db/$TIMESTAMP"
ALL_DIR="/srv/db/all"
MYSQL=/usr/bin/mysql
MYSQLDUMP=/usr/bin/mysqldump
 
mkdir -p "$BACKUP_DIR"
mkdir -p "$ALL_DIR"
 
databases=`$MYSQL --user=$MYSQL_USER -p$MYSQL_PASSWORD -e "SHOW DATABASES;" | grep -Ev "(Database|information_schema|performance_schema)"`
 
for db in $databases; do
  $MYSQLDUMP --force --opt --default-character-set=utf8mb4 --complete-insert --no-create-info --user=$MYSQL_USER -p$MYSQL_PASSWORD --databases $db | gzip > "$BACKUP_DIR/$db.gz"
done

echo "Compressing..."
tar czfP $ALL_DIR/db_bk_$TIMESTAMP.tar.gz $BACKUP_DIR
echo "Backup Done!"