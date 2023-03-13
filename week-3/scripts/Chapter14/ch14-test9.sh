#!/bin/bash
# Testing parameters
#Ukoliko unesemo manje od 2 ili više od dva parametra, ispisaće se poruka sa uputstvom za koristenje skripte 

if [ $# -ne 2 ]
then
 echo
 echo Pogresan unos! Premalo ili previše unesenih parametara.
 echo Usage:ch14-test9.sh  a b
 echo
else
 total=$(( $1 + $2 ))
 echo
 echo The total is $total
 echo
fi