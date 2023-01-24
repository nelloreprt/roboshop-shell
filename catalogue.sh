# using camel case, declaring variable for location
script_location=$(pwd)

# Setup NodeJS repos. NodeJs_Vendor is providing a script to setup the repos.
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

# Install NodeJS
yum install nodejs -y

# Add application User
useradd roboshop

#Lets setup an app directory.
mkdir /app

#Download the application code to created app directory.
curl -L -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
cd /app
unzip /tmp/catalogue.zip

cd /app
ls
npm install

cp -r ${script_location}/files/catalogue.service /etc/systemd/system/catalogue.service

#Load the service.
systemctl daemon-reload

#Start the service.
systemctl enable catalogue
systemctl start catalogue
systemctl status catalogue
q

cp -r ${script_location}/files/mongo.repo /etc/yum.repos.d/mongo.repo

#Install mongo client in catalogue server
yum install mongodb-org-shell -y

#Load Schema
mongo --host MONGODB-SERVER-IPADDRESS </app/schema/catalogue.js





