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

resource "aws_eip" "my_ststic_ip" {
  instance = aws_instance.My_WebServer.id
}

/* Comments here */

resource "aws_instance" "My_WebServer" {
  ami                    = "ami-03cceb19496c25679" # Amazon Linux AMI
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.My_WebServer.id]
  user_data = templatefile("user-data.sh.tpl", {
    f_name = "Sanzhar",
    l_name = "Urazaliyev",
    names  = ["Vasya", "Kolya", "Rahimzhan", "ahhahaha", "brbrbrbr", "brbrbrbodplks"]
  })

  tags = {
    Name  = "Web Server Build by Terraform"
    Owner = "Sanzhar"
  }

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_security_group" "My_WebServer" {
  name        = "WebServer Security Group"
  description = "My First Security Group"

  dynamic "ingress" {
    for_each = ["80", "443", "3389", "1541", "9092", "9100", "10101"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }

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

