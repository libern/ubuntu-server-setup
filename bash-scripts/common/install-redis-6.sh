#!/bin/bash

#
# UPDATE / UPGRADE
#

echo "--------------- Update";

sudo apt-get install software-properties-common -y
sudo apt-get update;
sudo apt-get -y upgrade;

#
#  INSTALL
#

echo "--------------- Installing Redis";

# Redis
sudo apt-get purge redis-server
sudo add-apt-repository ppa:chris-lea/redis-server -y
sudo apt-get update
sudo apt -y install redis-server
