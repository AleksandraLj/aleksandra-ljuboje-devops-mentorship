*week-3 shell scripting - Bible  lessions*
#### TASK - 3 Bash/Shell scripting
# Shell skripte - UVOD


* Cilj  shell scripting-a jeste automatizacija procesa.

Da bi provjerili koji shell koristimo, mozemo ukucati komandu echo `$SHELL` Ova komanda ce nam vratiti putanju do shell programa koji se trenutno koristi.
```bash
$ echo $SHELL
/bin/bash
```

```bash
$ bash --version #koju verziju bash koristimo
```
## Bash shell konfiguracijski fajlovi

Shell konfiguracijski fajl je tekstualni fajl koji se koristi za konfigurisanje okruženja shell-a. Konfiguracijski fajlovi se koriste za postavljanje okruženja, definisanje shell promjenljivih, kreiranje aliasa, postavljanje putanja (PATH) i drugih varijabli, kao i za dodavanje funkcionalnosti shell-u korištenjem skripti i drugih dodataka.

```bash
$ pwd
/home/centos

$ ls -la .*

-rw-------. 1 centos centos 6744 Feb 28 22:19 .bash_history #istorija komandi koje je korisnik izvršio u bash shell-u

-rw-r--r--. 1 centos centos   18 Nov 24  2021 .bash_logout #fajl se izvrsava kada se korisnik izloguje iz Bash shell-a

-rw-r--r--. 1 centos centos  193 Nov 24  2021 .bash_profile
#fajl se izvrsava samo kada se pokrene Bash shell u interaktivnom modu
#fajl se koristi za postavljanje promenljivih okruzenja, aliasa, funkcija itd.

-rw-r--r--. 1 centos centos  259 Feb 28 19:07 .bashrc
# konfiguracijski fajl koji se pokreće prvi kako bi se postavilo okruženje
#izvršava se svaki put kada se pokrene Bash shell
#za postavljanje promenljivih okruzenja, aliasa, funkcija itd

```

## Dodavanje aliasa

```bash
$ cat .bashrc # u ovom fajlu se nalaze svi alias-i koje smo definisali
$ alias  #dobićemo listu definisanih aliasa 
$ alias <skraceni oblik> =" komanda " #defininišemo novi alias
```

## Kompajler VS Interpreter 

**Kompajliranje** - Programski jezici koji koriste kompajler (C, C++, Java ...) za izradu izvršnog fajla. Kompajler je program koji prevede izvorni kod u izvršni fajl. Nakon toga kod se može pokretati više puta bez ponovnog prevođenja.

**Interpreter** - Shell je zasnovan na interpreteru, svaka linija programa odnosno skripte je usnos u shell. Linija shell skripte se izvrsava jedna po jedna sekvencijalno. Cak i ako druga linija skripte ima gresku, shell interpreter ce izvrsiti prvu liniju.
Za razliku od kompajliranja, interpreter svaki put ponovo prevodi kod u izvršni kod.

**Tokenizacija stringa** - shell razdvaja string na više manjih dijelova koji se zovu **token** npr. ime komande, parametar itd.

*Token* je osnovna sintaksna jedinica koju shell razumije i proces tokenizacije omogućava da shell izvrši komande i zadovolji sintaksna i semantička pravila

*After tokenizing, the shell may perform additional parsing and expansion operations on the tokens to resolve variables, aliases, wildcards, and other features of the shell language.*


## Environment Variables

* varijable koje su definisane u operativnom sistemu i dostupne su svim procesima koji se pokrecu u tom okruzenju
* sadrze informacije koje se koriste za postavljanje okruzenja za procese koji se pokrecu u operativnom sistemu, kao što su putanje do direktorija, sistemski parametri, konfiguracijske postavke i druge informacije koje su potrebne da bi se programi izvršavali ispravno

`$PATH` definiše putanje direktorija u kojima se operativni sistem traži izvrsne (executable) fajlove kad izrsavate komande u shell-u.
* Standardne putanje koje su definisane u PATH-u obično uključuju direktorije poput `/usr/bin`, `/bin` i `/usr/local/bin`.
* Kada korisnik unese neku komandu, npr. `ls`, OS ce pretražiti ove direktorije u PATH-u, i ako se fajl ls pronadje u jednom od tih direktorija, on će biti pokrenut.


