# Week 5 – Application Integration: SQS, SNS

### Tasks:

*  Create a Terraform script which will create the next infrastructure:
    - SQS queue 
    - SNS topic
    - EC2 instance with access to SQS and SNS services and SSH access to the instance as ususal
    - Output EC2 ip, topic ARN and queue URL
*  Terraform not supports email notification (see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription#email). So due to this when your infrastructure is deployed, you need to login in AWS management console and create manually email subscription to the created topic (do not forget to confirm it)
*  SSH to the created EC2 instance
*  Send and receive messages to/from SQS using AWS CLI commands
*  Send messages to SNS and get email notification using AWS CLI commands
---
SNS topic is forwarding messages to the queues, so we can read them by command aws sqs receive-message.