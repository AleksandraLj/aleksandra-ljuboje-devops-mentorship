#Packer
Packer je besplatni open-source alat, razvijen od komapnije HashiCorp i napisan u programskom jeziku GO, koji se koriste za kreiranje Images. Packer vam dozvoljava da kreirate iste images za razlicite platforme. Npr. mozete kreirati isti image za AWS, Azure, vmWare, VirtualBox itd. Packer je takodje integriran sa razlicitim alatima za konfigurisanje servera kao sto su Ansible, Chef, Puppet, SaltStack itd. Packer koristi JSON konfiguracione fajlove za definisanje sta zelite da se nalazi unutar image-a. Packer je cross-platform alat i moze se koristiti na Windows, Linux i Mac OS operativnim sistemima. Packer mozete koristiti za razlicite scenarije i taskove medjutim dva najecsca razloga zasto da koristite Packer su konzistentnost images koje kreirate i mogucnost integracije u vas CI/CD pipeline.

Korisne packer komande:
```bash
$ packer build -var-file=variables.json template.json
$ packer fmt .
$ packer validate template.json
$ packer build -on-error=ask -debug your-template.json
```