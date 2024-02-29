data "aws_availability_zones" "available" {}
data "aws_ami" "latest_amazon_linux" {
  owners      = ["137112412989"]
  most_recent = true
  filter {
    name   = "name"
    values = ["al2023-ami-2023.3.*-x86_64"]
  }
}


resource "aws_eip" "myip-prod" {}
resource "aws_default_vpc" "default" {} # This need to be added since AWS Provider v4.29+ to get VPC id
