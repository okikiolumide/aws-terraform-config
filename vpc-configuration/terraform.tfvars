region                                  = "eu-central-1"

vpc_cidr                                = "172.16.0.0/16"

enable_dns_support                      = "true"

enable_dns_hostnames                    = "true"

enable_classiclink                      = "false"

enable_classiclink_dns_support          = "false"

preferred_number_of_public_subnets      = 2

preferred_number_of_private_subnets     = 2

environment                             = "dev"

public_subnet_cidr                     = "172.16.0.0/24"

private_subnet_cidr                     = "172.16.1.0/24"