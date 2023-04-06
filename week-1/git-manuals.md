*week-1 devops mentorship program*

# [![My Skills](https://skillicons.dev/icons?i=git)](https://skillicons.dev) Rad sa GitHub-om 
* U nastavku su prikazani koraci za:
    * Kreiranje lokalnog `git` repozitorija na računaru
    * Kreiranje GitHub profila
    * Kreiranje `ssh` ključeva
    * Osnovne komande za rad sa `git`-om

### Kreiranje ssh public-private ključa
1. U `C:\Users\ime-usera\` kreiramo folder `.shh` ukoliko isti ne postoji na lokaciji
2. U terminalu `cmd`, `PowerShell` ili koji već koristite pozicionirate se na folder `.ssh` komandom
`$ cd C:\Users\ime-usera\.ssh`
3. Uradimo sljedeće komande:
```bash

$ ssh-keygen -t rsa #komanda za generisanje ssh privatnog i javnog kljuca 

$ cat .ssh/id_rsa.pub # ispis javnog kljuca na ekran
#Dodavanje javnog kljuca unutar github UI
```
4. Na GitHub profilu -> `Settings` -> `SSH and GPG keys` -> `New SSH key` -> napišemo smisleno ime i paste public ključa

5. Kreiranje lokalnog `git repozitorija`, koraci:
```bash
$ mkdir ime-prezime-devops-mentorship

$ cd ime-prezime-devops-mentorship

$ git init

$ git commit --allow-empty -m "initial commit" 
#dozvoljavanje i pravljenje praznog commita

$ git branch #provjera brancha

$ git remote add origin <Kopira se SSH kod našeg GitHub repozitorija> #povezivanje sa udaljenim repozitorijem na GitHub

$  git push --set-upstream origin main #guranje izmjena na remote repozitorij

# provjera unutar GitHUb UI da li je inicijaliziran prazna main grana
```
6. Kreiramo granu na GitHub profilu, a u terminalu odradimo korake:
```bash
# kreiranje development branch kroz GitHub UI
# Povratak na terminal

$ git pull #povlacenje izmjena sa remote repozitorija (development branch)

$ git checkout development #prebacivanje na development branch lokalno


#kreiranje gitignore i readme file kroz vscode

$ git add . #dodavanje kreiranih fileova

$ git commit -m"add .gitignore and readme files"

$ git push -u origin <naziv branch grane>
```
--- **Promjene su postavljene na GitHub** ---

7. Kreirati Pull Request i merge `main` i `branch` na kojem radimo

--- **Svaki sljedeci put uraditi ove korake** ---
* `$ git checkout main` da budemo na `main` grani
1. `$ git pull` da preuzmemo posljednje izmjene
2. `$ git checkout <branch na kojem radimo>` prebaciti se na branch na kojem radimo
3. `$ git status` provjerimo status
4. `$ git add .` dodamo promjene
5. `$ git commit -m "Komentar..."` uradimo `commit`
6. `$ git push -u origin <naziv-branch-grane>` 


--- **Dodatne komande** ---

* Kreiranje nove `branch` kroz `git` terminal
`$ git branch -b <naziv-branch>` i koraci od `3.` do `6.` sa `origin main` u koraku `6.`
* Pregled `commit`-a
`$ git log`
* Pregled razlika u fajlovima
`$ git diff <fajl>`
* Provjera na kojoj grani se trenutno nalazimo
`$ git branch`
