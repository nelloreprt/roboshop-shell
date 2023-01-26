# using camel case, declaring variable for location
script_location=$(pwd)
LOG=/tmp/roboshop.log

# we are enabling set
# which means if there is any error the script should stop and show the error, without going to the next command
#set -e

echo -e "\e[31m Setup NodeJS repos. NodeJs_Vendor is providing a script to setup the repos.\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash  &>>${LOG}
if [ $? -eq 0 ]
then
  echo Success
else
  echo Fail
exit
fi

echo -e "\e[31m Install NodeJS\e[0m"
yum install nodejs -y &>>${LOG}  &>>${LOG}
if [ $? -eq 0 ]
then
  echo Success
else
  echo Fail
exit
fi

echo -e "\e[31m Add application User\e[0m"
useradd roboshop &>>${LOG} &>>${LOG}
if [ $? -eq 0 ]
then
  echo Success
else
  echo Fail
  echo refer log file $LOG
exit

fi

echo -e "\e[31m Lets setup an app directory.\e[0m"
mkdir -p /app  &>>${LOG} &>>${LOG}
if [ $? -eq 0 ]
then
  echo Success
else
  echo Fail
exit
fi

echo -e "\e[31m Download the application code to created app directory.\e[0m"
curl -L -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>${LOG}
if [ $? -eq 0 ]
then
  echo Success
else
  echo Fail
exit
fi

cd /app &>>${LOG}
if [ $? -eq 0 ]
then
  echo Success
else
  echo Fail
exit
fi

echo -e "\e[31m to make the script run any number of times without error, we have to remove the exsisting content from "/app" folder\e[0m"
rm -rf * &>>${LOG}
if [ $? -eq 0 ]
then
  echo Success
else
  echo Fail
exit
fi

echo -e "\e[31m Unzipping to /tmp/catalogue\e[0m"
unzip /tmp/catalogue.zip &>>${LOG}
if [ $? -eq 0 ]
then
  echo Success
else
  echo Fail
exit
fi

cd /app &>>${LOG}
if [ $? -eq 0 ]
then
  echo Success
else
  echo Fail
exit
fi

npm install &>>${LOG}
if [ $? -eq 0 ]
then
  echo Success
else
  echo Fail
exit
fi

cp ${script_location}/files/catalogue.service /etc/systemd/system/catalogue.service &>>${LOG}
if [ $? -eq 0 ]
then
  echo Success
else
  echo Fail
exit
fi

echo -e "\e[31m Load the service.\e[0m"
systemctl daemon-reload &>>${LOG}
if [ $? -eq 0 ]
then
  echo Success
else
  echo Fail
exit
fi

echo -e "\e[31m Start the service.\e[0m"
systemctl enable catalogue &>>${LOG}
systemctl start catalogue &>>${LOG}
if [ $? -eq 0 ]
then
  echo Success
else
  echo Fail
exit
fi


cp ${script_location}/files/mongodb.repo /etc/yum.repos.d/mongo.repo &>>${LOG}
if [ $? -eq 0 ]
then
  echo Success
else
  echo Fail
exit
fi

echo -e "\e[31m Install mongo client in catalogue server\e[0m"
yum install mongodb-org-shell -y &>>${LOG}
if [ $? -eq 0 ]
then
  echo Success
else
  echo Fail
exit
fi

echo -e "\e[31m Load Schema\e[0m"
mongo --host mongodb-dev.nellore.online </app/schema/catalogue.js &>>${LOG}
if [ $? -eq 0 ]
then
  echo Success
else
  echo Fail
exit
fi




