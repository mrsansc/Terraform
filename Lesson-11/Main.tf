# ........................................
# My Terraform
# 
# Find Latest AMI id of:
#	- Ubuntu
#	- Amazon Linux 2
#	- Windows Server 2022
# 
# Made by Sanzhar Urazaliyev
# 
# ........................................

provider "aws" {
  region = "ap-southeast-1"
}

data "aws_ami" "latest_ubuntu" {
  owners      = ["099720109477"]
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-lunar-23.04-amd64-server-*"]
  }
}

data "aws_ami" "latest_amazon_linux" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}


data "aws_ami" "latest_windows_2022" {
  owners      = ["801119661308"]
  most_recent = true
  filter {
    name   = "name"
    values = ["Windows_Server-2022-English-Full-Base-*"]
  }
}



resource "aws_instance" "My_WebServer_ubuntu" {
  ami           = data.aws_ami.latest_ubuntu.id
  instance_type = "t2.micro"
}


output "latest_windows_2022_ami_id" {
  value = data.aws_ami.latest_windows_2022.id
}

output "latest_windows_2022_ami_name" {
  value = data.aws_ami.latest_windows_2022.name
}


output "latest_amazon_linux_ami_id" {
  value = data.aws_ami.latest_amazon_linux.id
}

output "latest_amazon_linux_ami_name" {
  value = data.aws_ami.latest_amazon_linux.name
}


output "latest_ubuntu_ami_id" {
  value = data.aws_ami.latest_ubuntu.id
}

output "latest_ubuntu_ami_name" {
  value = data.aws_ami.latest_ubuntu.name
}
