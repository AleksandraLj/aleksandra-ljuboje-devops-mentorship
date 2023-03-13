#!/bin/bash
 # breaking out of an inner loop
 #svaki put kada b bude jednako 5, prekida se izvrsenje unutrasnje for petlje i nastavlja se iteracija vanjske

 for (( a = 1; a < 4; a++ ))
 do
    echo "Vanjska petlja: $a"
    for (( b = 1; b < 100; b++ ))
    do
        if [ $b -eq 5 ]
        then
            break
        fi
        echo " Unutrasna petlja: $b"
    done
 done

 echo "Vanjska for petlja se zavrsila a=$a"