
# Create VPC

resource "aws_vpc" "main" {
    cidr_block                          = var.vpc_cidr
    enable_dns_support                  = var.enable_dns_support
    enable_dns_hostnames                = var.enable_dns_support
    enable_classiclink                  = var.enable_classiclink
    enable_classiclink_dns_support      = var.enable_classiclink
    
    tags = {
            Name = format("vpc-%s" , var.environment )
        }
    
}

# Create Public Subnet 

resource "aws_subnet" "public" {
    count                       = var.preferred_number_of_public_subnets == null ? length(data.aws_availability_zones.available.names) : var.preferred_number_of_public_subnets
    vpc_id                      = aws_vpc.main.id
    cidr_block                  = cidrsubnet(var.vpc_cidr, 8 , count.index)
    map_public_ip_on_launch     = true
    availability_zone           = data.aws_availability_zones.available.names[count.index]
    tags = {
            Name = format("%s-public-subnet-%s" , var.environment, count.index )
        }
    
}    

# Create Private Subnet

resource "aws_subnet" "private" {
    count                       = var.preferred_number_of_private_subnets == null ? length(data.aws_availability_zones.available.names) : var.preferred_number_of_private_subnets
    vpc_id                      = aws_vpc.main.id
    cidr_block                  = cidrsubnet(var.vpc_cidr, 4 , count.index+2)
    map_public_ip_on_launch     = false
    availability_zone           = data.aws_availability_zones.available.names[count.index]
    tags = merge(
        local.default_tags,{
            Name = format("%s-private-subnet-%s" , var.environment, count.index )
        }
    )
}    

# Route Table

resource "aws_route_table" "public-route"{
    vpc_id = aws_vpc.main.id

    tags = merge(
        local.default_tags, {
            Name = format("public-route-table-%s" , var.environment )
        }
    )
}
   
resource "aws_route" "rt" {
    route_table_id          =   aws_route_table.public-route.id
    destination_cidr_block  = "0.0.0.0/0"
    gateway_id              = aws_internet_gateway.ig.id
}

resource "aws_route_table_association" "public" {
    count                   = length(aws_subnet.public[*].id)
    subnet_id               = element(aws_subnet.public[*].id, count.index)
    route_table_id          = aws_route_table.public-route.id
}


resource "aws_route_table" "private-route"{
    vpc_id = aws_vpc.main.id

    tags = merge(
        local.default_tags, {
            Name = format("private-route-table-%s" , var.environment )
        }
    )
}
   
resource "aws_route" "rt2" {
    route_table_id              = aws_route_table.private-route.id
    destination_cidr_block      = "0.0.0.0/0"
    nat_gateway_id              = aws_nat_gateway.nat.[count.index].id
}

resource "aws_route_table_association" "private" {
    count                   = length(aws_subnet.private[*].id)
    subnet_id               = element(aws_subnet.private[*].id, count.index)
    route_table_id          = aws_route_table.private-route.id
}

