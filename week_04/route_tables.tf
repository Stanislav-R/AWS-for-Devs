### Route table with target as internet gateway ###
resource "aws_route_table" "demo_public_route_table" {
  vpc_id     = aws_vpc.demo_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.demo_internet_gateway.id
  }

  tags = {
    Name = "demo-public-route-table"
  }
}

### Associate route table to public subnet ###
resource "aws_route_table_association" "public_subnet_route_table_association" {
  subnet_id      = aws_subnet.demo_pubic_subnet.id
  route_table_id = aws_route_table.demo_public_route_table.id
}

## Route table with target as NAT EC2 gateway ###
resource "aws_route_table" "nat_ec2_route_table" {
  vpc_id = aws_vpc.demo_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    instance_id = aws_instance.nat_instance.id
  }

  tags = {
    Name = "nat-ec2-route-table"
  }
}


### Associate route table to private subnet ###
resource "aws_route_table_association" "private_subnet_route_table_association" {
  subnet_id      = aws_subnet.demo_private_subnet.id
  route_table_id = aws_route_table.nat_ec2_route_table.id
}