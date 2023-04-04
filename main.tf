locals {
  vpc_id = aws_vpc.this.id
  # az     = data.aws_availability_zones.available.names
}

# local.az
resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "baca-demo-vpc"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = local.vpc_id

  tags = {
    Name = "baca-demo"
  }
}


resource "aws_subnet" "public_subnet" {
  count = length(var.public_subnet_cidr)

  vpc_id                  = local.vpc_id
  cidr_block              = var.public_subnet_cidr[count.index]
  availability_zone       = slice(data.aws_availability_zones.available.names, 2, 4)
  map_public_ip_on_launch = true

  tags = {
    Name = "baca-demo"
  }
}


resource "aws_subnet" "private_subnet" {
  count = length(var.private_subnet_cidr)
  vpc_id            = local.vpc_id
  # availability_zone_database-az = slice(data.aws_availability_zones.available.names, 0, 2)
  cidr_block        = var.private_subnet_cidr[count.index]
  availability_zone = slice(data.aws_availability_zones.available.names, 0, 2)

  tags = {
    Name = "baca-demo"
  }
}



################################################################################
# CREATING PUBLIC ROUTE TABLES ASSOCIATED WITH PUBLIC SUBNET?
################################################################################

resource "aws_route_table" "public_route_table" {
  vpc_id = local.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "public-route-table"
  }
}

################################################################################
# CREATING PUBLIC ROUTE TABLES ASSOCIATION
################################################################################
resource "aws_route_table_association" "rt_association" {
  count = length(var.public_subnet_cidr)

  subnet_id      = aws_subnet.public_subnet.*.id[count.index]
  route_table_id = aws_route_table.public_route_table.id
}


