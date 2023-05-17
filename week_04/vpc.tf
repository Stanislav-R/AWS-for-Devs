### VPC ###
resource "aws_vpc" "demo_vpc" {
  cidr_block                       = "10.0.0.0/16"
  instance_tenancy                 = "default"
  enable_dns_hostnames             = true
  assign_generated_ipv6_cidr_block = false

  tags = {
    Name = "demo-vpc"
  }
}

### Public subnet ###
resource "aws_subnet" "demo_pubic_subnet" {
  vpc_id                  = aws_vpc.demo_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone_id    = "usw2-az1"
  map_public_ip_on_launch = true

  tags = {
    Name = "demo-public-subnet"
  }
}

### Privat subnet ###
resource "aws_subnet" "demo_private_subnet" {
  vpc_id                  = aws_vpc.demo_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone_id    = "usw2-az2"
  map_public_ip_on_launch = false

  tags = {
    Name = "demo-private-subnet"
  }
}

### Internet gateway ###
resource "aws_internet_gateway" "demo_internet_gateway" {
  vpc_id     = aws_vpc.demo_vpc.id

  tags = {
    Name = "demo-internet-gateway"
  }
}