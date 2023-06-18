#!/bin/bash
# getting just one character of input
# -n1 naglasava komandi read da prihvati samo jedan karakter kao odgovor
read -n1 -p "Do you want to continue [Y/N]? " answer
case $answer in
Y | y) echo
 echo "fine, continue on…";;
N | n) echo
 echo OK, goodbye
 exit;;
esac
echo "This is the end of the script"