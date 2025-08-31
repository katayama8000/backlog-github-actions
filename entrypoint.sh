#!/bin/sh

# Stop on error
set -e

# Extract inputs
BACKLOG_DOMAIN=$INPUT_BACKLOG_DOMAIN
API_KEY=$INPUT_API_KEY
PROJECT_ID=$INPUT_PROJECT_ID
ISSUE_TYPE_ID=$INPUT_ISSUE_TYPE_ID
SUMMARY=$INPUT_SUMMARY
PRIORITY_ID=$INPUT_PRIORITY_ID
PARENT_ISSUE_ID=$INPUT_PARENT_ISSUE_ID
DESCRIPTION=$INPUT_DESCRIPTION
START_DATE=$INPUT_START_DATE
DUE_DATE=$INPUT_DUE_DATE
ESTIMATED_HOURS=$INPUT_ESTIMATED_HOURS
ACTUAL_HOURS=$INPUT_ACTUAL_HOURS
CATEGORY_IDS=$INPUT_CATEGORY_IDS
VERSION_IDS=$INPUT_VERSION_IDS
MILESTONE_IDS=$INPUT_MILESTONE_IDS
ASSIGNEE_ID=$INPUT_ASSIGNEE_ID
NOTIFIED_USER_IDS=$INPUT_NOTIFIED_USER_IDS
ATTACHMENT_IDS=$INPUT_ATTACHMENT_IDS
CUSTOM_FIELDS=$INPUT_CUSTOM_FIELDS

# Construct the API endpoint URL
API_URL="https://${BACKLOG_DOMAIN}/api/v2/issues?apiKey=${API_KEY}"

# Build curl command with required parameters
CURL_DATA=""
CURL_DATA="${CURL_DATA} -d projectId=${PROJECT_ID}"
CURL_DATA="${CURL_DATA} -d issueTypeId=${ISSUE_TYPE_ID}"
CURL_DATA="${CURL_DATA} -d priorityId=${PRIORITY_ID}"
CURL_DATA="${CURL_DATA} -d summary=${SUMMARY}"

# Add optional parameters if they are provided
[ -n "$PARENT_ISSUE_ID" ] && CURL_DATA="${CURL_DATA} -d parentIssueId=${PARENT_ISSUE_ID}"
[ -n "$DESCRIPTION" ] && CURL_DATA="${CURL_DATA} -d description=${DESCRIPTION}"
[ -n "$START_DATE" ] && CURL_DATA="${CURL_DATA} -d startDate=${START_DATE}"
[ -n "$DUE_DATE" ] && CURL_DATA="${CURL_DATA} -d dueDate=${DUE_DATE}"
[ -n "$ESTIMATED_HOURS" ] && CURL_DATA="${CURL_DATA} -d estimatedHours=${ESTIMATED_HOURS}"
[ -n "$ACTUAL_HOURS" ] && CURL_DATA="${CURL_DATA} -d actualHours=${ACTUAL_HOURS}"
[ -n "$ASSIGNEE_ID" ] && CURL_DATA="${CURL_DATA} -d assigneeId=${ASSIGNEE_ID}"

# Handle array parameters (comma-separated values)
if [ -n "$CATEGORY_IDS" ]; then
  IFS=',' read -ra CATEGORIES <<< "$CATEGORY_IDS"
  for category in "${CATEGORIES[@]}"; do
    CURL_DATA="${CURL_DATA} -d categoryId[]=${category}"
  done
fi

if [ -n "$VERSION_IDS" ]; then
  IFS=',' read -ra VERSIONS <<< "$VERSION_IDS"
  for version in "${VERSIONS[@]}"; do
    CURL_DATA="${CURL_DATA} -d versionId[]=${version}"
  done
fi

if [ -n "$MILESTONE_IDS" ]; then
  IFS=',' read -ra MILESTONES <<< "$MILESTONE_IDS"
  for milestone in "${MILESTONES[@]}"; do
    CURL_DATA="${CURL_DATA} -d milestoneId[]=${milestone}"
  done
fi

if [ -n "$NOTIFIED_USER_IDS" ]; then
  IFS=',' read -ra NOTIFIED_USERS <<< "$NOTIFIED_USER_IDS"
  for user in "${NOTIFIED_USERS[@]}"; do
    CURL_DATA="${CURL_DATA} -d notifiedUserId[]=${user}"
  done
fi

if [ -n "$ATTACHMENT_IDS" ]; then
  IFS=',' read -ra ATTACHMENTS <<< "$ATTACHMENT_IDS"
  for attachment in "${ATTACHMENTS[@]}"; do
    CURL_DATA="${CURL_DATA} -d attachmentId[]=${attachment}"
  done
fi

# Execute curl command
eval "curl -s -X POST \"${API_URL}\" -H \"Content-Type: application/x-www-form-urlencoded\" ${CURL_DATA}"