#!/bin/bash

#until petlja 
# radii dok varijabla var ne bude jednaka 0

var1=100

until [ $var1 -eq 0 ]
do
    echo $var1
    ((var1-=25)) # opcija sa $[ $var1 -25 ] nije radila!

done