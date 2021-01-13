#!/bin/bash

yum install -y vim git unzip

#apache
yum install -y httpd httpd-devel httpd-tools
chkconfig httpd on
service httpd stop

rm -rf /var/www/html
ln -s /vagrant /var/www/html

service httpd start 

#php
yum install -y php php-cli php-common php-devel php-mysql

# MySQL
yum install -y mysql mysql-server mysql-devel 
chkconfig mysqld on
service mysqld start 

mysql -u root -e "SHOW DATABASES";

service httpd restart 