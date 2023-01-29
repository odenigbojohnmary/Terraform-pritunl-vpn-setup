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
