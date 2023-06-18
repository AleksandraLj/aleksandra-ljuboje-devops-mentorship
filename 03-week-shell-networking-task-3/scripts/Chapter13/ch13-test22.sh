#!/bin/bash
 # continuing an outer loop
 #kada a=3, b=1  preskocice se unutrasnja for petlja za tu iteraciju i nastavice se a++, a =4 itd.

 for (( a = 1; a <= 5; a++ ))
 do
        echo "Iteration $a:"
    for (( b = 1; b < 3; b++ ))
    do
        if [ $a -gt 2 ] && [ $a -lt 4 ]
        then
             echo "a=$a, b=$b"
            continue 2
        fi
        var3=$((a * b))
        echo " The result of $a * $b is $var3"
    done
 done
 echo "a=$a, b=$b"