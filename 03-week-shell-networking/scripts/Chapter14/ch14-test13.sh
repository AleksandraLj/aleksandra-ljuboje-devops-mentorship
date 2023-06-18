#!/bin/bash
# demonstrating the shift command
#shift po defaultu pomjera parametre jedno mjesto u lijevo

echo
count=1
while [ -n "$1" ]
do
 echo "Parameter #$count = $1"
 count=$(($count + 1 ))
 shift
done