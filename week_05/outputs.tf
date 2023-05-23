output "aws_region" {
  description = "AWS Region of the EC2 instance"
  value = var.aws_region
}

output "instance_ip_addr" {
  description = "The public IP address of the EC2 instance"
  value       = aws_instance.ec2_instance.public_ip
}

output "sqsurl" {
  description = "SQS URL"
  value = aws_sqs_queue.demo_sqs_quene.url
}

output "topic_arn" {
  description = "ARN of SNS topic"
  value = aws_sns_topic.demo_sns_topic.arn
}