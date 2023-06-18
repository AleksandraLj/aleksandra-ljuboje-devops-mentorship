#!/bin/bash
#Citanje vrijednosti iz liste definisane kao varijabla

#koristimo varijablu list koja sadrzi listu drzava

list="Alabama Mexico"
echo "Drzave koje se nalaze u prvobitnoj listi"
for state in $list
do 
    echo "Da li si ikada posjetio $state ?"
done

#append/ nadovezivanje u listi
list=$list" Italy"

echo "Drzave nakon dodavanje novih drzava"

for state in $list
do 
    echo "Da li si ikada posjetio $state ?"
done