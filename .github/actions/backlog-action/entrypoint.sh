#!/bin/sh

# Stop on error
set -e

# Extract inputs
BACKLOG_DOMAIN=$INPUT_BACKLOG_DOMAIN
API_KEY=$INPUT_API_KEY
PROJECT_KEY=$INPUT_PROJECT_KEY
ISSUE_TYPE_ID=$INPUT_ISSUE_TYPE_ID
SUMMARY=$INPUT_SUMMARY

# Construct the API endpoint URL
API_URL="https://${BACKLOG_DOMAIN}/api/v2/issues?apiKey=${API_KEY}"

# Use curl to send a POST request
curl -s -X POST "${API_URL}" \
-H "Content-Type: application/x-www-form-urlencoded" \
-d "projectIdOrKey=${PROJECT_KEY}" \
-d "issueTypeId=${ISSUE_TYPE_ID}" \
-d "summary=${SUMMARY}"
