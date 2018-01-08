#!/bin/bash

# https://www.digitalocean.com/community/tutorials/how-to-install-linux-nginx-mysql-php-lemp-stack-in-ubuntu-16-04

#
# UPDATE / UPGRADE
#

echo "--------------- Update";

sudo apt-get update;
#sudo apt-get -y upgrade;

#
#  INSTALL
#

echo "--------------- Installing Memcache/Memcached";

# Redis
sudo apt-get install -y php-memcache php-memcached
