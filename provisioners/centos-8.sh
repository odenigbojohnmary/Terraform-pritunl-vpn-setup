#!/bin/bash -xe

# Add the repositories for MongoDB 
sudo tee /etc/yum.repos.d/mongodb-org.repo<<EOF
[mongodb-org]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/8/mongodb-org/5.0/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-5.0.asc
EOF

# Add Pritunl repository
sudo tee /etc/yum.repos.d/pritunl.repo<<EOF
[pritunl]
name=Pritunl Repository
baseurl=https://repo.pritunl.com/stable/yum/oraclelinux/8/
gpgcheck=1
enabled=1
EOF

# Add Pritunl VPN GPG keys
sudo gpg --keyserver hkp://keyserver.ubuntu.com --recv-keys 7568D9BB55FF9E5287D586017AE645C0CF8E292A
sudo gpg --armor --export 7568D9BB55FF9E5287D586017AE645C0CF8E292A > key.tmp; sudo rpm --import key.tmp; rm -f key.tmp

# Install EPEL-Release
sudo dnf -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm

# Install Pritunl and MongoDB
sudo dnf install pritunl mongodb-org

# Start and enable MongoDB, Pritunl service
sudo systemctl start mongod pritunl
sudo systemctl enable mongod pritunl
