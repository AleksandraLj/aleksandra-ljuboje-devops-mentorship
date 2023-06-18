#!/bin/bash
 # redirecting the for output to a file
 #ukoliko test23.txt ne postoji, kreira se novi fajl pod tim nazivom
 #ukoliko test23.txt postoji, prelijepice se sadrzaj preko trenutnog

 for (( a = 1; a < 10; a++ ))
 do
    echo "The number is $a"
 done > test23.txt
 echo "Komanda je zavrsena."