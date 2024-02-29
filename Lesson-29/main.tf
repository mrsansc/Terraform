data "aws_ami" "latest_amazon_linux" {
  owners      = ["137112412989"]
  most_recent = true
  filter {
    name   = "name"
    values = ["al2023-ami-2023.3.*-x86_64"]
  }
}

resource "aws_instance" "web" {
  ami                    = data.aws_ami.latest_amazon_linux.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.web.id]
  user_data              = <<EOF
#!/bin/bash
yum -y update
yum -y install httpd
myip=`curl http://169.254.169.254/latest/meta-data/local-ipv4`
echo "<h2>PROD WebServer with IP: $myip</h2><br>Build by Terraform!"  >  /var/www/html/index.html
sudo service httpd start
chkconfig httpd on
EOF

  tags = {
    Name  = "PROD WebServer - ${terraform.workspace}"
    Owner = "Sanzhar Urazaliyev"
  }
}

resource "aws_default_vpc" "default" {} # This need to be added since AWS Provider v4.29+ to get VPC id

resource "aws_security_group" "web" {
  name_prefix = "WebServer SG Prod"
  vpc_id      = aws_default_vpc.default.id # This need to be added since AWS Provider v4.29+ to set VPC id

  ingress {
    from_port   = 80
    to_port     = 80
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
    Name  = "Web Server SecurityGroup - ${terraform.workspace}"
    Owner = "Sanzhar Urazaliyev"
  }
}

resource "aws_eip" "web" {
  vpc      = true # Need to add in new AWS Provider version
  instance = aws_instance.web.id
  tags = {
    Name  = "PROD WebServer IP - ${terraform.workspace}"
    Owner = "Sanzhar Urazaliyev"
  }
}

####################################
output "web_public_ip" {
  value = aws_eip.web.public_ip
}
