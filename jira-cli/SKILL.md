---
name: jira-cli
description: Use Jira CLI for core ticket workflows (search, create, edit, assign, transition, comments, worklogs, epics, sprints, releases) and apply MEP team defaults. Use when user mentions Jira, jira-cli, tickets, sprints, boards, or JQL.
---

# Jira CLI

## Quick Start

- Jira CLI binary: `/Users/vaclav.benes/.config/jira/bin/jira`
- First-time setup: `jira init` then `jira me`
- Prefer non-interactive runs with `--no-input`

## Setup and Auth (Upstream)

- Cloud: export `JIRA_API_TOKEN`, run `jira init`, choose `Cloud`
- On-prem: export `JIRA_API_TOKEN`, run `jira init`, choose `Local`
- Auth types: `basic` (default), `bearer` (PAT via `JIRA_AUTH_TYPE=bearer`), `mtls`
- Multiple Jira configs:
  - `JIRA_CONFIG_FILE=./local_jira_config.yaml jira issue list`
  - `jira issue list -c ./local_jira_config.yaml`

## Main Commands (Current Upstream Usage)

### Board
```bash
jira board list
jira board list -p MEP
```

### Epic
```bash
jira epic list
jira epic list --table
jira epic list -p MEP
jira epic create -n"Epic name" -s"Summary" -yHigh
jira epic add MEP-100 MEP-101 MEP-102
jira epic remove MEP-101 MEP-102
```

### Issue (Core workflow)
```bash
jira issue list
jira issue list --created -7d
jira issue list --plain
jira issue list --raw
jira issue list --csv
jira issue list --order-by rank --reverse
jira issue list -q "project = MEP AND assignee = currentUser()"
jira issue view MEP-123
jira issue create
jira issue create -tStory -s"Add profile page" -yHigh -b"Summary..." --no-input
jira issue create -tSTask -s"Login button not responding" -yHighest -b"Steps..." -lbug --no-input
jira issue create -tTask -s"Task from stdin" --template -
# Create MEP ticket with required custom fields
# Activity Type example: 61914 (Product Innovation / Product enhancements)
jira issue create -tStory -s"New feature" -yHigh -b"Description..." --custom customfield_10501=61935 --custom customfield_24800=61914 --no-input
# If needed, fix missing required fields on an existing issue
jira issue edit MEP-123 --custom customfield_10501=61935 --custom customfield_24800=61914 --no-input
# If custom fields still do not persist, use REST API fallback (see section below)
jira issue edit MEP-123 -s"Updated summary" -yHigh --no-input
jira issue assign MEP-123 $(jira me)
jira issue move MEP-123 "In Progress"
jira issue link MEP-123 MEP-456 Blocks
jira issue clone MEP-123 -s"Follow-up: MEP-123"
jira issue comment add MEP-123 "Work completed. Ready for review."
jira issue worklog add MEP-123 "2h 30m" --comment "Implemented auth flow" --no-input
```

### Project
```bash
jira project list
jira project list -p MEP
```

### Release
```bash
jira release list
jira release list --project MEP
```

### Sprint
```bash
jira sprint list
jira sprint list --table
jira sprint list --current
jira sprint list --next
jira sprint list --state future,active
jira sprint add 1234 MEP-123 MEP-124
```

### Open
```bash
jira open                     # Open current/default project in browser
jira open MEP-123             # Open issue in browser
```

## Common Flags

- `-c, --config string` - Config file (default: `/Users/vaclav.benes/.config/.jira/.config.yml`, can be overridden with `JIRA_CONFIG_FILE` env var)
- `-p, --project string` - Jira project to work with (defaults to project in config)
- `-q, --jql string` - Run raw JQL in project context
- `--plain` - Script-friendly, no interactive UI
- `--raw` - JSON output for automation
- `--csv` - CSV output
- `--no-input` - Skip prompts
- `--debug` - Turn on debug output
- `-h, --help` - Show help for a command

## Other Commands

- `init` - Initialize jira config
- `me` - Display configured jira user
- `serverinfo` - Display information about the Jira instance
- `version` - Print the app version information
- `completion` - Output shell completion code (bash or zsh)
- `man` - Generate man(7) pages for Jira CLI
- `help` - Help about any command

## Best Practices

- Use `--plain` for scripting and piping.
- Use `--raw` or `--csv` when machine-readable output is needed.
- Use `--no-input` for non-interactive runs.
- Use `jira me` for your assignee name in CLI filters.
- Prefer `jira issue list -q "<JQL>"` when Jira UI filters are easier to express in JQL.
- Use `jira issue view KEY --comments 5` when triaging long-running tickets.

## Ticket Validation Checklist (MEP)

