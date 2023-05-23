### Resources ###
resource "aws_sns_topic" "demo_sns_topic" {
  name = "demo_sns_topic"
}

resource "aws_sqs_queue" "demo_sqs_quene" {
  name = "demo_sqs_quene"
}

### Subscriptions ###
resource "aws_sns_topic_subscription" "sqs_quene_subscription" {
  protocol             = "sqs"
  raw_message_delivery = true
  topic_arn            = aws_sns_topic.demo_sns_topic.arn
  endpoint             = aws_sqs_queue.demo_sqs_quene.arn
}

### Permissions for forvarding messages from topic to quenes ###
resource "aws_sqs_queue_policy" "sqs_quene_subscription" {
  queue_url = aws_sqs_queue.demo_sqs_quene.id
  policy    = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "sns.amazonaws.com"
      },
      "Action": [
        "sqs:SendMessage"
      ],
      "Resource": [
        "${aws_sqs_queue.demo_sqs_quene.arn}"
      ],
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": "${aws_sns_topic.demo_sns_topic.arn}"
        }
      }
    }
  ]
}
EOF
}