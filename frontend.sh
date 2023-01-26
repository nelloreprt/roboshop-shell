# using camel case, declaring variable for location
source common.sh

echo -e "\e[31m Install Nginx\e[0m"
yum install nginx -y &>>${LOG}
status_check


echo -e "\e[31m Remove the default content that web server is serving\e[0m"
rm -rf /usr/share/nginx/html/* &>>${LOG}
status_check


echo -e "\e[31m Download the frontend content\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>${LOG}
status_check


echo -e "\e[31m Extract the frontend content\e[0m"
cd /usr/share/nginx/html &>>${LOG}
status_check


unzip /tmp/frontend.zip &>>${LOG}
status_check


cp ${script_location}/files/nginx-roboshop.conf /etc/nginx/default.d/roboshop.conf &>>${LOG}
status_check


echo -e "\e[31m Enable Nginx service\e[0m"
systemctl enable nginx &>>${LOG}
status_check


echo -e "\e[31m # Restart Nginx Service to load the changes of the configuration\e[0m"
# Restart Nginx Service to load the changes of the configuration.
systemctl restart nginx &>>${LOG}
status_check

