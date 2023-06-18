*Office Hours 15.4.2023. dostupne na [linku](https://www.youtube.com/watch?v=w4GP-jHYffI&feature=youtu.be)*

[FAJL U IZRADI]

# Kreiranje Self-Signed certifikata

* Self signed certifikat je certifikat koji izdajemo "sami sebi" tj. mi kreiramo dvostruke parove kljuceva i vodimo racuna da njihova bezbjednost nije narusena 

Koraci:
1. Spojimo se na EC2 instancu
2. `$ sudo su -`
3. `$ cd /etc/nginx/`
4. `$ mkdir ssl`
5. `$ cd ssl/`
6. `$ openssl req -509 -sha256 -nodes -days 365 -newkey rsa:2048 -keyout privateKey.key -out certificare.crt` kreiramo private key i certificate.crt  i unesemo trazene podatke. 

```bash
$ openssl genrsa 2048 > ca-key.pem # generisanje kljuceva
$ openssl req -new -x509 -nodes -days 365000 -key ca-key.pem -out ca-cert.pem 
```

Certifikat se nalazi na lokaciji:
```bash
$ sudo su -
$ cd etc/ssl
$ cd ..
$ cd nginx/ssl/ -> certificate.crt
```
Vratimo se u `conf.d`

```bash
$ cd ..
$ cd conf.d/
$ cp node-app.conf node-app.conf.ssl.bak  # kopija conf fajla aplikacije/backup

$ vi node-app.conf 
# izmjenimo putanje:
  ssl_certificate u /etc/nginx/certificate.crt
  ssl_certificate_key u /etc/nginx/ssl/privateKey.key

  ESC
  :wq
  ```