# using camel case, declaring variable for location
script_location=$(pwd)

cp -r ${script_location}/files/mongodb.repo /etc/yum.repos.d/mongo.repo

#Install MongoDB
yum install mongodb-org -y

#Start & Enable MongoDB Service
systemctl enable mongod
systemctl start mongod


#To check mongodb port number >> 27017  (port range on server 0-65565)
netstat -lntp | grep mongo

#Update listen address from 127.0.0.1 to 0.0.0.0 in /etc/mongod.conf
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
