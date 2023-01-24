# using camel case, declaring variable for location
script_location=$(pwd)

# we are enabling set
# which means if there is any error the script should stop and show the error, without going to the next command
set -e

# Setup NodeJS repos. NodeJs_Vendor is providing a script to setup the repos.
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

# Install NodeJS
yum install nodejs -y

# Add application User
useradd roboshop

#Lets setup an app directory.
mkdir -p /app

#Download the application code to created app directory.
curl -L -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
cd /app

#to make the script run any number of times without error, we have to remove the exsisting content from "/app" folder
rm -rf *

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


cp -r ${script_location}/files/mongo.repo /etc/yum.repos.d/mongo.repo

#Install mongo client in catalogue server
yum install mongodb-org-shell -y

#Load Schema
mongo --host localhost </app/schema/catalogue.js





