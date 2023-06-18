#!/bin/bash


 sudo yum localinstall -y mysql57-community-release-el7-8.noarch.rpm
 sudo yum install -y mysql-community-server
 sudo systemctl start mysqld
 sudo systemctl enable mysqld
