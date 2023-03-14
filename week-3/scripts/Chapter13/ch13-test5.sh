#!/bin/bash

#citanje vrijednosti preko komande/iz fajla

#ukoliko file nije u istom dir, navesti punu putanju do fajla
file="states.txt"

echo "**Ovo je ispis kao na primjeru iz Bible Ch 13 test5**"
for state in $(cat $file)
do  
    echo "Posjeti predivnu drzavu $state"

done

echo "***Ovo je primjer ispisa kada se koristi niz***"

niz_drzava=()   # inicijalizujemo prazni niz

while read -r line
do
  niz_drzava+=("$line")   # dodaj liniju u niz
done < states.txt   # citaj iz fajla states.txt

# ispis niza
for element in "${niz_drzava[@]}"
do
  echo "$element"
done