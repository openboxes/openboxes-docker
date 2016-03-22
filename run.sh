#!/bin/bash
chmod 777 /usr/share/tomcat7/openboxes-config.properties
service mysql start
mysql -uroot -e "CREATE DATABASE openboxes"
mysql -uroot -e "GRANT ALL PRIVILEGES ON * . * TO 'root'@'%'"
mysql -uroot -e "UPDATE mysql.user SET Password=PASSWORD('test') WHERE User='root'"
mysql -uroot -ptest -e "FLUSH PRIVILEGES"
sudo service tomcat7 start

# The container will run as long as the script is running, that's why
# we need something long-lived here
exec tail -f /var/log/tomcat7/catalina.out
