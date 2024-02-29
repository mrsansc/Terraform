# Since Terraform v0.15.2
# terraform apply -replace aws_instance.node2
#
provider "aws" {
  region = "us-west-1"
}

resource "aws_instance" "node1" {
  ami           = "ami-07619059e86eaaaa2"
  instance_type = "t2.micro"
  tags = {
    Name  = "Node-1"
    Owner = "Sanzhar Urazaliyev"
  }
}

resource "aws_instance" "node2" {
  ami           = "ami-07619059e86eaaaa2"
  instance_type = "t2.micro"
  tags = {
    Name  = "Node-2"
    Owner = "Sanzhar Urazaliyev"
  }
}

resource "aws_instance" "node3" {
  ami           = "ami-07619059e86eaaaa2"
  instance_type = "t2.micro"
  tags = {
    Name  = "Node-3"
    Owner = "Sanzhar Urazaliyev"
  }
  depends_on = [aws_instance.node2]
}
