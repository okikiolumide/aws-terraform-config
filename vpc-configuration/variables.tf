variable "region" {
    default = "us-east-1"
}

# Get aws availability zones

data "aws_availability_zones" "available"{
    state = "available"
}

variable "vpc_cidr" {
    default = "172.16.0.0/16"
}

# variable "public_subnet_cidr" {
#     default = "172.16.0.0/16"
# }

# variable "private_subnet_cidr" {
#     default = "172.16.1.0/16"
# }

variable "enable_dns_support" {
    default = true
}

variable "enable_dns_hostnames"{
    default = true
}

variable "enable_classiclink"{
    default = "false"
}

variable "enable_classiclink_dns_support"{
    default = "false"
}

variable "preferred_number_of_public_subnets"{ 
    default = null
}

variable "preferred_number_of_private_subnets"{
    default = null
}

variable "environment" {
    default = "dev"
}

locals {
  default_tags = {
    Description = "Created by Terraform"
    Environment = dev
    Billing Account = 380741976904
    Owner Email = ddonolu@outlook.com
    Managed By = Ops    
  }
}
