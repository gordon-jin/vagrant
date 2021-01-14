#!/bin/bash

# MySQL
yum install -y mysql mysql-server mysql-devel
chkconfig mysqld on
service mysqld start

mysql -u root -e "SHOW DATABASES";
