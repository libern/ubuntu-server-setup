#!/bin/bash

# https://redis.io/docs/install/install-redis/install-redis-on-linux/

#
# UPDATE / UPGRADE
#

echo "--------------- Update";

curl -fsSL https://packages.redis.io/gpg | sudo gpg --dearmor -o /usr/share/keyrings/redis-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/redis-archive-keyring.gpg] https://packages.redis.io/deb $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/redis.list

sudo apt-get update;

#
#  INSTALL
#

echo "--------------- Installing Redis";

# Redis
sudo apt-get install redis;
