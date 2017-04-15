#!/bin/bash

sudo apt-get update && sudo apt-get -y upgrade

# Check the version of nodejs. If it's not installed install it
NODEJS=`nodejs --version`
if [ $? -ne 0 ]; then
  # use 'apt-get install -y nodejs-legacy' for old version of node
  curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
  sudo apt-get install -y nodejs
else
        echo "NodeJS version $NODEJS already installed"
fi

# Check the version of npm. If it's not installed install it
NPM=`npm --version`
if [ $? -ne 0 ]; then
   sudo apt-get install -y npm
else
   echo "NPM version $NPM already installed"
fi
# Node comes with npm installed so you should have a version of npm. However, npm gets updated more frequently than Node does, so you'll want to make sure it's the latest version.
npm install npm@latest -g

sudo apt-get install -y git python python-dev python-software-properties python-numpy python-pip watchdog strace tcpdump screen acpid vim locate jq ntpdate && \
sudo pip install -U openaps && \
sudo pip install -U openaps-contrib && \
sudo openaps-install-udev-rules && \
sudo activate-global-python-argcomplete && \
sudo npm install -g json oref0 && \
echo openaps installed && \
openaps --version


