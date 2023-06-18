#/bin/bash

#Commands for installing MySQL on Amazon Linux 2023:
#[EDIT]: These are the commands that Dzenan pasted into Zoom chat by the end of our week-9 2nd lecture.

echo "This is script to enable  mysql  repositories"
sudo rpm --import https://repo.mysql.com/RPM-GPG-KEY-mysql-2022

wget http://dev.mysql.com/get/mysql57-community-release-el7-8.noarch.rpm

