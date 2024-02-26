/*
#..................................................................
# My First Terraform WebServer
#
# Build WebServer during Bootstrap
# 
# Made by Sanzhar Urazaliyev
# 
#..................................................................
*/

/*
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.3"
    }
  }
}
*/

provider "aws" {
  region = "eu-central-1"
}

/* Comments here */

resource "aws_instance" "My_WebServer" {
  ami                    = "ami-03cceb19496c25679" # Amazon Linux AMI
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.My_WebServer.id]
  user_data              = <<EOF
  
#!/bin/bash
yum -y update
yum -y install httpd
myip='curl http://169.254.169.254/latest/meta-data/local-ipv4'
echo "<h2>WebServer with IP: $myip</h2><br>Build by Terraform!" > /var/www/html/index.html
sudo service httpd start
chkconfig httpd on 

EOF

  tags = {
    Name  = "Web Server Build by Terraform"
    Owner = "Sanzhar"
  }
}


resource "aws_security_group" "My_WebServer" {
  name        = "WebServer Security Group"
  description = "My First Security Group"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "Web Server SecurityGroup"
    Owner = "Sanzhar"
  }
}

