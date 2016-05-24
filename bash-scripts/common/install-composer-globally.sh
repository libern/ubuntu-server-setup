#!/bin/bash

#
# UPDATE / UPGRADE
#

echo "--------------- Installing Composer Globally";

# Install Necessary Packages
sudo apt-get -y install curl git zip

# Install Composer
if [ ! -f /usr/local/bin/composer ]; then
    sudo curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer
fi