#!/bin/bash

# Provjeravamo da li je ulazni parametar duzine vece od 0 tj. non-empty pomocu -n --> [ -n "$1" ]

if [ -n "$1" ]
then 
    echo Hello "$1, glad to meet you."
else
    echo "Sorry, you did not identify yourself."
fi