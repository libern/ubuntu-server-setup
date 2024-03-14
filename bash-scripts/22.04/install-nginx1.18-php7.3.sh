#!/bin/bash

# https://tecadmin.net/how-to-install-php-on-ubuntu-22-04/

#
# UPDATE / UPGRADE
#

echo "--------------- Disable IPv6";
# https://askubuntu.com/questions/1415009/add-apt-respository-keeps-timing-out
# test: ping ppa.launchpadcontent.net

sudo sysctl -w net.ipv6.conf.all.disable_ipv6=1
sudo sysctl -w net.ipv6.conf.default.disable_ipv6=1
sudo sysctl -w net.ipv6.conf.lo.disable_ipv6=1

echo "--------------- Update + Upgrade";

sudo apt update;
sudo apt -y upgrade;

#
#  INSTALL
#

echo "--------------- Installing Nginx";

# nginx 1.18.0 (Ubuntu)
sudo apt-get install -y nginx --allow-unauthenticated

echo "--------------- Installing Tools";

sudo apt install software-properties-common ca-certificates lsb-release apt-transport-https;

echo "--------------- Adding Repository";
PHP7_PPA="ondrej/php"
LC_ALL=C.UTF-8 sudo add-apt-repository ppa:$PHP7_PPA;
sudo apt update;

apt_get_packages=( "git" "zip" "imagemagick" "php7.3-fpm" "php7.3-mysql" "php7.3-gd" "php7.3-cli" "php7.3-common" "php7.3-json" "php7.3-curl" "php7.3-readline" "php-mongodb" "php-redis" "php7.3-sqlite" "php7.3-bcmath" "php7.3-mbstring" "php7.3-zip" "php7.3-xml" "php7.3-intl" "php-imagick"); # "python-pip"
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
