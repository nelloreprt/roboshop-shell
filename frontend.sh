# using camel case, declaring variable for location
script_location=$(pwd)

echo -e "\e[31m Install Nginx\e[0m"
yum install nginx -y

echo -e "\e[31m Enable Nginx service\e[0m"
systemctl enable nginx

echo -e "\e[31m Start Nginx service\e[0m"
systemctl start nginx

# Remove the default content that web server is serving.
rm -rf /usr/share/nginx/html/*

# Download the frontend content
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip

# Extract the frontend content.
cd /usr/share/nginx/html
unzip /tmp/frontend.zip

cp -r ${script_location}/files/nginx-roboshop.conf /etc/nginx/default.d/roboshop.conf

# Restart Nginx Service to load the changes of the configuration.
systemctl restart nginx
