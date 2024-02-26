#.............................................
# My Terraform
# 
# Terraform Loops: Count and For if
# 
# Made by Sanzhar Urazaliyev
# ............................................

provider "aws" {
  region = "ca-central-1"
}

variable "aws_users" {
  description = "List of IAM Users to Create"
  default     = ["vasya", "petr", "kolya", "lena", "mahs", "misha", "vova", "donald"]
}
resource "aws_iam_user" "user1" {
  name = "Pushkin"
}


resource "aws_iam_user" "users" {
  count = length(var.aws_users)
  name  = element(var.aws_users, count.index)
}


output "created_IAM_users_all" {
  value = aws_iam_user.users
}

output "created_IAM_users_ids" {
  value = aws_iam_user.users[*].id
}

output "created_IAM_users_custom" {
  value = [
    for user in aws_iam_user.users :
    "Username: ${user.name} has ARN: ${user.arn}"
  ]
}

output "created_IAM_users_map" {
  value = {
    for user in aws_iam_user.users :
    user.unique_id => user.id // "AIDAVPDH6RAAONWP5ZHX4" : "vasya"
  }
}

// Print List of users with 4 name characters ONLY
output "custom_if_length" {
  value = [
    for i in aws_iam_user.users :
    i.name
    if length(i.name) == 4
  ]
}


# ............................................

resource "aws_instance" "servers" {
  count         = 3
  ami           = "ami-0156b61643fdfee5c"
  instance_type = "t2.micro"

  tags = {
    Name = "Server Number ${count.index + 1}"
  }
}

// Print nica MAP of InstanceID: PublicIP
output "server_all" {
  value = {
    for server in aws_instance.servers :
    server.id => server.public_ip
  }
}
