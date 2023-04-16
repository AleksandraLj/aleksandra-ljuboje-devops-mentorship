*TASK 7 https://github.com/allops-solutions/devops-aws-mentorship-program/issues/52*

## Povezivanje na EC2 instancu od koje kreiramo AMI
* Na slici vidimo uspjesan pristup instanci i nginx serveru
![slika](img/"task 7"/povezivanje_na_originalnuEC2.png)

## Povezivanje na  EC2 instancu kreirane od AMI image-a
* Na slici vidimo uspjesan pristup instanci i nginx serveru
![slika](img/task%207/ami-ec2-browser-nginx.png)

## DNS record ALB 
* Na slici vidimo kreiran Application Load Balancer
![slika](img/task%207/dns-record.png)

## Kreiran Template za ASG
![slika](img/task%207/created_ASG_template.png)

## Kreirana Auto scaling group
![slika](img/task%207/asg-created.png)

## Instance nakon kreiranja ASG 
* Desired je 3 
![slika](img/task%207/atstartInstances.png)

## Instance dodate automatski u target group
![slika](img/task%207/instances%20added%20to%20target%20group.png)

## Povecan broj instanci, ali sa delayom 
* U momentu su `running` 4 instance, ali u ovom dijeli ASG pise 5 zbog `delay`-a od 6-7 min 
![slika](img/task%207/delay.png)

## CloudWatch u stanju "In Alarm"
![slika](img/task%207/in-alarm.png)

## Nakon smanjenja CPU ispod 18%, smanjen broj instanci na minimum 2
![slika](img/task%207/dekrement%20instance.png)
![slika](img/task%207/instance%20nakon%20smanjenog%20cpu.png)

## CloudWatch metrics 
* Instanca na kojoj je testirano povecanje CPU
![slika](img/task%207/cpu-ec2.png)

## Pristup nginx serveru preko ALB
![slika](img/task%207/nginx_using_alb.png)
