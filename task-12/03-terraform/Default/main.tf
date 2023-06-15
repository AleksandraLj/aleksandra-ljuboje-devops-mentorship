resource "aws_security_group" "webserver-sg" {
  description = "Allow SSH and HTTP access"
  
   tags = {
    Name = "task-12-sg-webserver-tf"
    CreatedBy = "aleksandra.ljuboje"
    Project = "task-12"
    IaC = "Terraform"
  }

  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
   
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
   
  }
}

resource "aws_security_group" "database-sg" {
    description = "Security group for MySQL"
    tags = {
      Name = "task-12-sg-dbserver-tf"
      CreatedBy = "aleksandra.ljuboje"
      Project = "task-12"
      IaC = "Terraform"
    }

    ingress {
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    egress {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
resource "aws_instance" "webserver-instance" {
  ami           = "ami-09ecc100363951e6a"
  instance_type = "t2.micro"
  key_name      = "packer-proba"
  vpc_security_group_ids = [aws_security_group.webserver-sg.id]
  tags = {
    Name = "task-12-webserver-tf"
    CreatedBy = "aleksandra.ljuboje"
    Project = "task-12"
    IaC = "Terraform"
  }

  
}

resource "aws_instance" "dbserver-instance" {
  ami           = "ami-09ecc100363951e6a"
  instance_type = "t2.micro"
  key_name      = "packer-proba"
  vpc_security_group_ids = [aws_security_group.database-sg.id]
  tags = {
    Name = "task-12-dbserver-tf"
    CreatedBy = "aleksandra.ljuboje"
    Project = "task-12"
    IaC = "Terraform"
  }

}



output "dbserver_ec2_instances" {
  description = "Name and Public IP of dbserver instance"
  value       = concat(aws_instance.dbserver-instance.*.tags.Name, aws_instance.dbserver-instance.*.public_ip)
}
output "webserver_ec2_instances" {
  description = "Name and Public IP of webserver instance"
  value       = concat(aws_instance.webserver-instance.*.tags.Name, aws_instance.webserver-instance.*.public_ip)
}

