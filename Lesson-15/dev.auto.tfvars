# Auto Fill parameters for dev

# File can be named as:
# terraform.tfvars
# or
# *.auto.tfvars
# For example - prod.auto.tfvars, dev.auto.tfvars

region 						= "ca-central-1"
instance_type 				= "t3.micro"
enable_detailed_monitoring 	= false
allow_ports 				= ["80", "443", "22", "3389", "53", "8080", "9100"]

common_tags = {
    Owner       = "Sanzhar Urazaliyev"
    Project     = "Phoenix"
    CostCenter  = "1234542"
    Environment = "dev"
}

