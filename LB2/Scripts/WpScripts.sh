#!/bin/bash

# Get directory name, servername, and database name from command line arguments
DIR_NAME=$1
SERVER_NAME=$2
DB_NAME=$3
DB_USER=$4

# Install necessary packages
sudo apt update && sudo apt install -y apache2 mariadb-server certbot python3-certbot-apache curl

# Create the directory if it doesn't exist
if [ ! -d /var/www/$DIR_NAME ]; then
  sudo mkdir /var/www/$DIR_NAME
fi

# Download WordPress and extract its contents into the directory
curl -O https://wordpress.org/latest.tar.gz
tar xzvf latest.tar.gz
sudo rsync -avP wordpress/* /var/www/$DIR_NAME/
sudo chown -R www-data:www-data /var/www/$DIR_NAME/



mysql -u $DB_USER -p <<MYSQL_SCRIPT
CREATE DATABASE IF NOT EXISTS ${DB_NAME};
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'localhost';
FLUSH PRIVILEGES;
MYSQL_SCRIPT


# This message confirms completion of the script
echo "MySQL script completed"


# Create an Apache virtual host configuration file with the provided hostname
sudo tee /etc/apache2/sites-available/$SERVER_NAME.conf >/dev/null <<EOF
<VirtualHost *:80>
    ServerName $SERVER_NAME
    DocumentRoot /var/www/$DIR_NAME
    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
    <Directory /var/www/$DIR_NAME>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>


EOF

# Enable the new site
sudo a2ensite $SERVER_NAME.conf

# Request and install an SSL/TLS certificate from Let's Encrypt using Certbot
sudo certbot --apache -d $SERVER_NAME --non-interactive --agree-tos --email batu.s@live.com

# Enable necessary apache2 modules
sudo a2enmod ssl rewrite headers

# Restart Apache to apply all changes
sudo systemctl restart apache2