```bash
$ which ls # whcih je komanda koja nam pokazuje putanju do izvršnog fajla
```
* Putanje u PATH-u na UNIX sistemima su odvojene dvotackom `:`

 * moguće je mijenjati `PATH` varijablu dodavanjem novih direktorija u PATH preko komandne linije ili preko konfiguracijskih fajlova kao što je `.bashrc`

`$SHELL` -  Ova komanda ce nam vratiti putanju do shell programa koji se trenutno koristi.
```bash
$ echo $SHELL
/bin/bash
```
**Napomena:**
*Važno je napomenuti da varijabla `$SHELL` okruženja ne mora uvijek odražavati trenutnu ljusku korisnika. Na primjer, ako korisnik prebacuje na drugu ljusku nakon prijave, varijabla `$SHELL` okruženja može i dalje pokazivati na izvornu zadana ljusku. U tom se slučaju korisnik može koristiti naredbu `echo $0` kako bi utvrdio svoju trenutnu ljusku.*



# Kreiranje shell skirpte

Za kreiranje shell skripte koristimo `vi editor` 

```bash
$ touch <naziv-skripte>.sh #kreiramo fajl i dodamo ekstenziju .sh kako bi naglasili da se radi o skripti

$ vi <naziv-skripte>.sh #ulazimo u editor 
- kliknemo i #da udjemo u INSERT MODE

#!/bin/bash 
 ...
 tijelo skripte
 ...
ESC #za izlaz iz INSERT MODE
:wq #w -write,save q-izađi 
```

`#!/bin/bash` - tzv. **shebang** govori shell-u da koristi Bash shell za izvrsavanje skripte. *Shebang* je obavezna linija u svakoj shell skripti.   Shell koristi ovu liniju da odredi koji shell program treba koristiti za izvrsavanje skripte.    
**Trebalo bi da to uvijek bude prva linija u skripti.**

## Primjer 1 - Kreiranje Hello world & date skripte
Skripta za prikaz poruke "Hello world!" i trenutnog datuma.

`$ touch hello.sh` - kreiramo fajl `hello.sh`
```bash
$ vi hello.sh 
i
#!/bin/bash 
# Ovo je komtar unutar skripte
echo "Hello world!"
echo "Danas je: "
date

ESC #izlaz iz INSERT MODE-a
:wq # write, save and quit
```


# Pokretanje skripte

```bash
$ sh hello.sh 
$ bash hello.sh 
# Na ovaj nacin izvrsavamo skriptu koristeci Bash shell program tako sto smo proslijedili naziv skripte kao argument komandi bash.

$ ./hello.sh 
# dobicemo **Permision denied** ako fajl nije moguce izvršiti

$ chmod +x hello.sh #dodavanje permisije x execution, izvršenje 
$ ls -l hello.sh #da provjerimo permisije nad fajlom
-rwxr-xr-x 1 aleksandralj aleksandralj 67 Mar  4 15:15 hello.sh

$ ./hello.sh 
Hello world!
Danas je:
Sat Mar  4 04:22:55 PM CET 2023

```
`$ ./hello.sh` -na ovaj nacin izvrsavamo skriptu koristeci Bash shell program tako sto smo proslijedili naziv skripte kao argument komandi ./. Ova komanda ce pokrenuti skriptu ako je fajl izvrsiv. 



# SKRIPTE I DODATNE KOMANDE

###Skripta date; who
* komanda ispisuje trenutni datum i ko je ulogovan 

`$ date ; who` - **izvršavanje dvije komande jedna za drugom pomoću `;`**
```bash 
$ vi prva-skripta
i #insert mode

#!/bin/bash
# Ova skripta izvršava shell komande date i who 
date
who

ESC
:wq
```
Dodamo permisije i izvršimo skriptu
```bash
$ ls -la prva-skripta #vidimo da nemamo x permisiju
$ chmod u+x prva-skripta
$ ./prva-skripta
$ mv prva-skripta prva-skripta.sh # preporuka je da se doda ekstenzija .sh

```

