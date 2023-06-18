#!/bin/bash

#iteracija kroz file 1. ugnjezdene petlje 2. promjena IFS varijable
#Skripta cita sadrzaj /etc/passwd fajla koji cuva informacije o korisnickim nalozima korisnika Linux sistema
#IFS=$'\n' kada skripta procita svaku liniju u  /etc/passwd fajlu, razdvojice linije u nove ulaze u zavisnosti gdje se new-line nalazio
#Zatim IFS postavimo na : kako bismo iz svakog entry-a mogli izdvojiti korisnike. Korisnici su odvojeni : u Linux sistemima

#IFS.OLD=$IFS    #tacka je prodblem kod nekih terminala i treba se koristiti _
IFS_OLD=$IFS
IFS=$'\n'

for entry in $(cat /etc/passwd)
do    
    echo "Vrijednost u $entry -"
    IFS=:
    for value in $entry 
    do  
        echo "  $value"
    done    
done
    

