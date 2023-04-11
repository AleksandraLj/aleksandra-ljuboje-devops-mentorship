*TASK-7: Using Autoscaling Group and Load Balancer*

**TASK 7** 
https://github.com/allops-solutions/devops-aws-mentorship-program/issues/52

# Autoscaling Group i  Load Balancer
***Notes***
* **IAM User 1** ce svoje resurse da kreira unutar `eu-central-1` regiona.
* **IAM User 2** ce svoje resurse da kreira unutar `us-east-1` regiona.
* **IAM User 3** ce svoje resurse da kreira unutar `eu-west-1` regiona
* Obavezni tagovi:
    * `Name`
    * `CreatedBy` - `Ime Prezime`
    * `Email` - `vas-email`

--- **Kreiramo EC2 instancu** ---
GitHub link [Kreiranje EC2 instance](https://github.com/AleksandraLj/aleksandra-ljuboje-devops-mentorship/blob/main/week-7/EC2-kreiranje.md)
* Možemo koristiti prethodno kreirane `security group` ali je bitno da imaju otvorene portove `22` i `80`.

--- **Kreiranje nove Security grupe nacin II** ---
1. `EC2 Dashboard` -> `Network & security` -> `Security groups` -> `Create`
2. `Name` -> `web-server-week-8`
3. `Add rule`
`SSH` i `HTTP` protokol
`Source` -> `Anywhere`
4. `Description` - Security group created for web server in week-8
5. `Create security group`
--- **vratimo se na kreiranje EC2 instance** ---
1. Osvjezimo dio za Security group 
2. Izaberemo kreiranu grupu 
3. `Storage` -> `8` GiB `gp3`
4. Kreiramo instancu 

## Kreiranje  AMI image od postojece instance
**Potrebno je prethodno uraditi:**
- [x] Kreiramo EC2 instancu, ukoliko ne postoji 
- [x] Spojimo se na EC2 instancu 
`$ ssh -i "kljuc.pem" ec2-user@ip-adresa`
- [x] Instaliramo nginx
```bash
$ sudo su -
$ yum install nginx -y
$ systemctl start nginx
$ systemctl enable nginx
```

***Notes***
* Kreirajte AMI image od instance `ec2-ime-prezime-web-server`
* AMI image nazovite `ami-ime-prezime-web-server`

**Koraci:**
1. `Instances` - oznacimo instancu - `Images and Tempalates` - `Create image`
2.`Name` -> `ami-ime-prezime-web-server`
3. `Description` -> *Custom AMI image created from EC2 instance in week 8*
4. `No reboot` -> `Enable` 
**Ukoliko je ukljucena opcija `enable` instanca se nece restartati tokom procesa kreiranja AMI-a.**
5. `Storage` ostaje na `8 GiB gp3` 
6. Dodamo tagove
7. `Create image`

--- **kreira se AMI image** ---
* `root device` /dev/xvda je naš EBS koji je bio zakačen za našu EC2 instancu

7. Terminiramo našu EC2 instancu od koje smo kreirali AMI
`Instance state - Terminate`
* AMI image nastavlja da zivi i bez originalne EC2 instance, a dalje ga mozemo koristiti za kreianje novih EC2 instanci koje će imati pocetne postavke kao na originalnoj EC2 instanci. U ovom slucaju instaliran `nginx`server

## Kreiranje novih instanci od AMI image-a
1. Selektujemo AMI image od kojeg zelimo kreirati instance
2. `Launch instance from AMI`
3. Kreiramo novu EC2 instancu naziva `ec2-web-server`
4. `Key pair` mozemo izabrati vec postojeci 
5. `Security group` izaberemo onu ranije kreiranu 
6. `Storage` ostavimo sa istim podesavanjima
7. Kreiraj instancu 

--- **Kreirana je nova instanca od AMI-a** ---
* Ako uzmemo IP adresu nove instance, iskopiramo u browser `http://ip-adresa-nove-instance` dobijamo istu `Welcome to nginx stranicu`

**Graficki prikaz pogledati** [ovdje](https://lucid.app/lucidchart/8992ca28-ea6e-46a0-b957-1810f89830db/edit?viewport_loc=-150%2C54%2C2560%2C1168%2C0_0&invitationId=inv_01543e6d-a3a2-4e11-b33c-8228f76a8de0)
*Note* Uključite layer po layer kako bi se prikazao cijeli proces kreiranja AMI-a.

## Kreiranje APPLICATION LOAD BALANCERA -ALB
* ALB je `manage` servis, sto znaci da se AWS brine za njegovu visoku dostupnost i skalabilnost

**Potrebno je prethodno uraditi:**
- [x] Kreirati minimalno 2 EC2 instance
* Ukoliko jedna EC2 instanca prestane sa radom, ALB ce drugoj proslijediti saobracaj

- [x] Za prikaz samo `running` instanci koristimo filter `Instance state running` u `Find` pretrazivacu

**Koraci**
1. `EC2 Dashboard` -> `Load Balancers`-> `Create Load Balancer`
2. `Create Application Load Balancer`
3. `Load Balancer Name` -> `alb-web-servers`
4. `Scheme` -> `Internet facing`  kako bi omogucili da ALB bude dostupan van AWS-a, bilo gdje sa interneta
5. `IP address type` -> IPv4
6. `Network mapping`
* VPC ostavimo `defaultni` koji je AWS kreirao za nas pri preiranju AWS racuna
* `Mapping`  biramo Availability zone tj. subnets gdje ce se ALB nalaziti. 
    * Izaberemo AZ sa oznakom našeg trenutnog Regiona i oznakom `1a` ili `1b` ili po zelji 

### Kreiramo Security group za ALB

7. Kreiramo posebnu `Security group` za ALB, iz razloga sto ALB treba imati `inbound rule` za `http` tj. `80` kako bi mogao samo prihvatiti saobracaj od korisnika i proslijediti dalje `target grupama`.
* `Create new security group`
* `Name` -> `alb-sg-web-server`
* `Description` -> Security group for ALB for Web Servers
* `Inbound rule` -> `HTTP` i `Source` -> Anywhere
* `Create`
--- **Kreirana je Security group za ALB** ---
--- **Vratimo se na kreiranje ALB** ---
8. Osvjezimo i izaberemo našu sg `alb-sg-web-server`
9. Obrisemo ovu `default` koja se tu nalazi, klikom na **x**

### Kreiranje Target group
* Logicko grupiranje EC2 instanci ispred kojih se nalazi ALB

10. `Kreiramo Target grupe` -> `Create target group`
* `Type` -> `Instances`
* `Target group name` -> `tg-web-servers`
* `HTTP` na `port 80` - ostaviti kako jeste
* `defaultni` VPC - ostaviti kako jeste
* `Health checks` je komunikacija ALB i EC2 instance, gdje ALB radi `ping` EC2 instance kako bi provjerio da li je ista još dostupna tj. `running` 
    * `HTTP` protocol
    * `Health check path` ne koristimo u ovom slucaju. U ovom dijelu se navodi specificna putanja npr. `index.html` te ukoliko ona nije dostupna, odmah postavi tu EC2 instancu kao nedostupnu 
    * `Advanced health check settings` -> `Override` -> `80`
     kako bismo radili healh check preko porta 80. Sve je ok ako ALB dobija odgovor `200` na request.
    * Dodamo tagove koji su navedeni kao obavezni na pocetku.
    * `Next`
* `Registered targets` oznacimo EC2 instance koje dodajemo u Target group - **ovaj korak mozemo preskociti ili ove dvije EC2 instance terminirati kada budemo kreirali Auto Scaling group.**
    * `80` kao port preko kojeg zelimo primati requests -> `Include as pending`
    * `Create Target group`
    
    --- **Kreirana je target grupa** ---
    --- **Vratimo se na kreiranje ALB** ---
11. Osvjezimo i izaberemo nasu target grupu `tg-web-servers` cime je povezana Target grupa sa ALB 
12. Dodati obavezne tagove
13. `Create Load balancer`
* **Od sada nas ALB ima `DNS name` i EC2 instancama vise ne pristupamo preko njihovih Public IP adresa, vec preko `DNS name` ALB.**
14. `Listeners` -> kliknemo na `tg-web-servers`-> Targets i provjerimo stanje instanci. Sve dok nisu `healthy` nas ALB ih ne prepoznaje i one ne primaju saobracaj bez obzira sto su `running`

**VAŽNO**
*ALB i EC2 instance moraju biti u istim Availability zonama, kako bi se saobracaj izmedju njih mogao odvijati*

15. Kada smo postavili ALB, potrebno je promijeniti `inbound` pravila za `security group` od EC2 instanci na nacin da u dijelu `HTTP` obrisemo postojeci `rule za HTTP`. Kreiramo novi `HTTP rule` i postavi `Source` -> `Custom`  i izaberemo `alb-sg-web-server` i `Description` -> Allow inbound traffic only from ALB i `Save`.
**Note** 
Instanci se idalje moze pristupiti kroz terminal, uz koristenje Public IP. 

## Kreiranje Autoscaling group 

**Potrebno je prethodno uraditi:**
- [x] Kreirati Template kako ce ASG da izgleda

### Kreiranje Template-a

1. `EC2 dashboard`-> `Auto Scaling`-> `Launch Configuration`-> `Create Launch Configuration` -> `Create launch Template` u gornjem desnom cosku prozora. 
2. `Name` -> `asg-template-web-server`
3. `Description` -> Template for ASG used for Web Server
4. Obavezni tagovi navedeni na pocetku i `Enviroment` -> `Development`
5. `Application and OS Images / AMI`
* `Owned by me` -> izaberemo nas AMI image `ami-ime-prezime-web-server`
* `Instance type` -> `t2.micro`
* `Key pair (login)` - mozemo izabrati vec postojeci 
* `Network settings` 
    * `Security group` -> `web-server-week-8` kreirana na samom pocetku 
    * EBS volume ostavimo kako jeste `8 GiB gp3`
* `Create launch template`

### Kreiranje ASG

1. `EC2 dashboard`-> `Auto Scaling`-> `Auto Scaling Groups`
2. `Name` -> `asg-web-servers`
3. Izaberemo template `asg-template-web-server`
4. `Version` -> `Default` ili `Latest` da smo uvijek *up-to-date*
5. `Next`
6. `Deafultni` VPC 
7. `Availability Zone` ->   `1a` i `1b`
8. `Next`
9. `Attach to an existing load balancer` 
10. `Choose from your load balancer target groups` -> `tg-web-servers`
11. `VPC Lattice` -> `No VPC Lattice service`
12. `Healt checks`
* `Turn on Elastic Load Balancing health checks`
* 300 seconds
13. `Additional informations` 
* `Enable group metrics collection within Cloud Watch`
14. `Next`
15. `Configure group size and scaling policies`
* `Desired capacity` - postavimo zeljeni broj EC2 instanci koji mora biti u opsegu `min <= desired < max` - 3 
* `Minimum capacity`- 2
* `Maximum capacity` - 4
16. `Scaling policies` -> `Target tracking scaling policy`
17. `Scaling policy name` - `Target Tracking policy`
18. `Metric type` - `Average CPU utilization` 
19. `Target value` - `18` kada se CPU poveća iznad 18, dodaje se nova instanca
20. `Instance warmup` - mozemo postaviti 0, da preskocimo warmup 
21. `Next`
22. `Add notification`
* SNS Topic - mozemo kreirati novi topic za notifikacije, koji ce nas obavjestiti svaki put kada CPU poveca preko 18% 
    * `asg-sns-notifications`
    * email
    * Potvrditi email 
23. `Next`
24. Dodati obavezne tagove i ove dodatno:
* `Enviroment` - development
* `Name` - `web-servers-asg`
25. `Next`
26. `Create ASG` 

--- **Kreirana je ASG** ---

### Sta je potrebno provjeriti 

* *Updating capacity* za ASG, sacekati da zavrsi dodjela kapaciteta
* `EC2 Instances` -> kreiraju se 3 EC2 instance, sto je podeseno u `Desired`
* `Load balancers` -> oznacimo nas ALB -> `Listeners` -> kliknemo na target grupu i provjerimo da li su dodate 3 EC2 instance i da li su u statusu `Healthy`
* `EC2` -> `Auto scaling group` -> kliknemo na nasu ASG -> `Activity` gdje vidimo kreiranje, a kasnije i terminiranje nasih EC2 instanci 

### Dynamic scaling policies
* Imamo kreiranu `Target Tracking Policy`  koja kaze, kada se CPU poveca iznad 18%, broj instanci ce porasti. 

### Praćenje metrike pomoću Cloud Watch-a

1. `Cloud Watch` -> `All metrics` -> `EC2 per instance metric` -> pretrazimo po pojmu `CPUUtilization` oznacimo nase 3 instance
2. Preimenujemo graf u `CPU for Web servers` i oznacimo `1h`
3. Izaberemo jednu instancu, povezemo se na nju
4. `$ top`  da vidimo stanje sa CPU trenutno - ono je priblizno nuli

5. Koraci za povecanje CPU dati su [ovdje](https://www.wellarchitectedlabs.com/performance-efficiency/100_labs/100_monitoring_linux_ec2_cloudwatch/5_generating_load/)
* Povecavanjem broja `worker`-a povecavamo i CPU. Za prekid koristiti `Ctrl + C`

###  Kreiranje Cloud Watch alarma
- [x] Kreiramo alarm za povećanje instanci
- [x] Kreiramo alarm za smanjenje instanci 

--- **Alarm za inkrement instanci** ---
1. `Cloud Watch` -> `Alarms` -> `Create alarm`
2. `Select metrics`
3. `CPUUtilization` u pretragu
4. ` EC2 > By Auto Scaling group` i izaberemo `asg-web-servers`
5. `Select metrics`
* do `Statistic` je oznaceno: `CPUUtilization`, `asg-web-server`
6. `Statistic` -> `Average`
7. `Period` 1 minutes
8. `Treshold style` -> `Static`
9. `Greater` pa `then` 18 i `Next`
10. `Notification`
*  `In alarm`
* `Select an existing SNS topic` - > `asg-sns-notifications`
11.  `Auto Scaling action`
* `Alarm state trigger` -> `In alarm`
* `EC2 auto scaling group` i selektujemo  nasu grupu `asg-web-servers`
12.  `Alarm name` -> `asg-cpu-scaling-policy`, `Next` i `Create alarm`

--- **Alarm za dekrement instanci** ---
1. `Cloud Watch` -> `Alarms` -> `Create alarm`
2. `Select metrics`
3. `CPUUtilization` u pretragu
4. ` EC2 > By Auto Scaling group` i izaberemo `asg-web-servers`
5. `Select metrics`
* do `Statistic` je oznaceno: `CPUUtilization`, `asg-web-server`
6. `Statistic` -> `Average`
7. `Period` 1 minutes
8. `Treshold style` -> `Static`
9. **`Lover` pa `then` 18 i `Next`**
10. `Notification`
*  `In alarm`
* `Select an existing SNS topic` - > `asg-sns-notifications`
11.  `Auto Scaling action`
* `Alarm state trigger` -> `OK`
* `EC2 auto scaling group` i selektujemo  nasu grupu `asg-web-servers`
12.  `Alarm name` -> `cpu-lower-than-18`, `Next` i `Create alarm`

### Kreiranje Dynamic scaling policies

--- **Dynamic scaling policy za inkrement instanci** ---
1. `EC2` -> oznacimo nasu ASG -> `Automatic scaling` -> `Create dynamic scaling policy`
2. `Policy type` -> `Simple scaling`
3. `Name` -> `scale-up`
4. `Cloud Watch alarm` -> `asg-cpu-scaling-policy`
5. `Take the action` -> `Add`, `1`, `Percent of group`
6. `And then wait` -> `0`

* `Target tracking policy`  mozemo obrisati sada. 

--- **Dynamic scaling policy za inkrement instanci** ---
1. `EC2` -> oznacimo nasu ASG -> `Automatic scaling` -> `Create dynamic scaling policy`
2. `Policy type` -> `Step scaling`
3. `Name` -> `scale-down`
4. `Cloud Watch alarm` -> `cpu-lower-than-18`
5. `Take the action` -> `Remove`, `0`, `Percent of group`
6. `Remove instances in increments...` -> `1`