### Problem 1: Šta ako želimo raditi troubleshooting bash skripte? 
Ne znamo dokle je izvršenje skripte stiglo?!

**Objašnjenje**
U `bash` nije moguće postavljati *Break points* kao u nekim programima, ali možemo sami postavljati neke kontrolne tačke u vidu ispisa na ekran nekog teksta ili komentara.

```bash 
$ vi prva-skripta.sh
i #insert mode

#!/bin/bash
# Ova skripta izvršava shell komande date i who 
echo "Danas je: " 
date
echo "Izvršila se komanda date"
echo "Logovani korisnik je: "
who

ESC
:wq
```

### UPOTREBA VARIJABLI 

```bash 
$ printenv # ispisuje sve trenutno postavljene enviroment varijable
```

`$ export <ime varijable> = nova vrijednost` - postavljanje varijable

**Napomena**  *Ova vrijednost varijable biće aktivna samo za vrijeme trajanja sesije. Ukoliko želimo trajno promjeniti vrijednost, trebamo otići u `.bashrc` fajl i pomoću `vi editora` dodati izmjene.*



# REGEX 

**Regex** (*eng. regular expression*) je način na koji opisujemo šablon ili *pattern*. 
* koristi se za pronalaženje ili validaciju specifičnih stringova ili patterna teksta u sekvencama, dokumentima ili drugim character input-ima. 

