#! /bin/bash


# make sure system is up to date
sudo apt-get update
sudo apt-get -y upgrade

# install essentials
sudo apt-get install -y htop nethogs iptraf pydf zip nmap fail2ban glances git

echo "Done."
