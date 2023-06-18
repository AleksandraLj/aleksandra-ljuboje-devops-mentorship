#!/bin/bash
#Skripta pretrazuje executable fajlove u PATH 
# kod poziva koristiti | more kako bi se ljepse prikazivali fajlovi ; izaci sa q

IFS=:
for folder in $PATH
do
    echo "$folder:"
    for file in $folder/*
    do
        if [ -x $file ]
        then
            echo " $file"
        fi
    done
done