#!/bin/bash

aws sqs send-message --queue-url {SQS URL} --message-body "Test message from SQS" --region us-west-2

aws sqs receive-message --queue-url {SQS URL} --region us-west-2