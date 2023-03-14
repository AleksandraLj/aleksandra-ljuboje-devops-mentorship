#!/bin/bash

#reading a directory using wildcard
# file globbing 
# "$file" stavljamo pod ".." da izbjegnemo probleme ako fajlovi u nazivu imaju space 
# NAPOMENA: [ ... ] kod ovih zagrada obavezno jedan space nakon i prije zagrade 

for file in /mnt/c/Users/aleks/Desktop/scripts/*
do
    if [ -d "$file" ]
    then 
        echo "$file je direktorijum"
    elif [ -f "$file" ]
    then    
        echo "$file je fajl"
    fi
done 
