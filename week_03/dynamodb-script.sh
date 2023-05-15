#!/bin/bash

aws dynamodb list-tables --region us-west-2

echo "put (key -> '1' -> 'Monday')"
aws dynamodb put-item --table-name "tf-notes-table" --item '{ "noteId": {"S": "1" }, "Value": {"S": "Monday"} }' --region us-west-2
echo "put (key -> '1' -> 'Tuesday')"
aws dynamodb put-item --table-name "tf-notes-table" --item '{ "noteId": {"S": "2" }, "Value": {"S": "Tuesday"} }' --region us-west-2

echo "get value with key -> '1'"
aws dynamodb get-item --table-name "tf-notes-table" --key '{ "noteId": {"S": "1" } }' --region us-west-2
echo "get value with key -> '2'"
aws dynamodb get-item --table-name "tf-notes-table" --key '{ "noteId": {"S": "2" } }' --region us-west-2

echo "get not existed value"
aws dynamodb get-item --table-name "tf-notes-table" --key '{ "noteId": {"S": "3" } }' --region us-west-2