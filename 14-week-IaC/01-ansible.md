### Ansible
Ansible je alat za upravljanje konfiguracijama servera koji koristi deklarativni pristup i ne zahtijeva instalaciju agenta na serverima. Ansible koristi YAML za pisanje skripti, što ga čini lako čitljivim i razumljivim. Ansible koristi DSL (Domain Specific Language) 


#### **[Ansible configuration file](https://docs.ansible.com/ansible/latest/reference_appendices/config.html)**   

Datoteka `ansible.cfg` je konfiguracijska datoteka koja se koristi za konfigurisanje različitih opcija i postavki za Ansible. Ova datoteka može biti prisutna u vasem radnom direktoriju ili u `/etc/ansible` direktoriju (globalna konfiguracija).

Konfiguracijski fajl mozete generisati koristeci:
```bash
$ ansible-config init --disabled -t all > ansible.cfg
```

Unutar datoteke `ansible.cfg` mozete definisati različite opcije i postavke koje će utjecati na izvrsavanje Ansible-a.

[defaults] sekcija: Ova sekcija sadrži opće postavke za Ansible, kao što su putanje do inventory fajla, moduli koje koristi, izvršni direktorij i drugo. Primjeri opcija unutar [defaults] sekcije:

inventory: Putanja do inventara koji se koristi kao zadani.
remote_user: Zadani SSH korisnik za konekciju na remote hostove.
module_name: Zadani naziv modula koji se koristi za izvršavanje zadataka.
roles_path: Putanja do direktorija koji sadrži Ansible role.
[privilege_escalation] sekcija: Ova sekcija se koristi za konfiguriranje privilegiranog izvršavanja (escalation) zadatka. Ovdje možete postaviti opcije kao što su become (omogući privilegirano izvršavanje) i become_method (metoda koja se koristi za privilegirano izvršavanje, npr. sudo).

[ssh_connection] sekcija: Ova sekcija se koristi za konfiguriranje SSH veze s ciljnim čvorovima. Ovdje možete postaviti opcije kao što su ssh_args (dodatni argumenti za SSH) i pipelining (omogući ili onemogući pipelining).

[ansible_become] sekcija: Ova sekcija se koristi za konfiguriranje opcija privilegiranog izvršavanja. Ovdje možete postaviti opcije kao što su become (omogući privilegirano izvršavanje), become_method (metoda za privilegirano izvršavanje) i become_user (korisnik koji će postati privilegirani korisnik).

Ovo su samo neke od opcija koje se mogu nalaziti u datoteci ansible.cfg. Možete prilagoditi ove opcije prema svojim potrebama ili dodati druge opcije koje su relevantne za vaše okruženje i konfiguraciju.

Napomena: Ako datoteka `ansible.cfg` ne postoji, Ansible će koristiti zadane vrijednosti i postavke.

### Ansible Playbooks
Ansible Playbook je prvi fajl koji cete napisati kada krenete da radite sa Ansiblom. Playbook je izraz koji se koristi za fajl koji predstavlja skriptu sa izmjenama koje zelimo napraviti. Playbook pisemo u YAML formatu. YAML je fromat slican JSON-u s tim da je lakse za citanje i pisanje.
**NOTE: Validan JSON fajl je validan YAML fajl, ali ne i obrnuto.**

##### Anatomija Ansible Playbook-a  

Ansible Playbook se sastoji od nekoliko elemenata:
- `name` - Komentar koji opisuje i govori sta playbook radi
- `become` - Opcija koja omogucava privilegirano izvrsavanje. Po defaultu je vrijednost `false`. Mozete je promijeniti na `true` ili `yes` sto znaci da ce se komande izvrsavati kao root korisnik. To je losa praksa.
- `hosts` - Lista hostova na kojima ce se izvrsavati Ansible taskovi. Hostovi se mogu navesti u obliku liste ili grupisani.
- `vars` - Varijable koje se koriste u playbooku. Varijable se mogu definisati u samom playbooku ili u posebnom fajlu.
- `tasks` - Lista taskova koji se izvrsavaju na hostovima. Taskovi se izvrsavaju po redoslijedu u kojem su navedeni.

### Ansible Modules
Ansible Modules su skripte koje dolaze zapakovane skupa sa Ansiblom i omogucavaju izvrsavanje razlicitih operacija na ciljnim hostovima. 
Da bi vidjeli dokumentaciju modula izvrsite komandu:
```bash
$ ansible-doc <module_name>
```
#### Ansible Roles
Ansible Roles su najbolji nacin za organizovanje i ponovno koristenje Ansible koda. Ansible role je direktorij koji sadrzi sve sto je potrebno da bi se izvrsio odredjeni zadatak. 

#### Ansible Inventory file
Ansible inventory je datoteka koja sadrži listu hostova na kojima će se izvrsavati Ansible taskovi. Ansible inventory može biti u razlicitim formatima, kao što su INI, YAML ili JSON. Ansible inventory moze sadrzavati i grupisane hostove, sto vam omogucava da grupisete hostove prema razlicitim kreterijima (npr. development, production itd).


#### Ansible Commands
```bash
$ ansible-playbook webserver.yml 
$ ansible-playbook webserver.yml --check # dry run mode
$ ansible-playbook -i inventory/prod.ini  webserver.yml
$ ansible all -a "hostname"
$ ansible-vault encrypt <file>
$ ansible-vault view <file> | ansible-vault edit <file> 
```