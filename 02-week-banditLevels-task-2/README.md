*week-2 bandit level*
#### TASK - 2 Over The Wire - Bandit Levels
# SADRŽAJ 

[📖 1 Bilješke i komande sa predavanja week-2](#1-Komande-sa-predavanja)  
[📖 2 Komande korištene pri izradi TASK - 2](#2-Komande-za-task-2)



<a name= "1-Komande-sa-predavanja">

# 1 Bilješke i komande sa predavanja week-2

```bash
$ hostnamectl #Displays your hostname
```

`$ man ssh ` -  manual za alat SSH 
`$ man` - komanda za prikaz manuala za komande 

**SSH**  is a UNIX-based command suite and protocol for securely accessing a remote computer. SSH secures network client/server communications by authenticating both endpoints with a digital certificate and by encrypting passwords. SSH uses RSA public key cryptography to manage connections and authentication.
 
`$ ssh -i "devops-mentorship-program-week-2.pem" centos@3.3.3.3` </br>
 **defaultni port** za SSH je `port 22` </br>
 
 `ključ za spajanje na korisnički server, korisničko-ime @ip adresa`

  `-i` identity_file
     Selects a file from which the identity (private key) for RSA or
     DSA authentication is read.  The default is ~/.ssh/identity for
     protocol version 1, and ~/.ssh/id_rsa and ~/.ssh/id_dsa for pro-
     tocol version 2.  Identity files may also be specified on a per-
     host basis in the configuration file.  It is possible to have
     multiple -i options (and multiple identities specified in config-
     uration files). </br>
 **parametru `-i` proslijedimo svoj privatni ključ a na serveru se nalazi javni ključ**

 ### Gdje se nalazi javni ključ?

 `$ exit` -vratimo se na korisnika `@centos` </br>
 `$ ls -la` - lista fajlova zajedno sa skrivenim </br>
 `$ cd .ssh/` - pozicioniramo se u folder `.ssh` </br>
 `$ cat authorized_keys` - prikaz javnog ključa našeg privatnog ključa </br>
 `pem` file je privatni dok je ovaj gornji njegov javni par </br>

### Omogućiti spajanje korisnika na server bez korištenja posebnog privatnog ključa

 Kada ne želimo dijeliti sa developerima svoj privatni ključ, potrebno je zahtjevati od njih da proslijede svoj javni ključ i isti dodati u fajl `authorized_keys` na našem serveru </br>

 **Koraci:**
1. `$ cd .ssh` - pozicioniramo se na lokalni .ssh folder
2. `$ cat config` - provjerimo koji ključ koristimo > `IdentityFile ~/.ssh/server-key`
    `server-key` - naš privatni ključ
    `server-key.pub` - javni par našeg privatnog ključa `server-key` 
3. `$ cat server-key.pub` - ispis sadržaja
4. Iskopiramo sadržaj 
5. `$ cd ~/Downloads` - vraćamo se u `Downloads`
6. `$ ssh -i "devops-mentorship-program-week-2.pem" centos@3.3.3.3`
7. `$ cd .ssh/`
8. `$ vi authorized_keys` - vi editor omogućava manipulaciju sa fajlovima 
9. kliknemo `i` - udjemo u `INSERT MODE` 
10. pozicioniramo se na kraj ključa, enter
11. paste javni ključ 
12. `ESC` - escape za izlaz iz INSERT MODE 
13. `:wq` - zapiši, sačuvaj i izađi 
14. `$ cat authorized_keys` - da provjerimo promjene 
15. `exit` - izađemo sa servera 
16. `$ ssh centos@3.3.3.3` - sada koristimo ovu komandu za logovanje na server 



`$ ssh bandit0@bantid.labs.overthewire.org -p 2220` </br>
 `-p` označava port </br>
 Iz sigurnosnih razloga poželjno je za logovanje koristiti **non default** SSH port 


### Provjera koji je korisnik logovan na server

`$ whoami` - vraća korisničko ime sa kojim smo prijavljeni na korisnički server </br>

`$ sudo su root` - prebacimo se na `root` korisnika </br>
`$ cd root` - administratorski korisnik sa svim privilegijama na serveru/mašini </br>
`$ cd` - prebaci nas na root direktorij ~ korisnika root </br>
`$ pwd` - komanda vrata putanju direktorija u kojem se trenutno nalazimo </br>


### Problem 1: Developer nije u mogućnosti da se poveže na server. Koji su koraci?

1. Potrebno je da zatražimo **output verbose** komande za SSH </br>

`$ ssh -vvv centos@3.3.3.3` komanda za verbose </br>

Neke od stavki koje možemo provjeriti su:</br>
- da li se čita dobra konfiguracija na računaru developera
- resolvnig
- hostname 
- razmjena ključeva itd.

`$ sudo su ~` - `root` korisnik 

### Instalacija paketa na Unix CentOS radimo koristeći komandu **yum** 

`$ yum install nano` - instalacija `nano` paketa </br>
`$ yum install nano -y` - instalacija nano paketa sa automatskim odgovorom YES za dalju instalaciju </br>
- Koristi se u skriptama, kako se izvršenje iste ne bi prekinulo zbog potrebe da odgovorimo na pitanje npr. "Da li želiš nastaviti?"  -y -n </br>

**RPM paketi** sa ekstenzijom `.rpm` su pohranjeni u **Artifactory**-u </br>
**Artifactory** - repozitorij za RPM pakete </br>
npr. [JFrog Artifactory](https://jfrog.com/) </br>

### OBJANŠNJENJE: Promjena prioriteta repozitorija za klijenta (server na kojem se izvrsava yum install)

![priority-yum](.//bandit-level-screenshots/priority-yum.png)

Otvorite fajl `/etc/yum.repos.d/imeYumRepozitorija.repo` </br>
2. Unutar tog fajla mozete imati sljedecu konfiguraciju:

```bash
[repo1]
name=Repo 1
baseurl=http://example.com/repo1/
enabled=1
gpgcheck=0
priority=1

[repo2]
name=Repo 2
baseurl=http://example.com/repo2/
enabled=1
gpgcheck=0
priority=5

[repo3]
name=Repo 3
baseurl=http://example.com/repo3/
enabled=1
gpgcheck=0
priority=10
```

Tu mozete primjetiti `property` pod nazivom `priority`</br>
U zavisnosti od vrijednosti koja je tu navedena kada uradite `yum install ime-paketa` provjeravati ce se repozitoriji po prioritetnosti.Prioritet se pocinje od **1** (najvisi prioritet) do **99** (najniži prioritet)</br>
Ako prioritet nije naveden za određeni repozitorijum, podrazumijevana vrijednost će biti **99**, što znači da će repozitorijum biti dodjeljen najnizi prioritet. </br> Takodje, ako postoji vise repozitorija sa istim prioritetom, Yum će koristiti podrazumijevanu postavku da repozitorije poreda po abecednom redu. </br>


**[PRIVATNI] Artifactory Server 1** - Artifkatori server koji se nalazi u nasem data centru (zato ga zovemo privatnim) na njemu imamo sve pakete dostupne koji nam trebaju</br>

**[JAVNI] Artifactory Server 2** - Koristimo ga ako je PRIVATNI nedostupan ili ne mozemo naci paket koji trazimo na PRIVATNOM </br>

na koji nacin na nasem CentOS serveru, koji je ovdje klijent, konfigurisati da kada uradimo:</br>
`$ yum install git` </br>

taj `git.rpm`  paket bude preuzet i instaliran sa **[PRIVATNI] Artifactory Server 1** </br>
pa tek ukoliko `git.rpm`  ne mozemo pronaci na tom Artifactory Serveru gledamo na alternativni odnosno na ovaj **[JAVNI] Artifactory Server 2** </br>

to rjesavamo sa ovom konfiguracijom na klijentskoj strani, na strani masine/hosta/servera gdje izvrsavamo yum komandu, koja provjerava `.repo` konfiguracijske fajlove koji se nalaze unutar
`/etc/yum.repos.d/`

gdje mozemo da postavimo ovaj `priority`  parametera koji ce reci yum komandi ako je prioritet 1: </br>
“Hej prvo pretrazi paket koji trazis na mom aritifaktoriju”

`$ cd /etc/yum.repos.d/` - unutar lokacije imamo konfigurisane repozitorije  </br>

- Ukoliko kompanija ima svoj Artifactory, potrebno je kreirati novi repo file i unutar njega postaviti određene konfiguracije sa putanjama do određenih paketa koje imamo dozvolu instalirati - `CentOS-Debuginfo.repo` </br>

```bash
$ cd log | ls-la #prikazuje se sadržaj log file-a
$ cat secure #ispis svih log fajlova 
$ tail -50 secure #Prikazuje zadnjih 50 linija fajla secure 
$ head -10 file1 #Prikazuje prvih 10 linija file1
```
### Komanda `find`

```bash
 $ find . #pronalazi sve fajlove i direktorije u trenutnom direktorijumu 
 $ find ime_dir # pronalazi sve unutar ime_dir
 $ find . -type d # pronalazi sve direktorijume, bez fajlova
 $ find . -type f # pronalazi sve fajlove 
 $ find . -type f -name "test.txt" #pronalazi fajl pod nazivom test.txt
 $ find . -type f -iname "*.py" # pronalazi sve fajlove koji imaju ekstenziju .py i incase sensitive
 $ find . -type f -mmin - 10 # pronalazi sve fajlove modifikovane u posljednjih 10 min
  # - less than 10 min ago
  # + more than 10 min ago 

$ find . -type f -mmin +1 -mmin -5 #pronalazi modifikovane fajlove između 1 i 5 minuta (više od 1 min, manje od 5 min)
$ find . -type f -mtime - 20 #pronalazi fajlove modifikovanje kraće  od 20 dana 

Modify minutes and modify days 
-mmin  
-mtime

Access minutes and access days 
-amin 
-atime

Changed minutes and changed days 
-cmin
-ctime

$ find . -size +5M # pronalazi fajlove veličine preko 5MB
k -kB
M - MB
G - GB

Dodatni parametri 
- perm <naziv permise> # pronalaženje fajla sa zadatom permisom 
```

### Komanda `grep`

```bash
$ grep "string koji tražimo"  naziv-fajla-u-kojem-tražimo 
-w # whole word 
-wi #case insensitive whole word 
-win # broj linije gdje je riječ pronađena 
    -B4 #prikazuje 4 reda prije pronađene riječi 
    -A4 #prikazuje 4 reda nakon pronađene riječi 
    -C4 #prikazuje 4 reda prije i nakon pronađene riječi 


grep -wirL "traženi-string" #vraća filename koji sadrži traženu riječ
grep -wirC "traženi-string" # -C broji koliko pogodaka imamo sa traženim pojmom u svakom fajlu 
```

### `grep` vs `find`

- `grep` pronalazi **linije** iz text fajla koji odgovaraju traženom pojmu tj. *pattern-u*
- `find` pronalazi **fajlove i direktorijume** čija **imena** odgovaraju traženom pojmu tj. *pattern-u*


### Pitanje: Gdje se nalazi log file servisa x i kako ga pretažiti?

1. `cd /etc/` - odemo u etc direktorij 
2. pogledamo `conf file` servisa x, jer `conf` file sadrži putanju do log fajla
3. pretpostavljamo da `log` nalazi unutar `var` direktorija 
    `$ cat yum.conf | grep "log"  ` 
npr. `logfile=/var/log/yum.log`
4. `$ grep "traženi-pojam" /var/log/yum.log` 

`|` - `pipe` za preusmjeravanje rezultata operacije lijevo u desno navedenu komandu/fajl  </br>
`>` - preusmjerav rezultat operacije lijevo od znaka u desno navedeni fajl. **Ako fajl ne postoji, kreira se novi. Ako postoji, sadržaj se prelijepi** </br>
`>>` - kao gornja funkcija samo se sadržaj ne prelijepi već **nadovezuje/Update** </br>

### Dodatne komande 
```bash
$ cp file1 file2 #Copy file1 to file2

$ cp -r dir1 dir2 #Copy directory dir1 to dir2

$ mv file1 file2 #Move file1 to file2, file1 is deleted

$ rm file1 #Remove file1

$ rm -r dir1 #Remove directory dir1 and all its contents

$ less file1 #Display the contents of file1, one screen at a time

$ diff file1 file2 #Display the differences between file1 and file2

$ sed 's/old/new/g' file1 > file2 #Replace all occurrences of “old” with “new” in file1 and save the result in file2

$ grep 'pattern' file1 #Display all lines in file1 containing the pattern

$ awk '{print $1}' file1 #Display the first column of file1

$ awk -F : '{print $1}' /etc/passwd #Display the first column of /etc/passwd

$ scp username@remote:/file/to/send /where/to/put #Copy file from remote host to local host

$ scp username@remote_1:/file/to/send username@remote_2:/where/to/put #Copy file from remote host to remote host

$ rsync -e "ssh -P $port_value" remoteuser@remoteip:/path/  localpath #Copy file from remote host to local host
```

### Permise 

`$ cat .bashrc` </br>
`.bashrc` fajl sadrži sve konfiguracije vezane za naš `bash shell` </br>

`alias` - predefinisani sinonimi/konstante za druge komande </br>

`.bash-history`  #sve komande koje su korištene </br>

### TMUX 

 - omogućava da paralelno imamo otvoreno više sesija </br>
 - nastavljamo gdje smo stali, i ako dođe do prekida npr. zatvori se terminal  </br>

`$ yum install tmux`   #instalacija tmux </br>
```bash
CTRL + B + C  #otvara se nova sesija
CTRL + B + 0  #prebacimo se na prvu sesiju 
CTRL + B + X  #zatvaranje sesije 

tmux ls #prikaz pokrenutih sesija
tmux attach-session -t broj-sesije  #vratimo se na sesiju 


-   rwx              rwx         rwx 
    user     -      group    -  others
400 200 100        40 20 10     4 2 1

-r #read
-w #write
-x #execute 

chmod +x skripta.sh  #dodali smo executable privilegije nad skriptom skripta.sh

Kalkulator za komande  chmod-calculator.com

chown centos:centos skripta.sh #fajl skripta.sh je u vlasništvu korisnika centos i grupe centos 

lsblk #ispis diska, particije na disku i veličina particije 
df -h #zauzeće po particijama 
```

```bash
$ ps aux #vraća listu pokrenutih procesa 
```
* `ps` skraćeno od "process status" i vraća listu pokrenutih procesa na sistemu
* `a` - opcija kaže `ps` da prikaže informacije o svim procesima na sistemu, ne samo onih na terminalu
* `u` This option tells ps to display detailed information about each process, including the username of the process owner, the process ID (PID), the CPU and memory usage, and the start time of the process.

<a name="2-Komande-za-task-2">

# 2 Komande korištene pri izradi TASK - 2

## Level 0
```bash
$ ssh bandit0@bandit.labs.overthewire.org -p 2220 #povezivanje na server sa non default portom 
```

Podaci: 
```bash
Host: bandit.labs.overthewire.org
username: bandit0
password: bantit0
port: 2220
```
![level-0](.//bandit-level-screenshots/bandit0-0.png)


## Level 0 -> Level 1

- Kako se već nalazimo na root-u `~` koristimo samo komandu `ls` da prikažemo listu fajlova i vidimo da se tu nalazi traženi `readme` file
```bash
$ cat readme #pročitamo sadržaj fajla
```
`exit` koristimo da izađemo iz tekuće sesije </br>

![level-0](.//bandit-level-screenshots/bandit0-1.png)

## Level 1 -> Level 2

`-` je specijalni karakter, te se **ne preporučuje započinjanje imena ovim karakterom** </br>
```bash 
$ cat ./- #dodajemo putanju / tj. escape znak
```
![level-1](.//bandit-level-screenshots/lvl1-2pw.png)

## Level 2 -> Level 3

Komandom `ls` provjerimo da li traženi fajl postoji u listi 
```bash 
$ cat "spaces in this filename" #koristimo navodnike kako bismo  izbjegli white spaces 
```
ili 
```bash
$ cat spaces\ in\ this\ filename #možemo koristiti backslash \ da izbjegnemo white spaces
```

![level-2](.//bandit-level-screenshots/lvl2-3pw.png)

## Level 3 -> Level 4

- Šifra se nalazi u skrivenom fajlu u direktoriju **inhere**
```bash 
$ ls -la #ispis zajedno sa skrivenim fajlovima 
$ cd inhere #pređemo u direktorij inhere 
$ ls -la 
$ cat .hidden #prikažemo sadržaj hidden fajla
```
![level-3](.//bandit-level-screenshots/lvl3-4pw.png)

## Level 4 -> Level 5

- Šifra se nalazi u jedinom **Human readable** fajlu u direktorijumu **inhere** </br>
- Komanda `file` vraća nam tip podataka koji se nalaze u fajlu </br>
- **Human readable** fajlovi sadrže podatke predstavljene na način da ih čovjek može pročitati, npr. **ASCII** i **Unicode** </br>

```bash 
$ ls
$ cd inhere 
$ ls 
$ file ./* #za prikaz tipa podataka svakog fajla u direkriju inhere ; . - oznaka za fajl, /* - sve ekstenzije fajlova
$ cat ./-file07 #iz liste smo vidjeli da jedino file07 ima tip podataka ASCII text te se pozicioniramo na njega
```
Ukoliko pokušamo iskoristiti komandu `strings` dobićemo sljedeći output
```bash
bandit4@bandit:~$ strings inhere
strings: Warning: 'inhere' is a directory
```
`strings` - print the sequences of printable characters in **files**

![level-4](.//bandit-level-screenshots/lvl4-5pw.png)

## Level 5 -> Level 6

- Šifra se nalazi u **fajlu**, negdje u **inhere direktorijumu** i ima sljedeće propertije:
* human-readable
* 1033 bytes in size
* non executable 

```bash
$ ls -la
$ cd inhere
$ find . -type f -readable -size 1033c ! -executable 
```

Parametri: </br>
`-type` za određivanje tipa `f` se odnosi na **file** </br>
`-readable` human-redable file </br>
`-size 1033c` veličina fajla, c se ondosi na **bytes**</br>
`! -executable` file je **not executable** ili direktorij je **not searchable** </br>

```bash
$ cd maybehere07
$ cat .file2 #prikaz sadržaja fajla 
```

ili kraće
```bash
$ find . -type f -readable -size 1033c ! -executable 
$ cat ./inhere/maybehere07/.file2
```
![level-5](.//bandit-level-screenshots/lvl5-6pw.png)

## Level 6 -> Level 7

- Šifra se nalazi **negdje na serveru** i moramo ispoštovati propertije:
* owned by user bandit7
* owned by group bandit6
* 33 bytes in size

*NOTE*
 Nakon što se ulogujemo na `lvl bandit6` nalazimo se u `home/bandit6` tj. u **home direktorijumu**. Za razliku od prethodnih levela gdje je rečeno da se nešto nalazi u home direktoriju, ovdje **ne znamo gdje se file nalazi** te je potrebno pretražiti cijeli sistem. 

Tražimo iz `root /` direktorijuma, što možemo uraditi na više načina:
* Run `find /` umjesto `find ./`
* Run `cd /` da se prebacimo iz `home` u `root`, a onda `find ./`

**1. Način**
```bash
$ find / -user bandit7 -group bandit6 -size 33c 2>&1 | grep  -F -v Permission | grep -F -v directory
```
Koristimo `find` komandu sa propertijima: </br>
`-user ` za filtriranje koristnika bandit7 </br>
`-group` za filtriranje grupe bandit6 </br>
`-size`  za filtriranje veličine 33 byte </br>
`2>&1 ili 2> /dev/null`   za skrivanje svih mogućih **error** poruka </br>
`2>` redirects stderr to an (unspecified) file </br>
`&1` redirects stderr to stdout. </br>
`dev/null` special file which discards any input

Koristeći `|` **pipe line** rezultat lijeve komande prepuštamo dalje `grep` komandi koja ima propertije:</br>
`-F` tražimo pojam u fajlu </br>
`-v` **--invert-match** tražimo suprotno od Permission tj. directory </br>

**2. Način**
```bash
$ find / -user bandit7 -group bandit6 -size 33c #dobićemo output sa mnogo Permission denied koje je potrebno filtrirati


$ find / -user bandit7 -group bandit6 -size 33c 2> /dev/null #remove "Permission denid" messages
```
**I na kraju odradimo sljedeću komandu**
```bash
$ cat /var/lib/dpkg/info/bandit7.password #ispišemo sadržaj fajla
```
![level-6](.//bandit-level-screenshots/lvl6-7pw.png)

## Level 7 -> Level 8

```bash
$ grep millionth data.txt #pretraga fajla data.txt po pojmu millionth
```

![level-7](.//bandit-level-screenshots/lvl7-8pw.png)

## Level 8 -> Level 9

- Komanda `uniq` filtrira input i ispisuje output </br>
Flag `-u` filtrira jedinstvene **unique** linije, tj. linije koje se pojavljuju samo jednom </br>
 `-c` broji ponavljanja linija u fajlu </br>
 `-d` vraća duplikate </br>

**Komanda `uniq` koristi se u kombinaciji sa komandom `sort`. Zašto?** </br>
 [`uniq`](https://www.geeksforgeeks.org/uniq-command-in-linux-with-examples/)prihvata kao ulaz podatke iz nekog `.txt` fajla i otklanja sve ponovljene linije **samo ako su susjedne**. </br>
  Zbog toga koristimo prvo komandu `sort` da sortiramo fajl. </br>

  ```bash
  $ sort data.txt | uniq -u #za ispis jedinstvene linije unutar fajla data.txt
  ```
![level-8](.//bandit-level-screenshots/lvl8-9pw.png)

## Level 9 -> Level 10

-Komanda `strings` pronalazi **human-redable** stringove unutar fajla </br>

```bash
$ strings data.txt | grep ====  #pronalazi human-readable string kojem prethodi nekoliko znakova =, dakle više od 2 znaka =
```
![level-9](.//bandit-level-screenshots/lvl9-10pw.png)

## Level 10 -> Level 11 

- `base64` je **binary-to-text** encoding šema. Za dekodiranje koristimo parametar `-d`

```bash
$ cat data.txt | base64 -d #pročitaj enkodirani sadržaj fajla data.txt 
```

![level-10](.//bandit-level-screenshots/lvl10-11pw.png)

**Šifra za nastavak lvl 11 -> lvl 12**
`6zPeziLdR2RKNdNYFNb6nVCKzphlXHBM`

## Level 11 -> Level 12



- Šifra se nalazi u `data.txt`, gdje su sva velika slova [A-Z] i mala slova [a-z] **rotirana** za 13 pozicija

*NOTE*  

**ROT13** ili **"rotate by 13 places"** je način kodiranja, kojim se svako slovo (engleskog) alfabeta mijenja slovom 13 mjesta dalje. 
* Nema enkripcijskog ključa i simetričan je: kako engleski alfabet ima 26 slova, * dvije primjene ROT 13 daju ponovo polazni tekst.
* Nema kriptografsku snagu i nije pogodan za šifriranje jer se lako razbija frekvencijskom analizom teksta. 

![ROT-13-diagram](.//bandit-level-screenshots/ROT13.png)

[Ovdje možete probati ROT13 šifriranje](https://rot13.com/)

Komanda `tr` *(eng. translate)* omogućava zamjenu karaktera drugim karakterima
`$ tr <old_chars> <new_chars>` 

**1. Način**

```bash
$ cat data.txt | tr 'A-Za-z' 'N-ZA-Mn-za-m'
```
```bash
'a' se mapira u 'n'
'z' se mapira u 'm'
```

dakle, mapiramo `[a-m] = [n-z]` što pokriva samo slova u opsegu `[a-m]`

preostali opseg za mapiranje `[n-z] = [a-m]` pa bi naša komanda sada izgledala ovako
```bash
$ tr [a-m][n-z] [n-z][a-m] #komanda djelimicno tacna
```

`[a-m][n-z]` možemo skratiti i napisati kao `[a-z]`
```bash
$ tr [a-z] [n-z][a-m] #kraći zapis sa problemom

#[] uključene kao karakteri npr. n->[ 
```
Da riješimo problem, spojimo `[n-z][a-m] = [n-za-m]`

**Isti je postupak i sa velikim slovima**

**2.Način**

Dodamo **ROT13**  kao `alias` da skratimo kucanje
```bash
alias rot13= "tr 'A-Za-z' 'N-ZA-Mn-za-m'"
```

![level-11](.//bandit-level-screenshots/lvl11-12pw.png)

pw `JVNBBFSmZwKKOP0XbFXOoW8chDz5yVRv`

## Level 12 -> Level 13

The `password` for the next level is stored in the file `data.txt`, which is a **hexdump** of a file that has been repeatedly compressed. 
For this level it may be useful to create a directory under /tmp in which you can work using mkdir. For example:` mkdir /tmp/myname123`
Then copy the datafile using cp, and rename it using mv (read the manpages!)

**Hexdumps** koristimo za pregled `data` koji se ne mogu predstaviti pomoću `stringa` te ih je lakše pročitati kao `hex` vrijednosti.
`hexdump` **ima 3 glavne kolone**:
1. prikazuje adresu
2. je *hex* prikaz podataka na toj adresi
3. stvarni podatak kao string, gdje je  `.`  predstavljena hex vrijednost koja se ne može prikazati kao string

**Šta radimo u ovom slučaju?**
1. kreiramo novi direktorij i prekopiramo fajl sa podacima, kako ih ne bismo izmjenili trajno u slučaju greške
2. prebacimo podatke u neki hexdump_data fajl koji sadrži uvijek hexdump prikaz fajlova radi lakšeg čitanja
3. uradimo `revert` proces od hexdump pomoću `xxd -d` komande i smjestimo te podatke u compressed_data
4. `xxd compressed_data` pogledamo hex prikaz `compressed_data` da vidimo prvi red i otkrijemo koja je kompresija u pitanju 
5. rješavamo dekompresiju u zavisnosti da li je `gzip` `bzip2` `tar`
6. ponavljamo korake `4. -5.` dok ne dobijemo podatke


```bash
$ cd /tmp #navigate to /tmp
$ mkdir sasa-cmpressed #creade new directory npr. sasa-cmpressed
$ cd sasa-cmpressed #navigate to sasa-cmpressed
$ cp /home/bandit12/data.txt .  #copy data.txt from home dir to this dir
```
Hexdumped `data.txt` premjestimo u `hexdumped_data`

```bash
$ mv data.txt hexdump_data
bandit12@bandit:/tmp/sasa-cmpressed$ head -10 hexdump_data 
```
### Revert hexdump of the file

```bash
bandit12@bandit:/tmp/sasa-cmpressed$ xxd -r hexdump_data compressed_data
```
![level-12-compressed-data](.//bandit-level-screenshots/lvl12-compressed_data.png)
*NOTE: Stvarni podaci nisu 'readable', hexdump je čitljiviji*

### Decompress the data

Posmatramo prve bajtove u hexdump da pronađemo [file signature](https://en.wikipedia.org/wiki/List_of_file_signatures) i na osnovu liste prepoznamo koji metod dekompresije koristimo

**GZIP**
 
 Koraci:
 1. preimenujemo fajl OBAVEZNO kod GZIP  dodavanjem ekstenzije `.gz`
 `$mv compressed_data compressed_data.gz`
 2. `$ gzip -d ` dekompresija fajla

 `gzip` fajlovi počinju sa **\x1f\x8B\x08** 
 Jedan od takvih je prvi red hexdumped_data fajla
  `00000000: 1f8b 0808 8c3f f563 0203 6461 7461 322e  .....?.c..data2.`

  `gzip -d` ispravimo ekstenziju fajla, preimenovanjem fajla i dekompresijom 

  ```bash
  $ mv compressed_data compressed_data.gz #preimenujemo fajl dodavanjem ekstenzije .gz
  $ gzip -d compressed_data.gz #dekompresija fajla
  ```

**BZIP2**

1. Preimenujemo fajl sa ekstenzijom `.bz2` ako je `version2`

Podaci nisu u potpunosti dekompresovani jer imamo više različitih tipova kompresije

![level-12-xxd-command](.//bandit-level-screenshots/lvl12-xxd-command.png)

Na slici gledamo prve bajtove:
`425a` je **file signature** za `bzip`
`68 (h)` predstavlja verziju 2 -> `bzip2 -d` za dekompresiju

```bash
$ mv compressed_data compressed_data.bz2 #preimenujemo file compressed_data u file sa ekstenzijom .bz2
$ bzip2 -d compressed_data.bz2 #dekompresija
```

Ako pogledamo `compressed_data` vidimo da opet imamo slučaj sa `gzip`
```bash
$ mv compressed_data compressed_data.gz
$ gzip -d compressed_data.gz
```

Provjerimo stanje `compressed_data` pomoću `$ xxd compressed_data | head`

**Tar archives**

**Archive file** je fajl koji sadrži jedan ili više fajlova i njihove metadata
```bash
$ tar -cf #za kreiranje archive fajlova
$ tar -xf #za extracting achive fajlova
```
`.tar` ekstenzija

Prikazaće nam se u posljednjoj koloni `data5.bin......`
što bi značilo da imamo neki archive, pa koristimo `tar` za extract fajla

```bash
$ mv compressed_data compressed_data.tar
$ tar -xf compressed_data.tar #dobijamo data5.bin u listi -ls

$ tar -xf data5.bin #u -ls imamo data5.bin data6.bin
$ xxd data6.bin #vidimo da je bzip compressed na osnovu 425a, verzija 2 na osnovu 68

$ bzip2 -d data6.bin #dobijamo poruku: bzip2: Can't guess original name for data6.bin -- using data6.bin.out
$ xxd data6.bin.out | head #vidimo u zadnjoj koloni data8.bin pa koristimo tar ponovo

$ xxd data8.bin | head #provjerimo i vidimo da se radi o gzip 
$ mv data8.bin data8.gz #kod GZIP MORAMO promjeniti ekstenziju fajla, kod ostalih ne mora
$ gzip -d data8.gz
$ cat data8 #dobijamo sifru
```

![level-12](.//bandit-level-screenshots/lvl12-13pw.png)

pw `wbWdlBxEir4CaE8LaPhauuOo6pwRmrDw`