Video sa objašnjenjem pogledati na [Regular Expressions (Regex): All the Basics](https://www.youtube.com/watch?v=77I4ZkhuHsQ&list=PL-p5XmQHB_JREOtBfLdKSswBGYyXwXMUy&index=22)

**Online regex editor [regexr.com](https://regexr.com/)**
### Osnovni karakteri
 
 `.` - mijenja bilo koji karakter
 `*` - karakter koji se ponavlja 0 ili n puta npr. 
 ```bash 
 $ grep "am*" #slovo m se pojavljuje nijednom ili više puta
Traži se riječ koja počinje sa 'a' iza kojeg slijedi nijedno ili više slova 'm'
Stringovi:
a
am
ammmmmmmmm itd.
 ```
 `+` - karakter koji se ponavlja 1 ili n puta npr. 
 ```bash 
 $ grep "am+" #slovo m se pojavljuje jednom ili više puta

Traži se riječ koja počinje sa 'a' iza kojeg slijedi jedno ili više slova 'm'
Stringovi:
am
ammmmmmmmm itd.
 ```
`$` - end of the line/ završava sa
`^` - begining of the line/ počinje sa
`\S`- bilo koji *non-whitespace* karakter
`\s`- bilo koji *whitespace* karakter
`?` - optional tj. karakter ispred `?` se može ali i ne mora pojaviti u sekvenci
`[a-z]` - bilo koje malo slovo
`[A-Z]` - bilo koje veliko slovo
`[A-Za-z]` -bilo koje slovo
 `\` - escape karakter **sve magične simbole pretvara u obične, sve obične pretvara u magične**



# Bible chapters - bilješke 



## Chapter 11
**Varijabli pridružimo output komande**
`$()` - varijabli pridružimo output neke komande
```bash
datum=$(date +%y%m%d) #varijabli datum dodijelimo komandu date i formatiramo je 
echo datum
```

`$wc file` - broji redove u fajlu

`$[ operation ])` - kod dodjela rezultata operacije nekoj varijabli ali i uopšteno za lakše i preglednije skripte

**bc kalkulator**
* floating point calc, računanje sa decimalama

`$ sudo apt install bc` instalacija paketa bc
```bash
$ bc 
12 * 5.4
64.8 
quit #da izadjemo otkucamo riječ quit

```
**Checking the exit status**
`$?` - specijalna varijabla koja čuva exit status value posljednje izvršene komande

**exit komanda**
Po defaultu exit code jednak je exit statusu posljednje izvršene komande.
Možemo specificirati `exit` kod postavljajući `exit` u skripti na neku vrijednost.
npr. `exit 5` ispisaće na kraju skripte u terminalu vrijednost 5



## Chapter 12 

***if-then***
Primjer skipte sa if statement
```bash
!#/bin/bash

if <uslov>
then
    <šta treba da se uradi>
fi #označava kraj if-a

```
***if-then-else***

```bash
!#/bin/bash

if uslov/command
then 
    comands
else 
    commands
fi
```

***if-elif***
```bash
!#/bin/bash

if command
then 
    commands
elif command
    then commands 
    else commands #ovaj else je od elif
else 
    commands #ovaj else je od if
fi
```
**Numeričko poređenje**
```bash
-eq # da li je n1 jednako n2
-ne # da li n1 nije jednako n2
-gt # da li je n1 veće od n2
-lt # da li je n1 veće od n2
-ge # da li je n1 veće ili jednako n2
-le # da li je n1 manje ili jednako n2
```
**Poređenje stringova**
```bash
str1 = str2  # da li je str1 isti kao str2
str1 != str2  # da li  str1 nije isti kao str2
str1 > str2  # da li je str1 duži od  str2
str1 < str2  # da li je str1 kraći od  str2
-n str1 # da li str1 ima dužinu veću od 0
-z str1 # da li je dužina str1 0 tj. prazan string

```
**Napomena** 
*■The greater-than and less-than symbols must be escaped, or the shell uses them as redirection symbols, with the string values as fi lenames.
 ■ The greater-than and less-than order is not the same as that used with the sort command.*

 **Poređenje fajlova**
 ```bash
-d #file Checks if file exists and is a directory
-e #file Checks if file exists
-f #file Checks if file exists and is a fi le
-r #file Checks if file exists and is readable
-s #file Checks if file exists and is not empty
-w #file Checks if file exists and is writable
-x #file Checks if file exists and is executable
-O #file Checks if file exists and is owned by the current user
-G #file Checks if file exists and the default group is the same as the current user
$ file1 -nt file2 #Checks if file1 is newer than file2
$ file1 -ot file2 #Checks if file1 is older than file2
 ```
 **Logičko poređenje**
 ```bash
 && #logical AND
 || #logical OR
 ```
 **Pretraga po pattern-u**
 `if [[$user == r*]]` - duple `[[..]]` zagrade koristimo kada poredimo nešto preko pattern-a
 `if [$user = "rich" ]` - poredimo string

 **switch - case**
 ```bash
 #pretraga po pattern-u
case variable in
pattern1 | pattern2) commands1;;
pattern3) commands2;;
*) default commands;;
esac
 ```


 ## Chapter 13

 **for petlja**
 ```bash
 for var in list
 do
    commands
done
 ```
 ili skraćeni zapis
 `for var in list; do` - odvajamo `;` komande ukoliko ih koristimo u istom redu

 **skripta ch13-test5.sh citanje iz fajla pomocu niza**
 ```bash
echo "***Ovo je primjer ispisa kada se koristi niz***"

niz_drzava=()   # inicijalizujemo prazni niz

while read -r line
do
  niz_drzava+=("$line")   # dodaj liniju u niz
done < states.txt   # citaj iz fajla states.txt

# ispis niza
for element in "${niz_drzava[@]}"
do
  echo "$element"
done
 ```
 `while read -r line` -read input line by line and execute command for each line
 `read` - read input from input
 `-r` - tretira backslash `\` kao stvarni karakter, ne kao escape karakter
 `line` - varijabla koja čuva svaku liniju input-a
`${niz_drzava[@]}` je specijalna bash sintaksa koja kaže "proširi se na sve elem. niza"
`[@]` - array expansion koja kaže "razbij" niz na individualne elemente
`${...}` -parameter expansion - tells Bash to treat the resulting list of elements as separate arguments

**Internal Field Separator IFS**
* bash po default-u sljedeće karaktere smatra fields separators:
1. space/razmak
2. tab 
3. newline/nova linija

te kada naiđe na ove karaktere smatraće se da počinje novi data field
IFS varijablu možemo postaviti u skripti na sljedeći način 
`IFS=$'\n'` - prepoznaje samo novi-red karaktere, ignoriše space i tab

*korisno kod fajla `states` ako imamo slučaj sa državom 'Bosna i Hercegovina', u ovom slučaju će se ispisati kao Bosna i Hercegovina u jednom redu*

**NAPOMENA**
*Kada radimo sa dugim skriptama, praksa je da sačuva originalna vrijednost IFS koju kasnije možemo vratiti, u slučaju da nam nova vrijednost više ne treba ili je privremeno korištena*

```bash
#cuvanje originalne vrijednosti IFS

