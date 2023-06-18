#!/bin/bash

#koristenje until i while loop zajedno 
# vanjska until petlja kreće od 3 i nastavlja do vrijednosti 0
# unutrasnja while petlja krece od 1 i radi dok je vrijednost manja od 5
# uslovi moraju biti ispunjeni inače idemo u beskonačnu petlju 
#scale je floating point; postavljamo na koliko decimala zaokružujemo rezultat
# bc bash calculator 

var1=3

until [ $var1 -eq 0 ]

do 
    echo "Until petlja. Vrijednost var1= $var1"

    var2=1  

    while [ $var2 -lt 5 ]
    do 
        if [ $var2 -eq 0 ]; then
          echo "Error: Division by zero"
          break
         fi
        var3=$(echo "scale=4; $var1 / $var2" | bc)
        echo "Unutrasnja while petlja: $var1 / $var2 = $var3"
         var2=$((var2 + 1))


    done
    ((var1--))

done  

