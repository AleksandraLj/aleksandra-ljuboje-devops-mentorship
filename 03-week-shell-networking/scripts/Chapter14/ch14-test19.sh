#!/bin/bash
# getopts komanda 
#u case ne moraju da se stavljaju - jer ih getopts sam uklanja 
# da ne ispisujemo error poruke na pocetku optstring-a stavimo : (za razliku od getopt gdje smo stavljali -q)
echo
while getopts :ab:c opt
do
    echo $opt
    case "$opt" in
    a) echo "Found the -a option" ;;
    b) echo "Found the -b option, with value $OPTARG";;
    c) echo "Found the -c option" ;;
    *) echo "Unknown option: $opt";;
    esac
done