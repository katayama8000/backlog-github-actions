# Backlog Issue Creator

This GitHub Action creates a new issue in your Backlog project.

---

## Inputs

| Parameter | Description | Required |
| :--- | :--- | :--- |
| `backlog_domain` | Your Backlog domain (e.g., `example.backlog.com`) | `true` |
| `api_key` | Your Backlog API Key | `true` |
| `project_id` | The project ID (e.g., `123456`) | `true` |
| `issue_type_id` | The issue type ID | `true` |
| `summary` | The summary of the new issue | `true` |
| `priority_id` | The priority ID of the new issue | `true` |
| `parent_issue_id` | Parent Issue ID | `false` |
| `description` | Description of the issue | `false` |
| `start_date` | Start Date (yyyy-MM-dd) | `false` |
| `due_date` | Due Date (yyyy-MM-dd) | `false` |
| `estimated_hours` | Estimated Hours | `false` |
| `actual_hours` | Actual Hours | `false` |
| `category_ids` | Category IDs (comma-separated for multiple values) | `false` |
| `version_ids` | Version IDs (comma-separated for multiple values) | `false` |
| `milestone_ids` | Milestone IDs (comma-separated for multiple values) | `false` |
| `assignee_id` | Assignee ID | `false` |
| `notified_user_ids` | Notified User IDs (comma-separated for multiple values) | `false` |
| `attachment_ids` | Attachment file IDs (comma-separated for multiple values) | `false` | |

---

## Usage

Use the action in your workflow file (`.github/workflows/your-workflow.yml`).

```yaml
name: Create Backlog Issue

on:
  workflow_dispatch:

jobs:
  create-issue:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout repository
        uses: actions/checkout@v5
      
      - name: Create a new Backlog issue
        uses: katayama8000/backlog-issue-creator@0.3.2
        with:
          backlog_domain: 'YOUR_DOMAIN.backlog.com'
          api_key: ${{ secrets.BACKLOG_API_KEY }}
          project_id: 'YOUR_PROJECT_ID'
          issue_type_id: 'YOUR_ISSUE_TYPE_ID'
          summary: 'Sample Task'
          priority_id: 'YOUR_PRIORITY_ID'
          description: |
            This is a multi-line
            description for the issue.
```
