# SADRŽAJ 

[📖 1 Bilješke i komande sa predavanja week-2](#1-Komande-sa-predavanja) </br>
[📖 2 Komande korištene pri izradi TASK - 2](#2-Komande-za-task-2)



<a name= "1-Komande-sa-predavanja">

# 1 Bilješke i komande sa predavanja week-2

```bash
$ hostnamectl #Displays your hostname
```

`$ man ssh ` -  manual za alat SSH 
`$ man` - komanda za prikaz manuala za komande 

**SSH** is a UNIX-based command suite and protocol for securely accessing a remote computer. SSH secures network client/server communications by authenticating both endpoints with a digital certificate and by encrypting passwords. SSH uses RSA public key cryptography to manage connections and authentication.
 
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
$ cat ./- #dodajemo putanju /
```
![level-1](.//bandit-level-screenshots/lvl1-2pw.png)

## Level 2 -> Level 3

Komandom `ls` provjerimo da li traženi fajl postoji u listi 
```bash 
$ cat "spaces in this filename" #koristimo navodnike kako bismo  izbjegli white spaces 
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
$ file ./* #za prikaz tipa podataka svakog fajla u direkriju inhere 
$ cat ./-file07 #iz liste smo vidjeli da jedino file07 ima tip podataka ASCII text te se pozicioniramo na njega
```

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
`-size` veličina fajla </br>
`! -executable` file je non executable </br>

```bash
$ cd maybehere07
$ cat .file2 #prikaz sadržaja fajla 
```
![level-5](.//bandit-level-screenshots/lvl5-6pw.png)

## Level 6 -> Level 7

- Šifra se nalazi **negdje na serveru** i moramo ispoštovati propertije:
* owned by user bandit7
* owned by group bandit6
* 33 bytes in size

```bash
$ find / -user bandit7 -group bandit6 -size 33c 2>&1 | grep  -F -v Permission | grep -F -v directory
```

Koristimo `find` komandu sa propertijima: </br>
`-user ` za filtriranje koristnika bandit7 </br>
`-group` za filtriranje grupe bandit6 </br>
`-size`  za filtriranje veličine 33 byte </br>
`2>&1`   za skrivanje svih mogućih **error** poruka </br>
`2>` redirects stderr to an (unspecified) file </br>
`&1` redirects stderr to stdout. </br>

Koristeći `|` **pipe line** rezultat lijeve komande prepuštamo dalje `grep` komandi koja ima propertije:</br>
`-F` tražimo pojam u fajlu </br>
`-v` **--invert-match** tražimo suprotno od Permission tj. directory </br>

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
  Zbog toga koristimo dodatno komandu `sort` da sortiramo tj. uklonimo ne-susjedne linije. </br>

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
