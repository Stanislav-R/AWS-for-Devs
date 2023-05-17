output "aws_region" {
  description = "AWS Region of the EC2 instance"
  value = var.aws_region
}

output "vpc_id" {
  description = "VPC"
  value = aws_vpc.demo_vpc.id
}

output "demo_pubic_subnet" {
  description = "Public subnet"
  value = aws_subnet.demo_pubic_subnet.id
}

output "demo_privat_subnet" {
  description = "Privat subnet"
  value = aws_subnet.demo_private_subnet.id
}

output "demo_internet_gateway" {
  description = "Internet gateway"
  value = aws_internet_gateway.demo_internet_gateway
}

output "elb_dns_name" {
  description = "DNS name of ELB"
  value = aws_lb.demo_alb.dns_name
}