# using camel case, declaring variable for location
source common.sh

# we are enabling set
# which means if there is any error the script should stop and show the error, without going to the next command
#set -e



echo -e "\e[31m Setup NodeJS repos. NodeJs_Vendor is providing a script to setup the repos.\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash  &>>${LOG}
status_check

echo -e "\e[31m Install NodeJS\e[0m"
yum install nodejs -y &>>${LOG}  &>>${LOG}
status_check

echo -e "\e[31m Add application User\e[0m"
useradd roboshop &>>${LOG} &>>${LOG}
status_check

echo -e "\e[31m Lets setup an app directory.\e[0m"
mkdir -p /app  &>>${LOG} &>>${LOG}
status_check

echo -e "\e[31m Download the application code to created app directory.\e[0m"
curl -L -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>${LOG}
status_check

cd /app &>>${LOG}
status_check

echo -e "\e[31m to make the script run any number of times without error, we have to remove the exsisting content from "/app" folder\e[0m"
rm -rf * &>>${LOG}
status_check

echo -e "\e[31m Unzipping to /tmp/catalogue\e[0m"
unzip /tmp/catalogue.zip &>>${LOG}
status_check

cd /app &>>${LOG}
status_check

npm install &>>${LOG}
status_check

cp ${script_location}/files/catalogue.service /etc/systemd/system/catalogue.service &>>${LOG}
status_check

echo -e "\e[31m Load the service.\e[0m"
systemctl daemon-reload &>>${LOG}
status_check

echo -e "\e[31m Start the service.\e[0m"
systemctl enable catalogue &>>${LOG}
systemctl start catalogue &>>${LOG}
status_check


cp ${script_location}/files/mongodb.repo /etc/yum.repos.d/mongo.repo &>>${LOG}
status_check

echo -e "\e[31m Install mongo client in catalogue server\e[0m"
yum install mongodb-org-shell -y &>>${LOG}
status_check

echo -e "\e[31m Load Schema\e[0m"
mongo --host mongodb-dev.nellore.online </app/schema/catalogue.js &>>${LOG}
status_check




