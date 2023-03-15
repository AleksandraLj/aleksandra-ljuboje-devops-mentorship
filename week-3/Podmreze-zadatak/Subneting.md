Kolege evo jedan primjer na kojem možete provježbati **kreiranje podmreža**

**Tekst zadatka glasi:**
*Kreirati podmreže za mrežu `10.1.16.0/20`, date su LAN mreže i potreban broj hostova*

**LAN1 -200, LAN2 -30, LAN3-122, LAN4 -600, LAN5 -300**

*I na kraju, koji je broj IP adresa koje su dostupne za dodjelu drugim podmrežama?*

**Koraci pri rješavanju:**
1. Sve LAN-ove koji su podmreže poredate u **opadajućem redoslijedu** od najvećeg ka najmanjem, jer prvo dodjelite podmrežu onom LAN-u koji zahtjeva najviše host-ova. 
2. Zatim računamo koliko stvarno adresa moramo imati:

**LAN4 - 600 host +2 (adr.mreže i broadcast) = 602 adrese -> 2na10** je najbliži veći broj tj. **1024**
    * Iz **2na10** znamo masku za ovu podmrežu -> **32 - 10 =22 dakle maska za LAN4 je /22**
*Postupak ponovimo za sve LAN podmreže*


3. **maska mreže `10.1.16.0` koju dijelimo je `/20` šta znamo iz ovog podatka?**
    * maska izgleda ovako `11111111.11111111.11110000.00000000`-> 12 nula = 2na12 dostupnih adresa za hostove
    * "caka": IP adresa je 32bitna -> 32-20 = 12 (20 je iz maske) -> znači imamo **2na12 hostova na raspolaganju**
4. Odredimo adresu mreže
5. Odredimo broadcast adresu

Ove "formule" ne postoje ali evo otprilike:

`32bitna IP adresa - maska (broj jedinica) = broj nula u maski` 

`broj nula u maski -> izračunamo 2na broj nula = broj dostupnih host adresa`

U ovom primjeru je adresa mreže (prva adresa) upravo `10.1.16.0` 
ali da bismo bili sigurni adresa mreže i broadcast se računaju na sljedeći način:


`IP adresa` AND `maska` = `adresa mreže`

`IP adresa` OR `inverzna maska` (sve 1 -> 0, sve 0 ->1) = `broadcast adresa`


```bash
AND
00 - 0
01 - 0
10 - 0
11 - 1
tj. samo dvije 1 daju 1, ostalo 0.
```
**Olakšica za određivanje adrese mreže:**

Za adresu mreže - sve gdje su 1 u **maski**  te brojeve prepiši iz ip adrese dole, ostalo računaš po pravilima iz AND tabele

```bash
OR
00 - 0
01 - 1
10 - 1
11 - 1
samo 00 je 0, ostalo 1
```
**Olakšica za određivanje broadcast adrese**

Sve dokle su 0 u **inverznoj maski** prepiši, ostalo je 1


# LAN 4

Za LAN 4 prvo određujemo podmrežu jer zahtjeva najviše hostova.

Ponovimo još jednom:

600 hostova + 2 (adresa mreže + broadcast)= 602 adrese -> 2na10 daje 1024 hosta 
-> maska je 32 -10 = 22 -> maska za LAN 4 je **/22**


**Zašto baš 2na10?**

Pa kako imamo 602 adrese koje moramo da smjestimo u podmrežu uzima se uvijek više adresa.

Da smo uzeli 2na9 =512 znači da bismo mogli adresirati samo 512 adresa od 602 što ne možemo uraditi pa se uzima za jedan veće tj. 2na10


**Pošto je ovo prva podmreža, adresa mreže će biti naša adresa mreže iz `10.1.16.0/20` tj.**


`10.1.16.0` adresa mreže LAN 4

**sada tražimo broadcast adresu**

1. napišemo adresu mreže u binarnom obliku 
2. napišemo inverznu masku 
3. OR operacija 
4. vratimo broadcast adresu u decimalni zapis 

Na slici ćete vidjeti da ja pišem skraćeno, ali to ćete i vi kroz malo vježbe raditi:
```bash
10.1.00010000.0 <- adresa mreže 
0 .0.00000011.1 <- inverzna maska /22
----------------------------------------------------------
OR sve do zadnje 0 u maski prepišemo, ostalo zapišemo 1
-----------------------------------------------------------
10.1.00010011.1 -> 10.1.19.255 /22 broadcast adresa
```
*`10.1.` je dio koji se ne mijenja jer su ispod 0 u maski pa ga napišem skraćeno, da ne trošim vrijeme za prebacivanje u binarni oblik*

