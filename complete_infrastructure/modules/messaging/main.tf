### SNS/SQS Resources ###
resource "aws_sns_topic" "sns_topic" {
  name = var.sns_topic_name
}

resource "aws_sqs_queue" "sqs_quene" {
  name = var.sqs_quene_name
}
