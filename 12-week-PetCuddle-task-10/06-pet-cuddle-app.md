*Associated with week-12/Task-10 available on [link](https://github.com/allops-solutions/devops-aws-mentorship-program/issues/70)*

# Pet Cuddle-o-Tron mini project 
* Implementacija fully serverless aplikacije koristeci Step funkcije, Lambda, API Gateway i S3 website hosting 

![slika](files/pet-cuddle-app/info.png)

## STAGE 1 - Configuring SES
* **SES** Simple Email service, korisimo za slanje i primanje email-ova unutar aplikacije. **SANDBOX MODE** da izbjegnemo spam pa moramo staviti adrese na whitelist kako bismo omogucili komunikaciju
* Email from Pet app will come from aleksandra-main-email
* Email to send emails - email-od-poslasticarnice

![slika](files/pet-cuddle-app/st1.png)

#### 1. Verifikovan application main email 

![slika](files/pet-cuddle-app/verif-email.png)

![slika](files/pet-cuddle-app/ver-email.png)

#### 2. Verifikovan customer  email 

![slika](files/pet-cuddle-app/ver-pos.png)

#### SES Verified Identities 
![slika](files/pet-cuddle-app/ses.png)

## STAGE 2 - Configuring Lambda function

![slika](files/pet-cuddle-app/st2.png)

####  Create STACK, IAM Role and Lambda 
![slika](files/pet-cuddle-app/stack-created-lambda-role.png)

#### Lambda role created

![slika](files/pet-cuddle-app/lambdarole-created.png)

#### Lambda email-reminder-lambda function

![slika](files/pet-cuddle-app/lambda-email-reminder.png)

#### Lambda email-reminder-lambda function deployed

![slika](files/pet-cuddle-app/email-reminder-lambda.png)



## STAGE 3 - State Machine

![slika](files/pet-cuddle-app/st3.png)

#### Kreiran STACK za State Machine role i rola dodata u IAM roles

![slika](files/pet-cuddle-app/stm-role.png)

![slika](files/pet-cuddle-app/stm-role-added.png)

#### Kreiranje State Machine in Step Function

![slika](files/pet-cuddle-app/sf-sm-code.png)

```bash
{
  "Comment": "Pet Cuddle-o-Tron - using Lambda for email.",
  "StartAt": "Timer",
  "States": {
    "Timer": {
      "Type": "Wait",
      "SecondsPath": "$.waitSeconds",
      "Next": "Email"
    },
    "Email": {
      "Type" : "Task",
      "Resource": "arn:aws:states:::lambda:invoke",
      "Parameters": {
        "FunctionName": "EMAIL_LAMBDA_ARN",
        "Payload": {
          "Input.$": "$"
        }
      },
      "Next": "NextState"
    },
    "NextState": {
      "Type": "Pass",
      "End": true
    }
  }
}
```

* `EMAIL-LAMBDA-ARN` zamijeniti sa arn kreirane lambda funkcije, omoguciti logove koristeci postojecu rolu i dozvoliti ALL sve logove.

![slika](files/pet-cuddle-app/machine-created.png)

arn:aws:states:eu-central-1:828462330928:stateMachine:PetCuddleOTrone


## STAGE 4  - Lambda funkcija za API, Konfiguracija API i API Gateway

![slika](files/pet-cuddle-app/st4.png)

#### Kreiranje supportinng Lambda funkcije za API 

![slika](files/pet-cuddle-app/lambda-api.png)

#### Kreiranje API Gateway, API i metod koji nasa serverless app koristi
* Kreiramo REST API
 
 ![slika](files/pet-cuddle-app/api.png)


#### Kreiranje resursa 

 ![slika](files/pet-cuddle-app/creating-resource.png)

 #### Kreiranje metode POST + oznaciti  Proxy integration (naknadno uradjeno)

 ![slika](files/pet-cuddle-app/kreiranje-metode.png)

 #### Method execution

 ![slika](files/pet-cuddle-app/method-execution.png)

 #### Action -> Deploy API

 ![slika](files/pet-cuddle-app/deploy-api.png)



 ## STAGE 5  - Client Side Application 

  #### Kreirati S3 public bucket petcuddleotrone2212, omoguciti static website hosting, izmijeniti fajlove i dodati ih na bucket

* Bucket policy
```bash
{
    "Version":"2012-10-17",
    "Statement":[
      {
        "Sid":"PublicRead",
        "Effect":"Allow",
        "Principal": "*",
        "Action":["s3:GetObject"],
        "Resource":["REPLACEME_PET_CUDDLE_O_TRON_BUCKET_ARN/*"]
      }
    ]
  }
  ```

 ![slika](files/pet-cuddle-app/s3-endpoint.png)

#### Testiranje aplikacije 

![slika](files/pet-cuddle-app/testing-app.png)

#### Testiranje aplikacije - ERROR

![slika](files/pet-cuddle-app/error.png)

* Nakon troubleshoot-a greska koja se desila je sljedeca


`Missing authentication token	"x-amzn-errortype" = "MissingAuthenticationTokenException"	"Missing Authentication Token"	An authentication token wasn't found in the request.`