**opseg validnih adresa: 10.1.16.1 - 10.1.19.254** (jedna više od adrese mreže, jedna manje od broadcast adrese)

# LAN 5
Lan 5 je druga po redu podmreža koju kreiramo. 
Zahtjeva: 300 + 2 = 302 adrese -> 2na9 = 512 adresa
Maska: 32 - 9 = 23 -> **/23**

Adresa mreže LAN 5 je za 1 veća od **broadcast adrese LAN 4 tj. prethodne podmreže**
Kako je broadcast adresa LAN 4 `10.1.19.255`  za jedan veća je `10.1.20.0`

```bash
10.1.00010100.0 <- adresa mreže LAN 5
0 .0.00000001.1 <- inverzna maska /23
----------------------------------------------------------
OR sve do zadnje 0 u maski prepišemo, ostalo zapišemo 1
-----------------------------------------------------------
10.1.00010101.1 -> 10.1.21.255 /23 broadcast adresa
```
**opseg validnih adresa: 10.1.20.1 - 10.1.21.254**

*Isti postupak za sve ostale podmreže*

**Pitanje, koliko je ostalo dostupnih adresa od originalne zadate adrese za podjelu?**

Kako je adresa `10.1.16.0/20` imala 2na12 host adresa

LAN 4 -> 2na10

LAN 5 -> 2na9

LAN1  -> 2na8

LAN3  -> 2na7

LAN2  -> 2na5


1. način
ODUZIMAMO

2na12-2na10-2na9-2na8-2na7-2na5 = 2144 dostupne adrese

2. način 

broadcast adresa mreže `10.1.16.0/20` je
 10.1.31.255 /20

broadcast adresa zadnje podmreže tj. LAN2 je
 10.1.23.159 /27

```bash
ODUZMEMO
10. 1. 31. 255
10. 1. 23. 159
-------------
0 . 0. 8. 96 
-> 0*256na3 + 0*256na2 + 8*256na1 + 96*256na0 = 2144 dostupne adrese
```

*Dodatak:*
Na primjeru LAN 2 podmreže možete skratiti postupak određivanja broadcast adrese

* Kako nam za LAN 2 trebaju 32 adrese, zadnji broj iz adrese mreže LAN 2 možemo sabrati sa 32.
* Ako broj ne prelazi 255, onda možemo napisati zadnji broj broadcast adrese kao (zbir -1) a ostalo prepisati.
* Ako broj prelazi 255, onda radite klasični postupak sa inverznom maskom.


## Binarna konverzija IP adresa

Za pretvaranje IP adrese u binarni oblik,koristim ova dva načina i meni lično su najlakši.

Kako je Boris objasnio, IP adresa ima 4 bloka
`192.168.0.101` i oni su odvojeni tačkom. 

Pri konverziji u binarni oblik, svaki ovaj broj do tačke se mijenja sa 8 binarnih cifara - kombinacije 0 i 1.

Svaka od tih 8 pozicija ima vrijednost 2na7 do 2na 0 -> gledajući s lijeva u desno tj.

vrijednosti su:
*128 64 32 16 8 4 2 1* 

Kako računate broj **192**

*Pravilo je, ako je broj veći ili jednak vrijednosti pozicije upiši 1, ako je manje 0 i pređi na sljedeći i uporedi*

**Primjer za 192**

`x x x x x x x x.` na početku imamo ovo

192 > 128 
`1 x x x x x x x.`   -> 192 -128 = 64 


`1 1 0 0 0 0 0 0.` 
-> ostale x upišemo nule jer smo dobili broj 192 sabiranjem 128 i 64


**Primjer za 168**

`x x x x x x x x.`

168 >=128 jeste, upiši 1 na tu poziciju


`1 x x x x x x x.` -> 168 -128 = 40


40 >= 64, nije upisi 0

`1 0 x x x x x x x.`

40>= 32, jeste upiši 1

`1 0 1 x x x x x.`  -> 40 -32 = 8


8>= 16, nije upiši 0 i idi dalje

`1 0 1 0 x x x x.`


8>= 8 jeste upiši 1 

`1 0 1 0 1 x x x.` 
 -> 8-8 = 0 ostala mjesta 0


`1 0 1 0 1 0 0 0.`


Saberemo 128 + 32 + 8 = 168

**Lakši način, da odmah računate broj, upišete sebi iznad pozicija vrijednosti pozicija i stavljate 1 kod brojeva koji u zbiru daju traženi broj** 
