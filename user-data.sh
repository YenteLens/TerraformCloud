#!/bin/bash
sudo apt update -y 
sudo apt-get update
sudo apt install php libapache2-mod-php -y
sudo apt-get install mysql-server php php-mysql -y
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo apt install unzip -y
unzip awscliv2.zip
sudo ./aws/install
echo "this is another test with userdata" > /var/www/html/index.html
sudo systemctl restart apache2.service