IFS.OLD=$IFS
IFS=$'\n'
<use the new IFS value in code>
IFS=$IFS.OLD
```

`IFS=$'\n':;"` - navođenje više IFS karaktera

**while petlja**

```bash
while test command 
do
  other commands
done
```
**Smanjenje vrijednosti varijable za 1 | decrement**
```bash
#!/bin/bash

#while petlja 
#koristi  izraz -gt "greater than" za poredjenje; $($var-1) dekrement vrijednosti u varijabli var

var1=10

while [ $var1 -gt 0 ]
do 
    echo $var1
    ((var1--)) #decrement iz opisa nije radio, te je ovo zamjena
done
```
ili još jedan način 
`var1=$((var1 - 1))` -decrement za bilo koju vrijednost

**aritmetičke operacije - ispravan zapis**
` var3=$((var1 * var2))` - nije potrebno stavljati dodatne `$` ispred var1 i var2

**until loop**

```bash
until condition
do
  # statements to be executed repeatedly
done
```
* petlja će izvršavati komande unutar `do` sve dok je uslov u `conditions` false, onoga momenta kada uslov bude ispunjen izlazi se iz petlje 
* dakle, suprotno `while petlji`

## Chapter14

**simbolicki link - kreiranje**
`$ ln -s skripta.sh simbolicki` kreira simbolicki link za skriptu.sh i to je fajl simbolicki
`$ ls -l *nesto` za provjeru kreiranih fajlova `*nesto` gdje je `nesto`  zadnja slova u nazivu fajla radi lakse pretrage

**Pristupanje ulaznim podacima**
`$#` prikazuje koliko smo ulaznih podataka proslijedili
`${!#}` - vraća zadnji proslijeđeni podatak
`$*` - kupi sve ulazne parametre i čuva ih kao jednu riječ
`$@` - kupi sve ulazne parametre i čuva ih kao odvojene stringove, te omogućava lakšu iteraciju kroz iste 

**Skripta ch14-test18.sh objasnjenje**
``
The Bash command `set -- $(getopt -q ab:cd "$@")` is used to process command-line arguments passed to a Bash script using getopt.

**getopt** is a utility that is used to parse command-line options and arguments.
 The `$(...)` syntax in Bash is called **command substitution**, which means that the output of the command inside the parentheses is substituted as an argument to the set command. 
 The `-q` option tells `getopt` to suppress error messages, and the string `ab:cd` specifies the options that the script is expecting. The colon after the **b** indicates that the b option requires an argument.

The `set` command is used to set positional parameters in Bash. 
`--` is used to indicate the end of options and the start of positional parameters. 
By using `set --`, we are setting the positional parameters of the script to the parsed options and arguments returned by getopt.

This command essentially sets up the command-line arguments for the script, making them accessible through the `$1`, `$2`, `$3`, etc. variables

## Chapter15

**Kreiranje temporary fajlova**

`$ mktemp naziv-fajla.XXXXXX` kreira fajl u lokalnom direktorijumu
`.XXXXXX` šest znakova **X** su dodatna oznaka fajla i dodjeljuju se automatski pri kreiranju, kako bi imali jednistven naziv temp fajla

`$ mktemp -t naziv-fajla.XXXXXX` opcija `-t` forsira kreiranje temp fajla u direktorijumu temp - sistemskom dir za temporary fajlove

**Kreiranje temporary direktorijuma**

`$ mktemp -d naziv-direktorijuma.XXXXXX` kreira direktorij 

