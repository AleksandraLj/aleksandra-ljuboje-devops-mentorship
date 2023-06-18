#!/bin/bash

#nestet loops | ugnježdene petlje 

for (( a = 1; a <= 3; a++ ))
do
    echo "Prva for petlja je pokrenuta. Vrijednost a je $a"
    for (( b = 1; b <= 3; b++ ))
    do 
        echo "Unutar petlje b je $b"
    done 
done