# Auto Fill parameters for prod

# File can be named as:
# terraform.tfvars
# or
# *.auto.tfvars
# For example - prod.auto.tfvars, dev.auto.tfvars

region 						= "ca-central-1"
instance_type 				= "t3.micro"
enable_detailed_monitoring 	= false
allow_ports 				= ["80", "443"]

common_tags = {
    Owner       = "Sanzhar Urazaliyev"
    Project     = "Phoenix"
    CostCenter  = "127777742"
    Environment = "dev"
}

