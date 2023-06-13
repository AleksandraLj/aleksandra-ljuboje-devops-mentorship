*Ovaj file sadrzi instrukcije za instalaciju Packer alata na WSL, kao i rjesenje za TASK-12 kreiranje AMI image-a za EC2 instance*

# Packer 

- open source alat, kreirana od strane HashiCorp kompanije 
- pisan je u programskom jeziku GO
- koristimo ga da kreiramo Custom/Base image

## UVOD
### Instalacija Chocolately na Windows 10 koristeci PowerShell (run as admin)
```bash
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```
>**Note**
> https://docs.chocolatey.org/en-us/choco/setup#install-with-powershell.exe
>https://developer.hashicorp.com/packer/tutorials/docker-get-started/get-started-install-cli
C:\Windows\System32> choco
Chocolatey v2.0.0
Please run 'choco -?' or 'choco <command> -?' for help menu.

* `$ choco install packer` 

### Instalacija na Ubuntu WSL 
- **Add the HashiCorp GPG key**
`curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -`
>**Note**
>Warning: apt-key is deprecated. Manage keyring files in trusted.gpg.d instead (see apt-key(8)).
OK
- **Add the official HashiCorp Linux repository**
`sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"`
- **Update and install**
`sudo apt-get update && sudo apt-get install packer`

```bash
$ packer

output
Usage: packer [--version] [--help] <command> [<args>]

Available commands are:
    build           build image(s) from template
    console         creates a console for testing variable interpolation
    fix             fixes templates from old versions of packer
    fmt             Rewrites HCL2 config files to canonical format
    hcl2_upgrade    transform a JSON template into an HCL2 configuration
    init            Install missing plugins or upgrade plugins
    inspect         see components of a template
    plugins         Interact with Packer plugins and catalog
    validate        check that a template is valid
    version         Prints the Packer version
```

>**Source**
>https://developer.hashicorp.com/packer/tutorials/docker-get-started/get-started-install-cli

## Packer templates - dio sa predavanja

* Pokretanje `01_first_ami.json`
`$ packer build <naziv-json-file>`


* `01_first_ami.json`
```bash
{
    "builders": [{
      "type": "amazon-ebs",
      "region": "us-east-1",
      "source_ami": "ami-0889a44b331db0194",
      "instance_type": "t2.micro",
      "ssh_username": "ec2-user",
      "temporary_key_pair_type": "ed25519",
      "ami_name": "packer-devops-mentorship {{timestamp}}"
    }]
}
```

>**Note**
> Potrebno je dodijeliti credentials u vidu Access i Secret Access keys na nacin da se dodaju u skriptu ili jedan od nacina koji je predlozen ovdje
> https://developer.hashicorp.com/packer/plugins/builders/amazon#specifying-amazon-credentials

```bash
"builders": {
  "type": "amazon-ebs",
  "access_key": "AKIAIOSFODNN7EXAMPLE",
  "secret_key": "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY",
  
}
```

### Instalacija AWS CLI kako bi se podesio profile i koristili credencijali 

* The latest AWS CLI version is 2. So download the AWS CLI.
```bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
```
* Unzip the file using the following command.
```bash
$ sudo apt install unzip # da instaliramo unzip

$ unzip awscliv2.zip
``` 
* Install the AWS CLI using the following command.
`$ sudo ./aws/install`

That’s all. AWS CLI is installed successfully on Ubuntu.

* We can get the AWS CLI version using the below command.
`$ aws --version`
* Output
`aws-cli/2.11.26 Python/3.11.3 Linux/4.4.0-19041-Microsoft exe/x86_64.ubuntu.22 prompt/off`

>**Source**
> https://medium.com/codex/install-aws-command-line-interface-cli-on-ubuntu-491383f93813

#### Podesimo profil 
```bash
$ aws configure --profile <ime-profila> # npr. aleksIaC
Unesemo Access key, Secret Access key, Region i Json format
```
#### Izmjene u template files 
* Kako svoje resurse kreiram u `eu-central-1` potrebno je promijeniti `ami-id`, `region` i dodati `profile`
```bash
  "builders": [{
      "type": "amazon-ebs",
      "profile": "<ime-profila>",
      "region": "eu-central-1",
      "source_ami": "ami-0122fd36a4f50873a",
     ....
```
## Rjesenje za TASK - 12
#### U zadatku, Packer alat koristen je za kreiranje  Custom AMI image od Amazon Linux 3 AMI, gdje je potrebno instalirati i enable-ovati potrebne `yum` repozitorije za instalaciju `nginx` i `mysql` baze podataka. 

* Potreban kod nalazi se u folderu `packer`
![packer-folder](task12-screenshots/packer/packer-folder.png)

* U folderu `shell-scripts` nalaze se dvije odvojene skripte. 
1. `install-nginx.sh` sa komandama potrebnim za enable `yum` repozitorija.
```bash
#/bin/bash

echo "This is script to enable nginx  yum repositories"
sleep 30
echo Updating yum 
sudo yum update -y
sudo yum install -y yum-utils
```
2. `install-mysql.sh` sa komandama potrebnim za dalju pred-instalaciju mysql baze podataka
```bash
echo "This is script to enable  mysql  repositories"
sudo rpm --import https://repo.mysql.com/RPM-GPG-KEY-mysql-2022

wget http://dev.mysql.com/get/mysql57-community-release-el7-8.noarch.rpm
```
* Kod za kreiranje Custom AMI image je dostupan u fajlu `01_packer_provisioners.json`

#### Pokretanje Packer skripte
* Komanda za pokretanje je
`$  packer build xx_packer_provisioners.json` 
>*Note*
> Voditi racuna da pri pokretanju `packer build` budemo pozicionirani u direktorij gdje se nalazi **xx_packer_provisioners.json** file.
* Output komande u terminalu

![packer-folder](task12-screenshots/packer/ami-created.png)


* Output komande u konzoli, gdje vidimo kreiran AMI image sa 
potrebnim tagovima

![packer-folder](task12-screenshots/packer/packer-ami-created.png)



