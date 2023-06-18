#!/bin/bash
# hiding input data from the monitor
#-s skrivanje sifre - sifra je prikazana, ali read komanda prikazuje text boju u boji pozadine 
read -s -p "Enter your password: " pass
echo
echo "Is your password really $pass? "