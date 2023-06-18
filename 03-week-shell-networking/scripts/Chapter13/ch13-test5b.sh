#!/bin/bash

#citanje vrijednosti preko komande/iz fajla i promjena IFS

#ukoliko file nije u istom dir, navesti punu putanju do fajla
file="states.txt"

#IFS prepoznaje samo novi-red, ignorise space i tab
IFS=$'\n'
for state in $(cat $file)
do  
    echo "Posjeti predivnu drzavu $state"

done