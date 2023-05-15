output "aws_region" {
  description = "AWS Region of the EC2 instance"
  value = var.aws_region
}

output "instance_ip_addr" {
  description = "The public IP address of the EC2 instance"
  value       = aws_instance.ec2_instance.public_ip
}

output "postgres_instance_endpoint" {
  description = "The connection endpoint"
  value       = aws_db_instance.aws_rds_postgres.endpoint
}

output "postgres_instance_port" {
  description = "RDS instance port"
  value       = aws_db_instance.aws_rds_postgres.port
}