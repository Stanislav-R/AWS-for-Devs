#!/bin/bash

aws sns publish --topic {ARN of SNS topic} --message 'Hello world from AWS' --region us-west-2

aws sqs receive-message --queue-url {SQS URL} --region us-west-2