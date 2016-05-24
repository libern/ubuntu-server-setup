#! /bin/bash

echo "------------"
echo "Setting locale to en_US..."

#sudo echo 'LANG="en_US.UTF-8"
#LC_MESSAGES="C"
#LC_ALL="en_US.UTF-8"' >> /etc/environment

echo 'LANG="en_US.UTF-8"
LC_MESSAGES="C"
LC_ALL="en_US.UTF-8"' | sudo tee -a /etc/environment

echo "After reboot, use 'locale' to check"
sudo reboot