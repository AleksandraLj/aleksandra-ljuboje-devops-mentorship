*Ovaj file sadrzi instrukcije za izradu dijela zadatka TASK -12 koji se tiče Terraform alata i kreiranja EC2 instanci*

# Terraform

>*Instalacija na Ubuntu*
>https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli
## Rjesenje za TASK - 12

- Preporuka je koristenje Dynamic inventory file-a u Ansible, kako bismo automatski "kupili" IP adrese instanci kreirane koristeci Terraform.
- Kako to zahtjeva vise prakse, ovdje je koristen Output kako bi se lakse pronasle adrese kreiranih instanci i upisale u staticki inventory

>*Dynamic inventory*
>https://faun.pub/terraform-ansible-get-dynamic-inventory-of-ec2-10f2868aae76

### AWS Provider 
>*AWS Provider*
>https://registry.terraform.io/providers/hashicorp/aws/latest/docs
- koristi se za podesavanje kredencijala i interakciju sa resursima
- sadrzaj `providers.tf` fajla je prikazan ispod.
- Navodimo region, putanje ka kredencijalima i sl.
```bash
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}
# Configure the AWS Provider
provider "aws" {
  region                   = "eu-central-1"
  shared_config_files      = ["~/.aws/config"]
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = "ime-profila"
}
```

### `main.tf` file
- u `main.tf` fajlu navodimo kod kroz koji kreiramo resurse. 

#### Kreiranje SG za webserver i dbserver instance
- kako je receno da koristimo defaultni VPC pri kreiranju resursa isti nije potrebno navoditi.
```bash
resource "aws_security_group" "webserver-sg" {
  description = "Allow SSH and HTTP access"
  
   tags = {
    Name = "task-12-sg-webserver-tf"
    CreatedBy = "aleksandra.ljuboje"
    Project = "task-12"
    IaC = "Terraform"
  }
```
- `webserver-sg` je logicko ime SecurityGroup za webservere
- `Name = "task-12-sg-webserver-tf"` je fizicko ime 
- cijeli kod je dostupan u `terraform/Default/main.tf`
- Na slici vidimo kreirane SecurityGroups pomocu Terraform-a.
- Dodati su i odgovarajuci tagovi.

![slika](task12-screenshots/tf/tf-sg-created.png)


### Kreiranje EC2 instanci
- cijeli kod je dostupan u `terraform/Default/main.tf`
- Na slici vidimo kreirane EC2 instance, sa pripadajucim SG pomocu Terraform-a.
- Dodati su i odgovarajuci tagovi.

![slika](task12-screenshots/tf/tf-instances-created.png)

### Output 
- koristena je opcija output kako bi dohvatili ime i public ip za instance kreirane pomocu Terraform-a. Zatim su podaci rucno upisani u Ansible `inventory/prod.ini` file.

- Na slici je prikaz koda i output-a

![slika](task12-screenshots/tf/tf-outputs.png)