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
sudo apt-get install -y nginx

echo "--------------- Installing Tools";

PHP7_PPA="ondrej/php"
if ! grep -q "$PHP7_PPA" /etc/apt/sources.list /etc/apt/sources.list.d/*; then
    sudo apt-get install software-properties-common
    sudo add-apt-repository ppa:$PHP7_PPA;
    sudo apt-get update;
fi

apt_get_packages=( "git" "php7.0-fpm" "php7.0-mysql" "php7.0-gd" "php7.0-cli" "php7.0-common" "php7.0-json" "php7.0-curl" "php7.0-mcrypt" "php7.0-readline" "php-mongodb" "php-redis" "php7.0-sqlite" "php7.0-bcmath" "php7.0-mbstring" "php7.0-xml" "php7.0-intl" "php-imagick"); # "python-pip"
# php7.0 php7.0-fpm php7.0-mysql php7.0-cli php7.0-common php7.0-curl php7.0-gd php7.0-json php7.0-mcrypt php7.0-readline
# api: php5-memcached php5-mongo php5-redis
for i in "${!apt_get_packages[@]}"; do
    if [ $(dpkg-query -W -f='${Status}' "${apt_get_packages[$i]}" 2>/dev/null | grep -c "ok installed") -eq 0 ];
    then
        echo "--------------- Installing ${apt_get_packages[$i]}";
        sudo apt-get install -y ${apt_get_packages[$i]};
    else
        echo "--------------- '${apt_get_packages[$i]}' already installed";
    fi
done;
