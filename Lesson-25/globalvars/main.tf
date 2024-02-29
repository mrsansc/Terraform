#----------------------------------------------------------
# My Terraform
#
# Global Variables in Remote State on S3
#
# Made by Sanzhar Urazaliyev
#----------------------------------------------------------
provider "aws" {
  region = "ca-central-1"
}

terraform {
  backend "s3" {
    bucket = "sanzhar-urazaliyev-project-terraform-state"
    key    = "globalvars/terraform/tfstate"
    region = "ca-central-1"
  }
}

#===========================================================

output "company_name" {
  value = "ANDESA Soft International"
}

output "owner" {
  value = "$Sanzhar Urazaliyev"
}

output "tags" {
  value = {
    Project    = "Assembly-2024"
    CostCenter = "R&D"
    Country    = "Canada"
  }
}

