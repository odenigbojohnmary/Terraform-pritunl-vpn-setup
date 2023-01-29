#!/bin/bash -xe

# Update Debian system
sudo apt update && sudo apt -y full-upgrade

# Install basic utility packages required for this operation
sudo apt update
sudo apt install gpg curl gnupg2 software-properties-common apt-transport-https lsb-release ca-certificates

# Import MongoDB APT repository keys to your system
curl -fsSL https://www.mongodb.org/static/pgp/server-5.0.asc|sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/mongodb-5.gpg

# Import Pritunl VPN GPG keys:
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv 7AE645C0CF8E292A

# Add Pritunl repository:
echo "deb http://repo.pritunl.com/stable/apt $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/pritunl.list

# Add Mongodb repository 
echo "deb http://repo.mongodb.org/apt/debian buster/mongodb-org/5.0 main" | sudo tee /etc/apt/sources.list.d/mongodb-org-5.0.list

#  Install Pritunl and MongoDB
sudo apt update
sudo apt install mongodb-org  pritunl 

# Now start and enable Pritunl and MongoDB
sudo systemctl start pritunl mongod
sudo systemctl enable pritunl mongod