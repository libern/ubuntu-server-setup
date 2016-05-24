#!/bin/bash

#
# UPDATE / UPGRADE
#

echo "--------------- Installing Laravel 5";

# Install Necessary Packages
sudo apt-get -y install curl git zip

# Install Laravel
composer global require "laravel/installer"