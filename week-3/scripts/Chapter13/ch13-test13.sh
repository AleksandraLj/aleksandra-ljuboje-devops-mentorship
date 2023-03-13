#!/bin/bash

#until petlja sa dva uslova
# radii dok varijabla var ne bude jednaka 0

var1=100

until echo $var1 ; [ $var1 -eq 0 ]
do
    echo "Unutar petlje: $var1"
    ((var1-=25)) # opcija sa $[ $var1 -25 ] nije radila!

done