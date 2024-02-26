#.............................................
# My Terraform
# 
# Terraform: Provision Resources in Multiply AWS Regions / Accounts
# 
# Made by Sanzhar Urazaliyev
# ............................................

provider "aws" {
  region = "ca-central-1"
  /*
  access_key = "xxxxxxxxxxxxx"
  secret_key = "yyyyyyyyyyyyy"

  assume_role {
  	role_arn = "arn:aws:iam::1234567890:role/RemoteAdministrators"
  	session_name = "TERRAFORM_SESSION"
  }
  */
}


provider "aws" {
  region = "us-east-1"
  alias  = "USA"
}

provider "aws" {
  region = "eu-central-1"
  alias  = "GER"
}

#=====================================================
data "aws_ami" "default_latest_amazon" {
  owners      = ["137112412989"]
  most_recent = true
  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

data "aws_ami" "usa_latest_amazon" {
  provider    = aws.USA
  owners      = ["137112412989"]
  most_recent = true
  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

data "aws_ami" "ger_latest_amazon" {
  provider    = aws.GER
  owners      = ["137112412989"]
  most_recent = true
  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}


resource "aws_instance" "my_default_server" {
  instance_type = "t2.micro"
  ami           = data.aws_ami.default_latest_amazon.id
  tags = {
    Name = "Default Server"
  }
}

resource "aws_instance" "my_usa_server" {
  provider      = aws.USA
  instance_type = "t2.micro"
  ami           = data.aws_ami.usa_latest_amazon.id
  tags = {
    Name = "USA Server"
  }
}

resource "aws_instance" "my_eu_server" {
  provider      = aws.GER
  instance_type = "t2.micro"
  ami           = data.aws_ami.ger_latest_amazon.id
  tags = {
    Name = "Europe Server"
  }
}
