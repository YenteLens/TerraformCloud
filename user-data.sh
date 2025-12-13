#!/bin/bash
sudo apt update -y 
sudo apt-get update
sudo apt install php libapache2-mod-php -y
sudo apt-get install mysql-server php php-mysql
echo "this is another test with userdata" > /var/www/html/index.html
sudo systemctl restart apache2.service