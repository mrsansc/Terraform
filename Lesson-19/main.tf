#.............................................
# My Terraform
# 
# Terraform Conditions and Lookups
# 
# Made by Sanzhar Urazaliyev
# ............................................

provider "aws" {
  region = "ca-central-1"
}

variable "env" {
  default = "dev"
}

variable "prod_owner" {
  default = "Sanzhar Urazaliyev"
}

variable "no_prod_owner" {
  default = "Dyadya Vasya"
}


variable "ec2_size" {
  default = {
    "prod"    = "t3.medium"
    "dev"     = "t3.micro"
    "staging" = "t2.micro"
  }
}

variable "allow_port_list" {
  default = {
    "prod" = ["80", "443"]
    "dev"  = ["80", "22", "3389"]
  }
}



resource "aws_instance" "my_server1" {
  ami = "ami-0156b61643fdfee5c"
  // instance_type = var.env == "prod" ? "t2.large" : "t2.micro"
  instance_type = var.env == "prod" ? var.ec2_size["prod"] : var.ec2_size["dev"]
  tags = {
    Name  = "${var.env}-server"
    Owner = var.env == "prod" ? var.prod_owner : var.no_prod_owner
  }
}

resource "aws_instance" "my_dev_bastion" {
  count         = var.env == "dev" ? 1 : 0
  ami           = "ami-0156b61643fdfee5c"
  instance_type = "t2.micro"

  tags = {
    Name = "Bastion Server for Dev"
  }
}


resource "aws_instance" "my_server2" {
  ami           = "ami-0156b61643fdfee5c"
  instance_type = lookup(var.ec2_size, var.env)

  tags = {
    Name  = "${var.env}-server"
    Owner = var.env == "prod" ? var.prod_owner : var.no_prod_owner
  }
}


resource "aws_security_group" "my_webserver" {
  name = "Dynamic SecurityGroup"

  dynamic "ingress" {
    for_each = lookup(var.allow_port_list, var.env)
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
    Name  = "Dynamic SecurityGroup"
    Owner = "Sanzhar"
  }
}

