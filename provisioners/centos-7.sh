#!/bin/bash -xe

# Adding the MongoDB repository
sudo tee /etc/yum.repos.d/mongodb-org-3.4.repo << EOF
[mongodb-org-3.4]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/7/mongodb-org/3.4/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-3.4.asc
EOF

# Add Pritunl repository
sudo tee /etc/yum.repos.d/pritunl.repo << EOF
[pritunl]
name=Pritunl Repository
baseurl=https://repo.pritunl.com/stable/yum/centos/7/
gpgcheck=1
enabled=1
EOF

# install epel-release
yum -y install epel-release
sudo yum update

#  disable SELinux before continuing
sudo tee /etc/selinux/config << EOF
SELINUX=disabled
EOF

# Add Pritunl VPN GPG keys
gpg --keyserver hkp://keyserver.ubuntu.com --recv-keys 7568D9BB55FF9E5287D586017AE645C0CF8E292A
gpg --armor --export 7568D9BB55FF9E5287D586017AE645C0CF8E292A > temp.tmp; sudo rpm --import temp.tmp
rm -f temp.tmp

# Install Pritunl and MongoDB
yum -y install pritunl mongodb-org

# Start and enable MongoDB, Pritunl service
systemctl start mongod pritunl
systemctl enable mongod pritunl


