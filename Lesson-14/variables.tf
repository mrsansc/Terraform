
variable "region" {
  description = "Please Enter AWS Region to deploy Server:"
  type        = string
  default     = "ca-central-1"
}

variable "instance_type" {
  description = "Enter Instance Type"
  type        = string
  default     = "t4g.micro"
}

variable "allow_ports" {
  description = "List Of Ports To Open For Server"
  type        = list(any)
  default     = ["80", "443", "22", "3389", "53"]
}

variable "enable_detailed_monitoring" {
  type    = bool
  default = false
}

variable "common_tags" {
  description = "Common Tags to Apply to all resources"
  type        = map(any)
  default = {
    Owner       = "Sanzhar Urazaliyev"
    Project     = "Phoenix"
    CostCenter  = "1234542"
    Environment = "development"
  }
}


