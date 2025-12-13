#!/bin/bash
sudo apt update -y 
sudo apt install php libapache2-mod-php -y
echo "this is another test with userdata" > /var/www/html/index.html
sudo systemctl restart apache2.service