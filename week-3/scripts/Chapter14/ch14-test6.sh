#!/bin/bash

#skripta provjerava da li je naziv skripte addem ili multem i izrvšava potrebna računanja
# poziv skripte 
# 1. cp ch14-test6.sh addem da kopiramo skriptu u addem
# chmod u+x addem

#2. simbolicki link za kreiranje fajla ln -s ch14-test6.sh multem

# provjera ls -l *em 

name=$(basename $0)

if [ $name = "addem" ]
then 
    total=$(($1 + $2))
elif [ $name = "multem" ]
then 
    total=$(($1 * $2))
fi

echo  
echo "Izracunata vrijednost je $total"
