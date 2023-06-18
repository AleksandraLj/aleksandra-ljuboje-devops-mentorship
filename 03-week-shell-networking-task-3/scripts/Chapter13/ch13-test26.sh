#!/bin/bash
# Kreiranje novih korisnickih naloga | user accounts
#Potrebno je kreirati csv fajl sa kolonama userid,user name gdje je user name - puno ime i prezime NOTE: csv fajl koristi , da odvoji podatke
#Skripta cita ID i imena korisnika iz users.csv fajla i koristi useradd komandu da kreira korisnike sa tim podacima

#while petlja postavlja IFS na , kako bi pravilno odvojii userid od name polja i čita ih u 'userid' i 'name' polja komande read
#echo komanda  nas obavjestava da pocinje dodavanje korisnika 
#useradd command kreira novog korisnika koristeci ID i name
# -c option za dodavanje komentara što je korisnikovo puno ime i prezime
# -m option za kreiranje home direktorija za korisnika 

#tail /etc/passwd da provjerimo na kraju fajla passwd da li su dodati novi korisnici

#sudo bash ch13-test26.sh poziv funkcije jer moramo imati root privilegije


input="users.csv"

while IFS=',' read -r userid name
do
 echo "adding $userid"
 useradd -c "$name" -m $userid
done < "$input"
