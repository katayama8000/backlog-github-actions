#!/bin/sh

# Stop on error
set -e

# Extract inputs
BACKLOG_DOMAIN=$INPUT_BACKLOG_DOMAIN
API_KEY=$INPUT_API_KEY
PROJECT_KEY=$INPUT_PROJECT_KEY
ISSUE_TYPE_ID=$INPUT_ISSUE_TYPE_ID
SUMMARY=$INPUT_SUMMARY
PRIORITY=$INPUT_PRIORITY

# Convert priority name to ID
case "$PRIORITY" in
  "High")
    PRIORITY_ID=2
    ;;
  "Normal")
    PRIORITY_ID=3
    ;;
  "Low")
    PRIORITY_ID=4
    ;;
  *)
    echo "Invalid priority: $PRIORITY. Must be one of High, Normal, Low."
    exit 1
    ;;
esac

# Construct the API endpoint URL
API_URL="https://${BACKLOG_DOMAIN}/api/v2/issues?apiKey=${API_KEY}"

# Use curl to send a POST request
curl -s -X POST "${API_URL}" \
-H "Content-Type: application/x-www-form-urlencoded" \
-d "projectId=${PROJECT_KEY}" \
-d "issueTypeId=${ISSUE_TYPE_ID}" \
-d "priorityId=${PRIORITY_ID}" \
-d "summary=${SUMMARY}"