#! /bin/bash

echo "=============== Installing Apache 2.4 + PHP 5.5 =================="
echo -n "Press ENTER to continue install: "
read confirm

sudo apt-get install -y python-software-properties
sudo add-apt-repository -y ppa:ondrej/php5

sudo apt-get update

# install essentials
sudo apt-get install -y php5 apache2 libapache2-mod-php5 php5-mysql php5-gd php5-mcrypt

sudo a2enmod rewrite

sudo service apache2 reload

echo "Done."