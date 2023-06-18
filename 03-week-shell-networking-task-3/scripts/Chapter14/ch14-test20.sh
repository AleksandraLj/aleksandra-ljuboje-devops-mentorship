#!/bin/bash
# Processing options & parameters with getopts
#
echo
while getopts :ab:cd opt
do
 case "$opt" in
 a) echo "Found the -a option" ;;
 b) echo "Found the -b option, with value $OPTARG" ;; #OPTRARG env. varijabla koja cuva vrijednost parametra ako se zahtjeva
 c) echo "Found the -c option" ;;
 d) echo "Found the -d option" ;;
 *) echo "Unknown option: $opt" ;;
 esac
done
#
shift $(($OPTIND - 1))  #OPTIND env.varijabla koja cuva vrijednost trenutne lokacije parametra u listi
#
echo
count=1
echo $@
for param in "$@"
do
 echo "Parameter $count: $param"
 count=$(($count + 1))
done