#!/bin/bash

# https://www.digitalocean.com/community/tutorials/how-to-install-linux-nginx-mysql-php-lemp-stack-in-ubuntu-16-04

#
# UPDATE / UPGRADE
#

echo "--------------- Update + Upgrade";

sudo apt-get update;
sudo apt-get -y upgrade;

#
#  INSTALL
#

echo "--------------- Installing Nginx";

# nginx 1.14.0 (Ubuntu)
sudo apt-get install -y nginx --allow-unauthenticated