**tee komanda**
`$ tee filename` komanda koja šalje rezultat tj. output na 2 lokacije -STDOUT i u fajl koji proslijedimo komandi

`$ tee -a naziv-fajla` `-a` predstavlja *append* i koristi se za nadovezivanje sadrzaja u fajlu 

## Chapter 16

**nice komanda**

U bash-u, `nice` komanda se koristi za pokretanje programa sa nižim prioritetom izvršavanja (tzv. "nice value"), što znači da će program imati manji uticaj na ukupnu performansu sistema.

Nice vrijednost se obično postavlja na vrijednosti od -20 do 19, pri čemu je niža vrijednost prioritetnija. 
Standardna vrijednost za procese koji se pokreću bez postavljanja nice vrijednosti je 0.

Na primjer, ako imate program koji koristi puno računarskih resursa i koji bi mogao usporiti vaš sistem dok se izvršava, možete ga pokrenuti sa 
`$ nice -n 10 program` kako bi se njegov prioritet smanjio i kako bi ostali procesi imali prioritet pri izvršavanju. 
Također, ako želite da program nastavi sa radom u pozadini nakon što zatvorite terminal, možete ga pokrenuti sa
 `$ nice -n 10 program &`

 ```bash
$ renice -n 10 -p 5055 #promjena prioriteta PID 5055
5055: old priority 0, new priority 10
 ```

 **Scheduling a job using the at command**

 `at [-f filename] time` sintaksa

 `$ at -f test13.sh now` gdje `-f` govori koji fajl se koristi, dok `now` znači izvršenje odmah
 `$ at -M -f test13.sh now` gdje `-M` koristimo da ignorišemo email ili output generisan od strane `at`

 `$ atq` da vidimo job pending listu
 `$ atrm broj` da uklonimo job sa brojem `broj` iz liste

 **cron table**

 `min hour dayofmonth month dayofweek command` format cron tabele

 `$ crontab -l` lista cron
## Dodatne skripte 

### Skripta za dodavanje esktenzije fajlovima u željenom direktorijumu 

* skripta se pozicionira u direktorij čiju putanju navedete u `dir` varijablu.
 Kako je moja skripta `change_ext.sh` u istom direktorijumu sa ostalim, kao putanju koristim `.`

Pomoću pattern pretrage (Chapter 12, Bible) koristeći regex ili parammeter expansion poredimo stringove.
`${file##*.}` - parameter expansion koji vraća ekstenziju fajla iz varijable `file`
Npr. 
`fajl.bz.tar` pomoću `${file##*.}` dobijamo samo `tar` 

`${...}` - označava parameter expansion
`file` - ime varijable tj. fajla nad kojim radimo ekspanziju 
`##` - bash parameter expansion operator koji uklanja **the longest matching pattern from the beginning of the string** u ovom slučaju sve od početka stringa do tačke
`*` - wildcard koji predstavlja bilo koji simbol
`.` - tačka koja predstavlja tačku u nazivu koja odvaja ime fajla od ekstenzije

[Više o parameter expansion pročitajte ovdje](https://www.gnu.org/software/bash/manual/html_node/Shell-Parameter-Expansion.html)

**EDIT** *Zadatak se mogao uraditi i sa regex izrazom - [regex izraz](https://regexr.com/79mfg)* 

NAPOMENA: kada budete kreirali ovu skriptu, obavezno joj odmah  dajte ekstenziju `.sh` i privilegiju izvršenja `chmod +x ime-skripte.sh`
```
#!/bin/bash

# Postavite putanju do dir
dir="."

# Pozicioniraj se unutar tog dir
cd "$dir"

# For petlja za prolazak kroz sve fajlove u dir
for file in *
do
  # Provjera da li fajl ima .sh ekstenziju
  # ${file##*.} je regex pattern koji omogucava da izdvojimo ekstenziju fajla
  if [[ "${file##*.}" != "sh" ]]
  then
    # Preimenujemo fajl u fajl sa .sh ekstenzijom
    mv "$file" "${file}.sh"
    echo "Fajl $file je preimenovan u  ${file}.sh"
  fi
done
```

