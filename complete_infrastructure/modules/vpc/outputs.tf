output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "vpc_cidr_block" {
  value = aws_vpc.vpc.cidr_block
}

output "first_public_subnet_cidr_block" {
  value = aws_subnet.first_public_subnet.cidr_block
}

output "second_public_subnet_cidr_block" {
  value = aws_subnet.second_public_subnet.cidr_block
}

output "first_public_subnet_id" {
  value = aws_subnet.first_public_subnet.id
}

output "second_public_subnet_id" {
  value = aws_subnet.second_public_subnet.id
}

output "first_private_subnet_id" {
  value = aws_subnet.first_private_subnet.id
}

output "second_private_subnet_id" {
  value = aws_subnet.second_private_subnet.id
}
