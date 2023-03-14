#!/bin/bash

 # breaking out of a for loop
 #kada varijabla var1 bude jednaka 5, pozvace se komanda break koja prekida izvrsenje

 for var1 in 1 2 3 4 5 6 7 8 9 10 11
 do
    if [ $var1 -eq 5 ]
    then
        break
    fi
    echo "Iteration number: $var1"
 done
 echo "Izasli smo iz for petlje"