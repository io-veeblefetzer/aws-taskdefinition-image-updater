#!/usr/bin/env bash

set -e

# The user should provide all AWS credentials

# Required parameters
AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID:?'AWS_ACCESS_KEY_ID environment variable missing.'}
AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY:?'AWS_SECRET_ACCESS_KEY environment variable missing.'}
IMAGE=${IMAGE:?'IMAGE environment variable missing.'}
TASK_DEFINITION_NAME=${TASK_DEFINITION_NAME:?'TASK_DEFINITION_NAME environment variable missing.'}

# Used as scratchpad
JSON_FILE="task-definition.json"

# Get the task definition
echo "Getting task definition: $TASK_DEFINITION_NAME"
TASK_DEFINITION_JSON=$(aws ecs describe-task-definition --task-definition $TASK_DEFINITION_NAME --query 'taskDefinition' --output json)

# Replace the image in the task definition
echo "Updating task definition with image: $IMAGE"
echo $TASK_DEFINITION_JSON | jq --arg image "$IMAGE" '.containerDefinitions[0].image = $image' | jq 'del(.taskDefinitionArn, .revision, .requiresAttributes, .status, .compatibilities, .registeredAt, .registeredBy)' > "$JSON_FILE"

# Reupload the new task definition
echo "Uploading task definition"
aws ecs register-task-definition --cli-input-json "file://$JSON_FILE" > result.json