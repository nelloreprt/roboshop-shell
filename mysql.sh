source common.sh

print_head "lets disable MySQL 8 version"
dnf module disable mysql -y &>>${LOG}
status_check


print_head "Setup the MySQL5.7 repo file"
cp ${script_location}/files/mysql.repo /etc/yum.repos.d/mysql.repo &>>${LOG}
status_check

print_head "Install MySQL Server"
yum install mysql-community-server -y  &>>${LOG}
status_check

print_head "Start MySQL Service"
systemctl enable mysqld &>>${LOG}
status_check

print_head "Start MySQL Service"
systemctl start mysqld &>>${LOG}
status_check

print_head "Mysql_secure_installation >> is a program given by mysql to reset password"
mysql_secure_installation --set-root-pass RoboShop@1
status_check

print_head "You can check the new password working or not"
mysql -uroot -pRoboShop@1
status_check