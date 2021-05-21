#!/bin/bash

service apache2 start
service mysql start

mysql --password= --user=root -e "create user 'user1'@'localhost' identified by 'user'"
mysql --password= --user=root -e "grant all privileges on * . * to 'user1'@'localhost'"
mysql --password= --user=root -e "select user from mysql.user"
mysql --password= --user=root -e "flush privileges"
mysql --password= --user=root -e "create database hms"
mysql --password= --user=root -e "use hms"
mysql --database=hms --password= --user=root -e "source /newDir/Apps/Hospital Management System Project/SQL File/hms.sql"
sleep 9999