When validating a ticket, ensure these fields are present and correct:
For new MEP tickets, set these at creation time using `--custom customfield_10501=61935 --custom customfield_24800=<activity_type_id>`.

- [ ] **Project**: MEP
- [ ] **Issue Type**: Story, STask, Task, Bug, or Epic
- [ ] **Summary**: Clear and descriptive
- [ ] **Priority**: P0-P4 (or appropriate level)
- [ ] **Assignee**: Assigned to a team member
- [ ] **Assigned Team (customfield_10501)**: Mario (id: 61935) for MEP team
- [ ] **Activity Type (customfield_24800)**: One of the defined activity types
- [ ] **Description**: Clear problem statement and requirements
- [ ] **Components**: Relevant components selected (if applicable)
- [ ] **Status**: Appropriate workflow state

## Team and Ticket Defaults (MEP)

**Project:** MEP
**Default team (customfield_10501):** Mario (id: 61935)
**Default assignee:** vaclav.benes

**Issue types:**
- Story (id: 10001) - standard tickets
- STask (id: 11502) - bugs for Mario team (default bug type)
- Task (id: 5) - subtask (requires parent)
- Bug (id: 10702) - defects (alt bug type)
- Epic (id: 10000) - large initiatives

**Activity Type (customfield_24800):**
- Maintenance (id: 51704)
- Product Innovation / Product enhancements (id: 61914)
- Tech Innovation (id: 62606)
- Integration / Migration (id: 51705)
- Other (id: 61915)
- BAU (id: 51708)
- Compliance (id: 51707)
- New Innovation/Feature (id: 51706)

**Priorities:**
- P0 (Blocker)
- P1 (Critical)
- P2 (Major)
- P3 (Minor)
- P4 (Trivial)

## Fallback: Update Custom Fields via Jira REST API

Use this when `jira issue create/edit --custom ...` does not persist `customfield_10501` or `customfield_24800`.

```bash
# Required env vars
export JIRA_BASE_URL="https://your-domain.atlassian.net"
export JIRA_USER_EMAIL="your.name@company.com"
export JIRA_API_TOKEN="***"
export JIRA_API_VERSION=3            # Cloud=3, Data Center/Server usually=2
export ISSUE_KEY="MEP-123"

# Verify current values
curl --silent --show-error \
  --user "$JIRA_USER_EMAIL:$JIRA_API_TOKEN" \
  --header "Accept: application/json" \
  "$JIRA_BASE_URL/rest/api/$JIRA_API_VERSION/issue/$ISSUE_KEY?fields=customfield_10501,customfield_24800"

# Set both required custom fields
curl --silent --show-error --request PUT \
  --user "$JIRA_USER_EMAIL:$JIRA_API_TOKEN" \
  --header "Accept: application/json" \
  --header "Content-Type: application/json" \
  --data '{
    "fields": {
      "customfield_10501": { "id": "61935" },
      "customfield_24800": { "id": "61914" }
    }
  }' \
  "$JIRA_BASE_URL/rest/api/$JIRA_API_VERSION/issue/$ISSUE_KEY"

# Re-verify
curl --silent --show-error \
  --user "$JIRA_USER_EMAIL:$JIRA_API_TOKEN" \
  --header "Accept: application/json" \
  "$JIRA_BASE_URL/rest/api/$JIRA_API_VERSION/issue/$ISSUE_KEY?fields=customfield_10501,customfield_24800"
```

## Navigation Shortcuts (Interactive UI)

- `j/k/h/l` or arrow keys: navigate
- `g`/`G`: top/bottom
- `v`: view selected issue
- `m`: transition selected issue
- `Ctrl+r` or `F5`: refresh
- `Enter`: open issue in browser
- `?`: help, `q`/`Esc`/`Ctrl+c`: quit

## Jira MCP Notes (for Data Center Ops)

Use `jira_*` MCP tools for Data Center automation. When running inside IntelliJ IDEA, prefix tool names with `mcp-jira_`.

Before creating or updating tickets with custom fields:
1. Call `jira_jira_get_fields()` to discover field IDs.
2. Call `jira_jira_get_field_options()` to fetch valid values.

Example create (use valid IDs/values from field discovery):
```typescript
jira_jira_create_ticket({
  project: { key: "MEP" },
  summary: "Implement user authentication",
  issuetype: { name: "Story" },
  assignee: { name: "vaclav.benes" },
  priority: { name: "P2" },
  custom_fields: {
    "customfield_10501": { "id": "61935" },
    "customfield_24800": { "id": "61914" }
  }
})
```

## Resources

- Jira CLI repository: https://github.com/ankitpokhrel/jira-cli
- Installation wiki: https://github.com/ankitpokhrel/jira-cli/wiki/Installation
- FAQs: https://github.com/ankitpokhrel/jira-cli/discussions/categories/faqs
