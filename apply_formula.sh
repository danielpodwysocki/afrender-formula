#!/bin/bash

#A script to apply the formula for the AWS AMI build
#It removes salt-minion after successful usage

sudo apt-get install curl -y

sudo curl -fsSL -o /usr/share/keyrings/salt-archive-keyring.gpg https://repo.saltproject.io/py3/debian/10/amd64/latest/salt-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/salt-archive-keyring.gpg] https://repo.saltproject.io/py3/debian/10/amd64/latest buster main" | sudo tee /etc/apt/sources.list.d/salt.list
sudo apt-get update
sudo apt-get install salt-minion -y

#apply the formula 
sudo salt-call --local --file-root=/home/admin/salt --pillar-root=/home/admin/pillar state.highstate
#remove the salt-minion
sudo apt-get purge salt-minion -y
