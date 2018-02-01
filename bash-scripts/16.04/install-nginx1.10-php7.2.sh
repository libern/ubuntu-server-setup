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

# nginx 1.10.0 (Ubuntu)
sudo apt-get install -y nginx --allow-unauthenticated

echo "--------------- Installing Tools";

PHP7_PPA="ondrej/php"
if ! grep -q "$PHP7_PPA" /etc/apt/sources.list /etc/apt/sources.list.d/*; then
    sudo apt-get install software-properties-common
    sudo add-apt-repository ppa:$PHP7_PPA;
    sudo apt-get update;
fi

apt_get_packages=( "git" "zip" "php7.2-fpm" "php7.2-mysql" "php7.2-gd" "php7.2-cli" "php7.2-common" "php7.2-json" "php7.2-curl" "php7.2-mcrypt" "php7.2-readline" "php-mongodb" "php-redis" "php7.2-sqlite" "php7.2-bcmath" "php7.2-mbstring" "php7.2-zip" "php7.2-xml" "php7.2-intl" "php-imagick"); # "python-pip"
# php7.2 php7.2-fpm php7.2-mysql php7.2-cli php7.2-common php7.2-curl php7.2-gd php7.2-json php7.2-mcrypt php7.2-readline
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
