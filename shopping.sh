#!/bin/bash

service apache2 start
service mysql start

mysql --password= --user=root -e "create user 'user1'@'localhost' identified by 'user'"
mysql --password= --user=root -e "grant all privileges on * . * to 'user1'@'localhost'"
mysql --password= --user=root -e "select user from mysql.user"
mysql --password= --user=root -e "flush privileges"
mysql --password= --user=root -e "create database shopping"
mysql --password= --user=root -e "use shopping"
mysql --database=shopping --password= --user=root -e "source /newDir/Apps/Online Shopping Portal Project/SQL File/shopping.sql"
sleep 9999