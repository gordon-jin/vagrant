#!/bin/bash

#apache
yum install -y httpd httpd-devel httpd-tools
chkconfig httpd on
service httpd stop

rm -rf /var/www/html
ln -s /vagrant /var/www/html

service httpd start

#php
yum install -y php php-cli php-common php-devel php-mysql

cd /vagrant
sudo -u vagrant wget -q https://raw.githubusercontent.com/gordon-jin/vagrant/main/files/index.html
sudo -u vagrant wget -q https://raw.githubusercontent.com/gordon-jin/vagrant/main/files/info.php

sudo setenforce 0

service httpd restart
