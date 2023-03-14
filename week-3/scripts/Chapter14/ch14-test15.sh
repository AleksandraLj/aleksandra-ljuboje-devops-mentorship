#!/bin/bash
# extracting command line options as parameters
#dodatak sa echo $* kako bismo vidjeli status unosa nakon shift komande u case slucaju 

echo
while [ -n "$1" ]
do
    echo "Komande: $*"
    echo
 case "$1" in
 -a) echo "Found the -a option" ;;
 -b) echo "Found the -b option" ;;
 -c) echo "Found the -c option" ;;
 *) echo "$1 is not an option" ;;
 esac
 shift
done