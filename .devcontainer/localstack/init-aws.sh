#!/bin/bash

echo "Setting up SQS queue..."

# Create the SQS queue
awslocal sqs create-queue \
  --queue-name $AWS_SQS_STRIPE_EVENTS_QUEUE_QUEUE_NAME \
  --endpoint-url $AWS_ENDPOINT_URL \
  --region $AWS_REGION \
  --attributes '{
    "DelaySeconds": "0",
    "MessageRetentionPeriod": "86400",
    "VisibilityTimeout": "30"
  }'

# Get the queue URL and display it
QUEUE_URL=$(awslocal sqs get-queue-url --region $AWS_REGION --queue-name $AWS_SQS_STRIPE_EVENTS_QUEUE_QUEUE_NAME --query 'QueueUrl' --output text)
echo "SQS queue created successfully!"
echo "Queue URL: $QUEUE_URL"

# List all queues to verify
echo "Listing all queues:"
awslocal sqs list-queues
