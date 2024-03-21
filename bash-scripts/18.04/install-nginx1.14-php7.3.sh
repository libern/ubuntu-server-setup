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

apt_get_packages=( "git" "zip" "imagemagick" "php7.3-fpm" "php7.3-mysql" "php7.3-gd" "php7.3-cli" "php7.3-common" "php7.3-json" "php7.3-curl" "php7.3-readline" "php-mongodb" "php-redis" "php7.3-sqlite" "php7.3-bcmath" "php7.3-mbstring" "php7.3-zip" "php7.3-xml" "php7.3-intl" "php7.3-imagick" "php7.3-redis"); # "python-pip"
# php7.3 php7.3-fpm php7.3-mysql php7.3-cli php7.3-common php7.3-curl php7.3-gd php7.3-json php7.3-readline
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
