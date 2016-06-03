#! /bin/bash

echo "=============== Installing Apache 2.4 + PHP 5.6 =================="
echo -n "Press ENTER to continue install: "
read confirm

sudo apt-get install -y python-software-properties
sudo add-apt-repository -y ppa:ondrej/php

sudo apt-get update

# install essentials
sudo apt-get install -y php5.6 apache2 libapache2-mod-php5.6 php5.6-mysql php5.6-gd php5.6-mcrypt

sudo a2enmod rewrite

sudo service apache2 reload

echo "Done."