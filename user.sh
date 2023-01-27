source common.sh

print_head "Setup NodeJS repos"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${LOG}
status_check

print_head "Install NodeJS"
yum install nodejs -y  &>>${LOG}
status_check

print_head "Add Application User"
useradd roboshop &>>${LOG}
id roboshop &>>${LOG}
if [ $? -ne 0 ]; then
  useradd roboshop &>>${LOG}
fi
status_check

mkdir -p /app &>>${LOG}

print_head "Downloading App content"
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip &>>${LOG}
status_check

print_head "Cleanup Old Content"
rm -rf /app/* &>>${LOG}
status_check

print_head "Extracting App Content"
cd /app
unzip /tmp/user.zip &>>${LOG}
status_check

print_head "Installing NodeJS Dependencies"
cd /app &>>${LOG}
npm install &>>${LOG}
status_check

print_head "Configuring Catalogue Service File"
cp ${script_location}/files/user.service /etc/systemd/system/user.service &>>${LOG}
status_check

print_head "Reload SystemD"
systemctl daemon-reload &>>${LOG}
status_check

print_head "Enable Catalogue Service "
systemctl enable user &>>${LOG}
status_check

print_head "Start Catalogue service "
systemctl start user &>>${LOG}
status_check

print_head "Configuring Mongo Repo "
cp ${script_location}/files/mongodb.repo /etc/yum.repos.d/mongo.repo &>>${LOG}
status_check

print_head "Install Mongo Client"
yum install mongodb-org-shell -y &>>${LOG}
status_check

print_head "Load Schema"
mongo --host mongodb-dev.nellore.online </app/schema/user.js &>>${LOG}
status_check