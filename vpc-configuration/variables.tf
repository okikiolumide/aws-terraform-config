variable "region {
    
}

# Get aws availability zones

data "aws_availability_zones" "available"{
    state = "available"
}

variable "vpc_cidr" {
   
}

variable "public_subnet_cidr" {
    
}

variable "private_subnet_cidr" {
  
}

variable "enable_dns_support" {
    
}

variable "enable_dns_hostnames"{
  
}

variable "enable_classiclink"{
  
}

variable "enable_classiclink_dns_support"{
    
}

variable "preferred_number_of_public_subnets"{
    
}

variable "preferred_number_of_private_subnets"{
   
}

variable "environment" {
    
}