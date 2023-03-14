#!/bin/bash
 # breaking out of an outer loop
# kada b bude vece od 4 tj. b=5 izadji iz vanjske for petlje preko break 2
 for (( a = 1; a < 4; a++ ))
 do
    echo "Outer loop: $a"
    for (( b = 1; b < 100; b++ ))
    do
        if [ $b -gt 4 ]
        then
            break 2
        fi
        echo " Inner loop: $b"
    done
 done
 echo "a=$a, b=$b"