#!/bin/bash

#while petlja sa dva uslova
#koristi  izraz -gt "greater than" za poredjenje; $($var-1) dekrement vrijednosti u varijabli var

var1=10

while echo $var1 ; [ $var1 -ge 0 ] #dvije komande ; ili novi red
do 
    echo "Ovo je unutar petlje"
    ((var1--))
done