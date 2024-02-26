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

resource "aws_security_group" "Dynamic_SecurityGroup" {
  name        = "Dynamic SecurityGroup"
  description = "My First Dynamic SecurityGroup"

  dynamic "ingress" {
    for_each = ["80", "443", "3389", "1541", "9092", "9100", "10101"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }

  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["172.16.0.0/12"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "Dynamic SecurityGroup"
    Owner = "Sanzhar"
  }
}

