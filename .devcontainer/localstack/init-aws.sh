#!/bin/bash

echo "Setting up SQS queue..."

# Create the SQS queue
awslocal sqs create-queue \
  --queue-name stripe-events-queue \
  --endpoint-url http://localstack:4566 \
  --attributes '{
    "DelaySeconds": "0",
    "MessageRetentionPeriod": "86400",
    "VisibilityTimeout": "30"
  }'

# Get the queue URL and display it
QUEUE_URL=$(awslocal sqs get-queue-url --queue-name stripe-events-queue --query 'QueueUrl' --output text)
echo "SQS queue created successfully!"
echo "Queue URL: $QUEUE_URL"

# List all queues to verify
echo "Listing all queues:"
awslocal sqs list-queues
