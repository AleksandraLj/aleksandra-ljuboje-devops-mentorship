#!/bin/bash
# Čitanje vrijednosti iz liste
#nazivi u listi, sa više riječi obavezno se pišu pod "..."

for test in Mexico "New York" Canada "Bosna i Hercegovina" 
do
    echo "Sljedeca drzava je $test"
    
done

#Nakon izlaska iz for petlje test čuva ime posljednje drzave u listi
echo "Posljednja drzava koju smo posjetili je $test" 

#dodijelimo novu vrijednost varijabli test
test=Italy 
echo "Cekaj, sada smo u $test"


