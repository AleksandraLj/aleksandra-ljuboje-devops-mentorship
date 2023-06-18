#!/bin/bash
#Citanje vrijednosti iz liste definisane kao varijabla


#koristen niz my_list kao i ${my_list[@]} bash array expander

my_list=("Alabama" "Canada")   
echo "Drzave koje se nalaze u prvobitnoj listi"
for state in "${my_list[@]}"
do 
    echo "Da li si ikada posjetio $state ?"
done

#append/ nadovezivanje u listi
my_list+=("Bosna i Hercegovina" "Mexico")

echo "Drzave nakon dodavanje novih drzava"

for state in "${my_list[@]}"
do 
    echo "Da li si ikada posjetio $state ?"
done


