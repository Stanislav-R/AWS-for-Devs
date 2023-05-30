### AWS Internet Gateway ###
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = var.vpc_id

  tags = {
    Name = "aws-internet-gw"
  }
}

### Route table with target as internet gateway ###
resource "aws_route_table" "public_route_table" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    Name = "public-route-table"
  }
}

### Associate route tables to public subnets ###
resource "aws_route_table_association" "first_subnet_public_route_table_association" {
  subnet_id      = var.first_public_subnet_id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "second_subnet_public_route_table_association" {
  subnet_id      = var.second_public_subnet_id
  route_table_id = aws_route_table.public_route_table.id
}

## Route table with target as NAT EC2 gateway ###
resource "aws_route_table" "nat_ec2_route_table" {
  vpc_id = var.vpc_id

  route {
    cidr_block  = "0.0.0.0/0"
    instance_id = var.nat_ec2_instance_id
  }

  tags = {
    Name = "nat-ec2-private-route-table"
  }
}

### Associate routes table to private subnets ###
resource "aws_route_table_association" "first_subnet_private_route_table_association" {
  subnet_id      = var.first_private_subnet_id
  route_table_id = aws_route_table.nat_ec2_route_table.id
}

resource "aws_route_table_association" "second_subnet_private_route_table_association" {
  subnet_id      = var.second_private_subnet_id
  route_table_id = aws_route_table.nat_ec2_route_table.id
}
