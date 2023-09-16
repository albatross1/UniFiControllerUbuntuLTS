#!/bin/bash

# WARNING: This script uses an outdated version of MongoDB. Consider updating to a newer version or using an alternative database.

# Based on UI documentation https://help.ui.com/hc/en-us/articles/220066768-UniFi-How-to-Install-and-Update-via-APT-on-Debian-or-Ubuntu

# Install base needs and java 11
sudo apt-get update && sudo apt-get install ca-certificates apt-transport-https openjdk-11-jre-headless

# Add Ubiquiti & Mongo to the sources
echo 'deb https://www.ui.com/downloads/unifi/debian stable ubiquiti' | sudo tee /etc/apt/sources.list.d/100-ubnt-unifi.list
echo "deb https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.4.list

# Add trust for Ubiquiti and Mongo sources
wget -qO - https://www.mongodb.org/static/pgp/server-3.4.asc | sudo apt-key add -
sudo wget -O /etc/apt/trusted.gpg.d/unifi-repo.gpg https://dl.ui.com/unifi/unifi-repo.gpg

# Hold the java version for compatibility so it does not break with updates
sudo apt-mark hold openjdk-11-*

# Add the Focal security repository to get the required libssl1.1 version
sudo add-apt-repository "deb http://security.ubuntu.com/ubuntu focal-security main"
sudo apt-get update

# Install libssl1.1 from the Focal security repository
sudo apt-get install libssl1.1

# Install MongoDB and UniFi controller
sudo apt-get install -y mongodb-org
sudo apt-get install unifi -y

# Start and enable the UniFi service
sudo systemctl start unifi
sudo systemctl enable unifi
