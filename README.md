# Terraform-pritunl-vpn-setup
Setup Pritunl VPN using AWS, GCP or Azure.

# After provisioning Access the Pritunl interface by using the public IP of your server.

![My Image](pritunl-first-screen.png)

# Login running the login to the server and run the following command: 
 # To Generate setup-key by running the command below:
 sudo pritunl setup-key

 ![My Image](pritunl-second-screen.png)

#  To generate the pritunl default password:
pritunl default-password

# After enter the details in the screen above.

 # change default username and password(recommended) and also add the url to be used when access the pritunl (ensure the server IP is already added to the hosting company you are using) pritunl using letsencrypt to generate the certificate for you.

![My Image](change-login-details.png)

# Add an organisation using name of your oragnisation(recommended)
![My Image](add-org.png)

![My Image](create-org.png)

# create a user

![My Image](create-user.png)

# Add a server
![My Image](add-server.png)


# Attach a server to the organistion
![My Image](attach-server-to-org.png)

# start the server
![My Image](astart-server.png)
