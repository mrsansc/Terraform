provider "aws" {
  region = "eu-central-1"
}


resource "aws_instance" "my_ubuntu" {
  ami           = "ami-0faab6bdbac9486fb"
  instance_type = "t2.micro"

  tags = {
    Name    = "My Ubuntu Server"
    Owner   = "Sanzhar"
    Project = "Terraform Lessons"
  }
}

resource "aws_instance" "my_almalinux" {
  ami           = "ami-03cceb19496c25679"
  instance_type = "t2.micro"

  tags = {
    Name    = "My Amazon Server"
    Owner   = "Sanzhar"
    Project = "Terraform Lessons"
  }
}
