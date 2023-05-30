output "sqs_quene_url" {
  description = "SQS URL"
  value       = aws_sqs_queue.sqs_quene.url
}

output "sns_topic_arn" {
  description = "ARN of SNS topic"
  value       = aws_sns_topic.sns_topic.arn
}
