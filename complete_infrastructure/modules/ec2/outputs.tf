output "nat_ec2_instance_id" {
  value = aws_instance.nat_ec2.id
}

output "load_balancer_dns_name" {
  description = "DNS name of ALB"
  value       = aws_lb.load_balancer.dns_name
}

output "latest_ami_id" {
  value = data.aws_ami.amazon-linux-2.id
}
