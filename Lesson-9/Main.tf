provider "aws" {}


data "aws_availability_zones" "working" {}
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
data "aws_vpcs" "foo" {}


data "aws_vpc" "prog_vpc" {
  tags = {
    Name = "prog"
  }
}


resource "aws_subnet" "prog_subnet_1" {
  vpc_id            = data.aws_vpc.prog_vpc.id
  availability_zone = data.aws_availability_zones.working.names[0]
  cidr_block        = "10.20.1.0/24"
  tags = {
    Name    = "Subnet-1 in ${data.aws_availability_zones.working.names[0]}"
    Account = "Subnet in Account ${data.aws_caller_identity.current.account_id}"
    Region  = data.aws_region.current.name
  }
}

resource "aws_subnet" "prog_subnet_2" {
  vpc_id            = data.aws_vpc.prog_vpc.id
  availability_zone = data.aws_availability_zones.working.names[1]
  cidr_block        = "10.20.2.0/24"
  tags = {
    Name    = "Subnet-2 in ${data.aws_availability_zones.working.names[1]}"
    Account = "Subnet in Account ${data.aws_caller_identity.current.account_id}"
    Region  = data.aws_region.current.name
  }
}





output "prog_vpc_id" {
  value = data.aws_vpc.prog_vpc.id
}

output "prog_vpc_cidr" {
  value = data.aws_vpc.prog_vpc.cidr_block
}

output "aws_vpcs" {
  value = data.aws_vpcs.foo.ids
}


output "data_aws_availability_zones" {
  value = data.aws_availability_zones.working.names
}

output "data_aws_caller_identity" {
  value = data.aws_caller_identity.current.account_id
}


output "data_aws_region_name" {
  value = data.aws_region.current.name
}


output "data_aws_region_description" {
  value = data.aws_region.current.description
}
