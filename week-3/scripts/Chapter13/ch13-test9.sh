#!/bin/bash

#Iteracija više varijabli u istoj for petlji C style in bash 

for (( a=1, b=10; a <= 10; a++, b-- )) 
do
    echo "$a - $b"
done
 