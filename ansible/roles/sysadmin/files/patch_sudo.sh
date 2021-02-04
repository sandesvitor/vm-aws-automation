#!/bin/bash

# Patch sudo to version 1.9.5p2 to avoid CVE-2021-3156 
# buffer overflow exploit!
sudo apt-get update && sudo apt-get -y install make build-essential
cd /tmp
wget "https://www.sudo.ws/dist/sudo-1.9.5p2.tar.gz"
tar xvzf sudo-1.9.5p2.tar.gz 
cd sudo-1.9.5p2/  
./configure
make && sudo make install 