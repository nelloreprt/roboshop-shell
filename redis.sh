source common.sh

print_head "Redis is offering the repo file as a rpm"
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y &>>${LOG}
status_check

print_head "Enable Redis 6.2 from package streams"
dnf module enable redis:remi-6.2 -y  &>>${LOG}
status_check

print_head "Install Redis"
yum install redis -y &>>${LOG}
status_check

print_head "Update MongoDB Listen Address"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/redis.conf /etc/redis/redis.conf &>>${LOG}
status_check

print_head "Enable Redis Service"
systemctl enable redis &>>${LOG}
status_check

print_head "Start Redis Service"
systemctl restart redis &>>${LOG}
status_check