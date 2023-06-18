#!/bin/bash

#while petlja 
#koristi  izraz -gt "greater than" za poredjenje; $($var-1) dekrement vrijednosti u varijabli var

var1=10

while [ $var1 -gt 0 ]
do 
    echo $var1
    ((var1--))
done