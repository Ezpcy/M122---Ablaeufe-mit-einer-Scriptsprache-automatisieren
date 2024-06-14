#!/bin/bash

DIR_NAME=$1
SERVER_NAME=$2
DB_NAME=$3
DB_USER=$4

sudo a2dissite $SERVER_NAME.conf
sudo systemctl reload apache2
sudo rm /etc/apache2/sites-available/$SERVER_NAME.conf

sudo rm -rf /var/www/$DIR_NAME

mysql -u root -p -e "DROP DATABASE IF EXISTS $DB_NAME; REVOKE ALL PRIVILEGES ON $DB_NAME.* FROM '$DB_USER'@'localhost'; FLUSH PRIVILEGES;"
sudo certbot delete --cert-name $SERVER_NAME
sudo systemctl restart apache2
sudo systemctl restart mariadb
