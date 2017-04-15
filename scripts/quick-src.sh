#!/bin/bash

sudo apt-get update

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
( curl -s https://bootstrap.pypa.io/ez_setup.py | sudo python ) && \
sudo npm install -g json && \
sudo easy_install -ZU setuptools && \
mkdir ~/src
cd ~/src && \
(
    git clone -b dev git://github.com/openaps/decocare.git || \
        (cd decocare && git pull)
    (cd decocare && \
        sudo python setup.py develop
    )
    git clone git://github.com/openaps/dexcom_reader.git || \
        (cd dexcom_reader && git pull)
    (cd dexcom_reader && \
        sudo python setup.py develop
    )
    git clone -b dev git://github.com/openaps/openaps.git || \
        (cd openaps && git pull)
    (cd openaps && \
        sudo python setup.py develop
    )
    git clone git://github.com/openaps/openaps-contrib.git || \
        (cd openaps-contrib && git pull)
    (cd openaps-contrib && \
        sudo python setup.py develop
    )
    git clone -b dev git://github.com/openaps/oref0.git || \
        (cd oref0 && git pull)
)
test -d oref0 && \
cd oref0 && \
npm install && \
sudo npm install -g && \
sudo npm link && \
sudo npm link oref0

sudo openaps-install-udev-rules && \
sudo activate-global-python-argcomplete && \
openaps --version
