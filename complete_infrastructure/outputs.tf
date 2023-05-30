output "vpc_id" {
  description = "VPC"
  value       = module.vpc.vpc_id
}

output "rds_address" {
  description = "The RDS connection endpoint"
  value       = module.postgres_instance.rds_address
}

output "sqs_quene_url" {
  description = "SQS URL"
  value       = module.messaging.sqs_quene_url
}

output "sns_topic_arn" {
  description = "ARN of SNS topic"
  value       = module.messaging.sns_topic_arn
}

output "load_balancer_dns_name" {
  description = "DNS name of Load Balancer"
  value       = module.ec2.load_balancer_dns_name
}
