#!/bin/bash

# https://www.digitalocean.com/community/tutorials/how-to-install-the-latest-mysql-on-ubuntu-18-04


echo "--------------- Config MySQL Opt";

cd /tmp
curl -OL https://dev.mysql.com/get/mysql-apt-config_0.8.10-1_all.deb
sudo apt-key adv --keyserver keys.gnupg.net --recv-keys 5072E1F5
sudo dpkg -i mysql-apt-config*

#
# UPDATE / UPGRADE
#

echo "--------------- Update";

sudo apt update;
#sudo apt-get -y upgrade;

rm /tmp/mysql-apt-config*

#
#  INSTALL
#

echo "--------------- Installing MySQL";

# MySQL 8.0
sudo apt-get install -y mysql-server

systemctl status mysql

sudo mysql_secure_installation

