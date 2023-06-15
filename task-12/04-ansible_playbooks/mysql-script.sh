#!/bin/bash

 sudo rpm --import https://repo.mysql.com/RPM-GPG-KEY-mysql-2022
 wget http://dev.mysql.com/get/mysql57-community-release-el7-8.noarch.rpm
 sudo yum localinstall -y mysql57-community-release-el7-8.noarch.rpm
 sudo yum install -y mysql-community-server
 sudo systemctl start mysqld
 sudo systemctl enable mysqld