#!/bin/bash

#reading multiple directory using wildcard
# file globbing 
# "$file" stavljamo pod ".." da izbjegnemo probleme ako fajlovi u nazivu imaju space 
# NAPOMENA: [ ... ] kod ovih zagrada obavezno jedan space nakon i prije zagrade 
# na lokaciji mnt/c/users/aleks/Desktop/probne nema ništa, tj ne postoji file ili dir pod nazivom proba

for file in /mnt/c/Users/aleks/Desktop/scripts/* mnt/c/users/aleks/Desktop/probne
do
    if [ -d "$file" ]
    then 
        echo "$file je direktorijum"
    elif [ -f "$file" ]
    then    
        echo "$file je fajl"
    else 
        echo "$file ne postoji"
    fi
done 