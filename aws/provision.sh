#!/bin/bash -xe
# exec > >(tee /var/log/pritunl-install-data.log|logger -t user-data -s 2>/dev/console) 2>&1yes

# export PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/opt/aws/bin:/root/bin
# echo "Pritunl Installing"
# yum update -y

# echo "* hard nofile 64000" >> /etc/security/limits.conf
# echo "* soft nofile 64000" >> /etc/security/limits.conf
# echo "root hard nofile 64000" >> /etc/security/limits.conf
# echo "root soft nofile 64000" >> /etc/security/limits.conf

# sudo tee /etc/yum.repos.d/mongodb-org-4.0.repo << EOF
# [mongodb-org-4.0]
# name=MongoDB Repository
# baseurl=https://repo.mongodb.org/yum/redhat/7/mongodb-org/4.0/x86_64/
# gpgcheck=1
# enabled=1
# gpgkey=https://www.mongodb.org/static/pgp/server-4.0.asc
# EOF

# sudo tee /etc/yum.repos.d/pritunl.repo << EOF
# [pritunl]
# name=Pritunl Repository
# baseurl=https://repo.pritunl.com/stable/yum/centos/7/
# gpgcheck=1
# enabled=1
# EOF

# sudo yum -y install oracle-epel-release-el7
# sudo yum-config-manager --enable ol7_developer_epel
# gpg --keyserver hkp://keyserver.ubuntu.com --recv-keys 7568D9BB55FF9E5287D586017AE645C0CF8E292A
# gpg --armor --export 7568D9BB55FF9E5287D586017AE645C0CF8E292A > key.tmp; sudo rpm --import key.tmp; rm -f key.tmp
# sudo yum -y remove iptables-services
# sudo yum -y install pritunl mongodb-org
# sudo systemctl start mongod pritunl
# sudo systemctl enable mongod pritunl

# cat <<EOF > /etc/logrotate.d/pritunl
# /var/log/mongodb/*.log {
#   daily
#   missingok
#   rotate 60
#   compress
#   delaycompress
#   copytruncate
#   notifempty
# }
# EOF

sudo apt update && sudo apt -y full-upgrade
# Add Pritunl and MongoDB repositories and public keys
echo "deb http://repo.pritunl.com/stable/apt $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/pritunl.list
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu $(lsb_release -cs)/mongodb-org/5.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-5.0.list
# Now add public keys for MongoDB and Pritunl repositories.
curl -fsSL https://www.mongodb.org/static/pgp/server-5.0.asc|sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/mongodb-5.gpg
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv 7AE645C0CF8E292A
sudo apt update
# Install Pritunl and MongoDB
sudo apt --assume-yes install pritunl mongodb-org
# Now start and enable Pritunl and MongoDB as below:
sudo systemctl start pritunl mongod
sudo systemctl enable pritunl mongod
