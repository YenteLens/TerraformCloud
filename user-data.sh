#!/bin/bash
sudo apt update -y 
sudo apt-get update
sudo apt install php libapache2-mod-php -y
sudo apt-get install mysql-server php php-mysql -y
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo apt install unzip -y
unzip awscliv2.zip
sudo ./aws/install

sudo rm /var/www/html/index.html
sudo aws s3 cp s3://yentelensfinalproject/upload.php /var/www/html/
sudo aws s3 cp s3://yentelensfinalproject/index.html /var/www/html/

sudo mysql -u root -prootpass <<EOF
CREATE DATABASE uploaddb;
CREATE USER 'uploaduser'@'localhost' IDENTIFIED BY 'uploadpass';
GRANT INSERT, SELECT ON uploaddb.* TO 'uploaduser'@'localhost';
FLUSH PRIVILEGES;

USE uploaddb;
CREATE TABLE uploads (
  id INT AUTO_INCREMENT PRIMARY KEY,
  filename VARCHAR(255),
  description TEXT,
  uploaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
EOF

sudo systemctl restart apache2.service
