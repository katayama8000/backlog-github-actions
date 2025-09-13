# Backlog Issue Creator

This GitHub Action creates a new issue in your Backlog project.

---

## Inputs

| Parameter         | Description                                       | Required | Default  |
| ----------------- | ------------------------------------------------- | -------- | -------- |
| `backlog_domain`  | Your Backlog domain (e.g., `example.backlog.com`) | `true`   |          |
| `api_key`         | Your Backlog API Key                              | `true`   |          |
| `project_id`      | The project ID (e.g., `123456`)                   | `true`   |          |
| `issue_type_id`   | The issue type ID                                 | `true`   |          |
| `summary`         | The summary of the new issue                      | `true`   |          |
| `priority`        | The priority of the new issue (High, Normal, Low) | `false`  | `Normal` |

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
        uses: katayama8000/backlog-issue-creator@v1.0.0
        with:
          backlog_domain: 'YOUR_DOMAIN.backlog.com'
          api_key: ${{ secrets.BACKLOG_API_KEY }}
          project_id: 'YOUR_PROJECT_ID'
          issue_type_id: 'YOUR_ISSUE_TYPE_ID'
          summary: 'Sample Task'
          priority: 'Normal'
```

> This action is actively being developed. Optional parameters such as `description` will be added in future versions. Stay tuned.