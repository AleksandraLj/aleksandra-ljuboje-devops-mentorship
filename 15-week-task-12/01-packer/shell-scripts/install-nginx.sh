#/bin/bash

echo "This is script to enable nginx  yum repositories"
sleep 30
echo Updating yum 
sudo yum update -y
sudo yum install -y yum-utils

