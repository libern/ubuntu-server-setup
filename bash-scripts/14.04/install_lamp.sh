#! /bin/bash

echo "=============== Installing Apache + PHP + MySQL =================="
echo -n "Press ENTER to continue install: "
read confirm

sudo apt-get install -y python-software-properties
sudo add-apt-repository -y ppa:ondrej/php5

sudo apt-get update

# install essentials
#sudo apt-get install -y htop nethogs iptraf pydf zip nmap fail2ban glances git

sudo apt-get install -y php5 apache2 libapache2-mod-php5 mysql-server php5-mysql php5-gd php5-mcrypt mysql-client php5-curl php5-xml

sudo a2enmod rewrite

#sudo ln -s /etc/phpmyadmin/apache.conf /etc/apache2/sites-available/phpmyadmin.conf
#sudo a2ensite phpmyadmin

sudo service apache2 reload

echo "Done."