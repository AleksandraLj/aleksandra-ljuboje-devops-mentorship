#!/bin/bash

#for petlja unutar while petlje

var1=5

while [ $var1 -ge 0 ] 
do 
    echo "Usli smo u while petlju. Vrijednost var1=$var1"
    for (( var2 = 1; var2 < 3; var2++ ))
    do
        #var3=$[ $var1 * $var2] nije moguće izvršiti komandu pomoću ovoga
        var3=$((var1 * var2))
        echo " Unutrašnja for petlja je pokrenuta. $var1 * $var2 = $var3"
    done   
    var1=$((var1 - 1)) #još jedan način za decrement
done    
    