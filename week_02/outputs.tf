output "aws_region" {
  value = var.aws_region
  description = "AWS Region of the EC2 instance"
}

output "instance_ip_addr" {
  value       = aws_instance.ec2_instance.public_ip
  description = "The public IP address of the EC2 instance"
}