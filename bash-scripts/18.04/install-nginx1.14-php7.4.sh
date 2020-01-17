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

echo "--------------- Installing Tools";

PHP7_PPA="ondrej/php"
if ! grep -q "$PHP7_PPA" /etc/apt/sources.list /etc/apt/sources.list.d/*; then
    sudo apt-get install software-properties-common
    sudo add-apt-repository ppa:$PHP7_PPA;
    sudo apt-get update;
fi

apt_get_packages=( "git" "zip" "imagemagick" "php7.4-fpm" "php7.4-mysql" "php7.4-gd" "php7.4-cli" "php7.4-common" "php7.4-json" "php7.4-curl" "php7.4-readline" "php-mongodb" "php-redis" "php7.4-sqlite" "php7.4-bcmath" "php7.4-mbstring" "php7.4-zip" "php7.4-xml" "php7.4-intl" "php-imagick"); # "python-pip"
# php7.4 php7.4-fpm php7.4-mysql php7.4-cli php7.4-common php7.4-curl php7.4-gd php7.4-json php7.4-readline
# api: php5-memcached php5-mongo php5-redis
for i in "${!apt_get_packages[@]}"; do
    if [ $(dpkg-query -W -f='${Status}' "${apt_get_packages[$i]}" 2>/dev/null | grep -c "ok installed") -eq 0 ];
    then
        echo "--------------- Installing ${apt_get_packages[$i]}";
        sudo apt-get install -y ${apt_get_packages[$i]} --allow-unauthenticated;
    else
        echo "--------------- '${apt_get_packages[$i]}' already installed";
    fi
done;
