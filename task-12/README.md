 *U ovom fajlu nalaze se kratke smjernice gdje pronaci korake i kod za navedene dijelove TASK -12*

 ## 1. dio zadatka
 #### [PACKER] - Create Custom AMI image from Amazon Linux 3 AMI image where you will have needed yum repos installed and enabled to install nginx web server and mysql database.
* Instalacija Packer alata na WSL, objasnjenje koda i koraci pri rjesavanju objasnjeni su u fajlu `packer.md`
* Kod koristen za ovaj dio zadatka dostupan je u direktorijumu `packer`

## 2. dio zadatka
 #### [IaC - CloudFormation] Using an AMI image from step 1 create 2 new EC2 instances called task-12-web-server-cf and task-12-db-server-cf. For those instances create appropriate security groups and open needed ports. Please try to follow best practices for security groups. You can put your resources inside default VPC and public subnets.

* CF Template za kreiranje CF Stack-a za ovaj dio zadatka dostupan je u direkorijumu `cloudformation` pod nazivom `cf-instances.yaml`
* Objasnjenje za ovaj dio zadatka dostupno je u fajlu `cf.md`

## 3. dio zadatka
#### [IaC - Terraform] Using an AMI image from step 1 create 2 new EC2 instances called task-12-web-server-tf and task-12-db-server-tf. For those instances create appropriate security groups and open needed ports. Please try to follow best practices for security groups. You can put your resources inside default VPC and public subnets.

* TF kod  za ovaj dio zadatka dostupan je u direkorijumu `terraform` 
* Objasnjenje za ovaj dio zadatka dostupno je u fajlu `tf.md`

## 4. dio zadatka
#### [Ansible] By using ansible provisioner install nginx web server on task-12-web-server-cf and task-12-web-server-tf instances. By using ansilbe provisioner install mysql database on task-12-db-server-cf and task-12-db-server-tf instances.

#### CF i Ansible
 - You need to ensure that once when nginx is instaled that it is enabled and started
 - nginx web server instances needs to have index.html file with content **Hello from nginx web server created using CloudFormation and Ansible**
 #### TF i Ansible
 - You need to ensure that once when nginx is instaled that it is enabled and started
 - nginx web server instances needs to have index.html file with content **Hello from nginx web server created using Terraform and Ansible**

 #### DB Instance i Ansible
 - Mysql database needs to have database called `task-12-db` and user `task-12-user` with password `task-12-password` and **all privileges on task-12-db** database

* Kod za ovaj dio zadatka dostupan je u direktorijumu `asnible_playbooks`
* objasnjenje za ovaj dio zadatka dostupno je u fajlu `ansible.md`

## 5. dio zadatka
#### By using Ansible task verify connection via default mysql database port from task-12-web-server-cf and task-12-web-server-tf instances to task-12-db-server-cf and task-12-db-server-tf instances. For the connection verification you can use telnet tool.

* Kod za ovaj dio zadatka dostupan je u direktorijumu `asnible_playbooks` u fajlu `03-check-connection.yml`
* objasnjenje za ovaj dio zadatka dostupno je u fajlu `ansible.md`


