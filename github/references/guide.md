# GitHub Operations via gh CLI

Interact with GitHub using the powerful `gh` CLI tool. This command provides flexible operations for searching, managing, and working with GitHub repositories, pull requests, issues, and code.

## Custom Commands

This file serves as both documentation and a custom command configuration. You can invoke GitHub operations by typing `/github` in the OpenCode TUI.

**Command Usage:**
```
/github                    # General GitHub operations
/github $ARGUMENTS         # Pass specific instructions as arguments
```

**Examples:**
```
/github find repository for terraform aws
/github search for authentication code in my org
/github show me open pull requests assigned to me
/github find issues labeled bug in my repo
/github search for api documentation
```

### Command Configuration

This command uses the following configuration:
- **Agent**: `general` - Uses the general-purpose agent for GitHub operations
- **Subtask**: `false` - Runs in the primary context, not as a subagent
- **Allowed Tools**: `bash` - Uses gh CLI commands via bash

## Overview

This command leverages the GitHub CLI (`gh`) to perform various GitHub operations:

1. **Repository Search** - Find repositories by name, topic, language, stars, etc.
2. **Code Search** - Search for code across GitHub repositories
3. **Pull Request Management** - List, view, search, and manage pull requests
4. **Issue Tracking** - Find and manage issues across repositories
5. **Documentation** - Access repository documentation and READMEs
6. **User & Organization** - Find users, organizations, and team information

## Core Operations

### 1. Repository Operations

#### Search for Repositories

```bash
# Search by name and description
gh search repos "terraform aws" --limit 20

# Search by language
gh search repos "machine learning" --language python --limit 10

# Search by stars and popularity
gh search repos "web framework" --sort stars --order desc --limit 10

# Search by topic
gh search repos "topic:kubernetes topic:devops" --limit 15

# Search in specific organization
gh search repos "mobile" --owner avast --limit 10

# Combined search with filters
gh search repos "api client" --language go --stars ">1000" --limit 10
```

#### Get Repository Information

```bash
# View repository details
gh repo view owner/repo

# View README
gh repo view owner/repo --web

# Clone repository
gh repo clone owner/repo

# Fork repository
gh repo fork owner/repo

# List your repositories
gh repo list
gh repo list --limit 50

# List organization repositories
gh repo list avast --limit 30
```

---

### 2. Code Search

#### Search for Code

```bash
# Search for code across GitHub
gh search code "function authenticate" --language javascript --limit 20

# Search in specific repository
gh search code "OAuth2" --repo owner/repo

# Search by file extension
gh search code "api_key" --extension .env --limit 10

# Search in organization
gh search code "database connection" --owner avast --limit 15

# Search by path
gh search code "Config" --path "src/config" --limit 10

# Complex code search with filters
gh search code "import React" --language typescript --filename "*.tsx" --limit 20

# Search for symbols
gh search code "class UserService" --language java --limit 10
```

#### Search Examples by Use Case

```bash
# Find authentication implementations
gh search code "passport.authenticate" --language javascript

# Find API endpoints
gh search code "router.post" --language javascript

# Find configuration files
gh search code "database" --filename config.json

# Find security vulnerabilities
gh search code "password = " --language python

# Find specific function usage
gh search code "useEffect" --language typescript --filename "*.tsx"
```

---

### 3. Pull Request Operations

#### List Pull Requests

```bash
# List open pull requests in current repo
gh pr list

# List your pull requests across all repos
gh pr list --author @me --limit 20

# List PRs assigned to you
gh pr list --assignee @me

# List PRs by state
gh pr list --state open --limit 30
gh pr list --state closed --limit 10
gh pr list --state merged --limit 10
gh pr list --state all --limit 50

# List PRs with specific label
gh pr list --label "bug" --limit 10
gh pr list --label "enhancement" --limit 10

# List PRs for specific base branch
gh pr list --base main --limit 20

# List PRs in specific repository
gh pr list --repo owner/repo --limit 20
```

#### Search Pull Requests

```bash
# Search open PRs across GitHub
gh search prs "authentication" --state open --limit 10

# Search PRs by author
gh search prs --author username --limit 20

# Search PRs in organization
gh search prs "refactor" --owner avast --state open

# Search PRs by label
gh search prs "label:bug" --state open --limit 15

# Search merged PRs
gh search prs "feature" --merged --limit 10

# Complex PR search
gh search prs "api" --author @me --state merged --sort updated
```

#### View Pull Request Details

```bash
# View PR details
gh pr view 123

# View PR in browser
gh pr view 123 --web

# View PR diff
gh pr diff 123

# View PR checks and status
gh pr checks 123

# View PR comments
gh pr view 123 --comments

# View PR in specific repository
gh pr view 123 --repo owner/repo
```

#### Create Pull Request

```bash
# Create PR interactively
gh pr create

# Create PR with title and body
gh pr create --title "Add authentication" --body "Implements OAuth2 flow"

# Create PR with base and head branches
gh pr create --base main --head feature-branch

# Create draft PR
gh pr create --draft --title "WIP: New feature"

# Create PR with reviewers and assignees
gh pr create --reviewer user1,user2 --assignee @me

# Create PR with labels
gh pr create --label bug,urgent
```

---

### 4. Issue Operations

#### List Issues

```bash
# List open issues in current repo
gh issue list

# List your issues
gh issue list --author @me --limit 20

# List assigned issues
gh issue list --assignee @me

# List issues by label
gh issue list --label bug --limit 15
gh issue list --label "good first issue" --limit 10

# List issues by state
gh issue list --state open --limit 30
gh issue list --state closed --limit 10
gh issue list --state all --limit 50

# List issues in specific repository
gh issue list --repo owner/repo --limit 20
```

#### Search Issues

```bash
# Search issues across GitHub
gh search issues "authentication error" --limit 20

# Search issues in organization
gh search issues "bug" --owner avast --limit 15

# Search open issues
gh search issues "crash" --state open --limit 10

# Search issues by label
gh search issues "label:bug label:critical" --limit 10

# Search issues by author
gh search issues --author username --limit 20

# Search issues with comments
gh search issues "memory leak" --comments ">10" --limit 10

# Complex issue search
gh search issues "api" --state open --sort comments --order desc
```

#### View Issue Details

```bash
# View issue details
gh issue view 456

# View issue in browser
gh issue view 456 --web

# View issue comments
gh issue view 456 --comments

# View issue in specific repository
gh issue view 456 --repo owner/repo
```

#### Create Issue

```bash
# Create issue interactively
gh issue create

# Create issue with title and body
gh issue create --title "Bug: Login fails" --body "Detailed description"

# Create issue with labels
gh issue create --title "Feature request" --label enhancement

# Create issue with assignees
gh issue create --title "Task" --assignee user1,user2
```

---

### 5. Documentation & README Operations

#### View Repository Documentation

```bash
# View README
gh repo view owner/repo

# View README in browser
gh repo view owner/repo --web

# Search for documentation
gh search repos "documentation" --topic documentation --limit 10

# Search README content (via code search)
gh search code "installation" --filename README.md --limit 20
gh search code "getting started" --filename "*.md" --limit 15
```

#### Search Documentation Files

```bash
# Find markdown documentation
gh search code "api reference" --extension .md --limit 20

# Find wiki pages
gh search code "configuration" --filename "*.wiki" --limit 10

# Find documentation by path
gh search code "setup" --path docs/ --limit 15

# Search across documentation in org
gh search code "deployment guide" --owner avast --extension .md
```

---

### 6. User & Organization Operations

#### User Information

```bash
# View user profile
gh api users/username

# View authenticated user
gh api user

# Search users
gh api search/users -f q="location:prague"

# List user repositories
gh repo list username --limit 30

# View user's pull requests
gh search prs --author username --limit 20
```

#### Organization Information

```bash
# List organization repositories
gh repo list avast --limit 50

# Search in organization
gh search repos --owner avast --limit 30

# List organization members (requires permissions)
gh api orgs/avast/members

# View organization details
gh api orgs/avast
```

---

## Advanced Search Queries

### Repository Search Syntax

```bash
# By stars
gh search repos "react" --stars ">10000"
gh search repos "vue" --stars "1000..5000"

# By language
gh search repos "framework" --language javascript

# By topic
gh search repos "topic:docker topic:kubernetes"

# By size
gh search repos "game engine" --size ">10000"  # Size in KB

# By license
gh search repos "library" --license mit

# By date
gh search repos "created:>2024-01-01"
gh search repos "pushed:>2024-03-01"

# By fork count
gh search repos "forks:>500"

# Archived repositories
gh search repos "archived:true"
gh search repos "archived:false"

# Combined filters
gh search repos "web framework" --language rust --stars ">1000" --sort stars
```

### Code Search Syntax

```bash
# By language
gh search code "async function" --language typescript

# By extension
gh search code "import" --extension .tsx

# By filename
gh search code "test" --filename "*test.js"

# By path
gh search code "component" --path "src/components/"

# By repository
gh search code "api" --repo owner/repo

# By organization/user
gh search code "config" --owner avast

# By size
gh search code "function" --size ">1000"  # File size in bytes

# Combined filters
gh search code "authentication" --language go --filename "auth*.go"
```

### Issue & PR Search Syntax

```bash
# By state
gh search issues "state:open"
gh search prs "state:merged"

# By label
gh search issues "label:bug label:critical"

# By author
gh search issues "author:username"
gh search prs "author:@me"

# By assignee
gh search issues "assignee:username"

# By mentions
gh search issues "mentions:username"

# By comments
gh search issues "comments:>10"

# By date
gh search issues "created:>2024-03-01"
gh search prs "merged:>2024-02-01"

# By reactions
gh search issues "reactions:>10"

# By interactions
gh search issues "interactions:>50"

# By milestone
gh search issues "milestone:v1.0"

# By project
gh search issues "project:project-name"

# In repository/organization
gh search issues "repo:owner/repo"
gh search issues "org:avast"

# Combined filters
gh search prs "label:bug state:open author:@me sort:updated"
```

---

## Output Formats

### JSON Output

```bash
# Get structured JSON output for scripting
gh repo view owner/repo --json name,description,stargazerCount
gh pr list --json number,title,author,state
gh issue list --json number,title,labels,assignees

# Use jq for parsing
gh pr list --json number,title,author | jq '.[].title'
```

### Custom Formatting

```bash
# Use templates for custom output
gh pr list --template '{{range .}}{{.number}} - {{.title}}{{"\n"}}{{end}}'

# Limit fields in output
gh repo list --limit 10 --json name,description
```

---

## Common Workflows

### Workflow 1: Find and Clone Repository

```bash
# 1. Search for repository
gh search repos "terraform aws modules" --stars ">1000" --limit 10

# 2. View repository details
gh repo view terraform-aws-modules/terraform-aws-vpc

# 3. Clone repository
gh repo clone terraform-aws-modules/terraform-aws-vpc
```

### Workflow 2: Search Code and Create Issue

```bash
# 1. Search for code with potential issue
gh search code "TODO: fix this" --repo owner/repo

# 2. View the file context
gh api repos/owner/repo/contents/path/to/file.js

# 3. Create issue
gh issue create --repo owner/repo --title "Fix TODO items" --label tech-debt
```

### Workflow 3: Find and Review Pull Requests

```bash
# 1. List open PRs assigned to you
gh pr list --assignee @me --state open

# 2. View PR details and diff
gh pr view 123
gh pr diff 123

# 3. Check PR status
gh pr checks 123

# 4. Review PR (open in browser)
gh pr view 123 --web
```

### Workflow 4: Research Implementation Patterns

```bash
# 1. Search for implementation examples
gh search code "useAuth hook" --language typescript --limit 20

# 2. Find repositories with good examples
gh search repos "react authentication" --stars ">500" --limit 10

# 3. View specific implementation
gh api repos/owner/repo/contents/src/hooks/useAuth.ts

# 4. Clone repository for deeper analysis
gh repo clone owner/repo
```

### Workflow 5: Monitor Organization Activity

```bash
# 1. List recent PRs in organization
gh search prs --owner avast --sort updated --limit 20

# 2. List open issues across org
gh search issues --owner avast --state open --limit 30

# 3. Find repositories with recent activity
gh search repos "owner:avast pushed:>2024-03-01" --limit 15

# 4. Check specific repository
gh repo view avast/repo-name
```

---

## Creating Custom GitHub Commands

You can create specialized GitHub commands as separate markdown files in `.opencode/commands/` directory.

### Example: Find React Components

Create `.opencode/commands/gh-react.md`:

```markdown
---
name: gh-react
description: Search for React component examples
agent: general
subtask: true
---

Search GitHub for React component examples: $ARGUMENTS

Steps:
1. Search code for component implementations
2. Find repositories with high-quality examples
3. Show top 5 results with descriptions
4. Provide links to view full implementations

Use these search criteria:
- Language: TypeScript or JavaScript
- File extension: .tsx or .jsx
- Star count: >100
- Sort by: stars
```

**Usage:** `/gh-react "authentication form component"`

### Example: Find API Documentation

Create `.opencode/commands/gh-docs.md`:

```markdown
---
name: gh-docs
description: Find API documentation for libraries
agent: general
subtask: true
---

Find documentation for: $ARGUMENTS

Search for:
1. Official repository README
2. Documentation files in docs/ folder
3. API reference in markdown files
4. Examples and tutorials

Focus on:
- Getting started guides
- API reference documentation
- Configuration examples
- Common use cases

Present results in an organized format with links.
```

**Usage:** `/gh-docs "stripe api"`

### Example: Monitor Pull Requests

Create `.opencode/commands/gh-pr-watch.md`:

```markdown
---
name: gh-pr-watch
description: Monitor pull requests across repositories
agent: general
subtask: true
---

Monitor pull requests with criteria: $ARGUMENTS

Default monitoring:
- State: open
- Assigned to: @me OR authored by: @me
- Sort by: updated (most recent first)
- Include: title, status, checks, reviewers

Show summary:
- Total open PRs
- PRs awaiting review
- PRs with failing checks
- PRs ready to merge

Format as a dashboard view.
```

**Usage:** `/gh-pr-watch` or `/gh-pr-watch "in:avast organization"`

### Example: Search for Security Issues

Create `.opencode/commands/gh-security.md`:

```markdown
---
name: gh-security
description: Search for potential security issues in code
agent: general
subtask: true
---

Search for potential security issues: ${ARGUMENTS:-"common vulnerabilities"}

Search patterns:
- Hardcoded credentials
- SQL injection risks
- XSS vulnerabilities
- Insecure dependencies
- API keys in code
- Unsafe cryptography

Scope: ${SCOPE:-"current repository"}

Report findings with:
- File location
- Line numbers
- Severity assessment
- Remediation suggestions
```

**Usage:** `/gh-security "hardcoded api keys"`

---

## gh CLI Command Reference

### Repository Commands

| Command | Description |
|---------|-------------|
| `gh repo list` | List repositories |
| `gh repo view` | View repository details |
| `gh repo clone` | Clone repository |
| `gh repo fork` | Fork repository |
| `gh repo create` | Create new repository |
| `gh search repos` | Search repositories |

### Pull Request Commands

| Command | Description |
|---------|-------------|
| `gh pr list` | List pull requests |
| `gh pr view` | View PR details |
| `gh pr create` | Create new PR |
| `gh pr diff` | View PR diff |
| `gh pr checks` | View PR checks |
| `gh pr review` | Review PR |
| `gh pr merge` | Merge PR |
| `gh search prs` | Search pull requests |

### Issue Commands

| Command | Description |
|---------|-------------|
| `gh issue list` | List issues |
| `gh issue view` | View issue details |
| `gh issue create` | Create new issue |
| `gh issue close` | Close issue |
| `gh issue reopen` | Reopen issue |
| `gh search issues` | Search issues |

### Code Search Commands

| Command | Description |
|---------|-------------|
| `gh search code` | Search code across GitHub |
| `gh api repos/owner/repo/contents/path` | Get file contents |

### User & Organization Commands

| Command | Description |
|---------|-------------|
| `gh api user` | Get authenticated user |
| `gh api users/username` | Get user info |
| `gh api orgs/orgname` | Get organization info |
| `gh repo list username` | List user repositories |

---

## Best Practices

### 1. Use Appropriate Limits

Always use `--limit` to control result count:
```bash
gh search repos "query" --limit 20  # Good
gh search repos "query"             # May return too many results
```

### 2. Sort and Filter Results

Use sorting and filtering for better results:
```bash
gh search repos "framework" --sort stars --order desc --limit 10
gh pr list --state open --sort updated
```

### 3. Use JSON for Scripting

When building automation, use JSON output:
```bash
gh repo list --json name,url --limit 50
gh pr list --json number,title,state
```

### 4. Combine with Other Tools

Pipe gh output to other tools:
```bash
gh pr list --json number,title | jq '.[].title'
gh search repos "terraform" --limit 20 | grep -i "aws"
```

### 5. Check Authentication

Ensure you're authenticated:
```bash
gh auth status
gh auth login  # If needed
```

### 6. Use Organization Scope

When working with organizations:
```bash
gh search repos --owner avast --limit 30
gh search prs --owner avast --state open
```

### 7. Search Code Efficiently

Use specific filters for code search:
```bash
# Good - specific
gh search code "authenticate" --language go --filename "auth*.go"

# Less specific
gh search code "authenticate"
```

---

## Common Search Patterns

### Finding Examples

```bash
# React hooks
gh search code "useState useEffect" --language typescript --filename "*.tsx"

# REST API implementations
gh search code "router.get router.post" --language javascript

# Configuration patterns
gh search code "config" --filename "config.json" --limit 20

# Testing patterns
gh search code "describe it expect" --filename "*test.js"
```

### Finding Documentation

```bash
# Installation guides
gh search code "installation" --filename README.md

# API documentation
gh search code "api reference" --path docs/ --extension .md

# Tutorials
gh search code "tutorial getting started" --extension .md
```

### Finding Issues and Solutions

```bash
# Known bugs
gh search issues "label:bug state:closed" --limit 20

# Feature requests
gh search issues "label:enhancement state:open"

# Common problems
gh search issues "error" --comments ">10" --limit 15
```

### Monitoring Activity

```bash
# Recent PRs
gh search prs "updated:>2024-03-01" --sort updated --limit 20

# Active repositories
gh search repos "pushed:>2024-03-01" --sort updated

# Trending projects
gh search repos "created:>2024-01-01" --sort stars
```

---

## Troubleshooting

### Authentication Issues

```bash
# Check auth status
gh auth status

# Login if needed
gh auth login

# Use different authentication method
gh auth login --with-token < token.txt
```

### API Rate Limits

```bash
# Check rate limit status
gh api rate_limit

# Use authenticated requests to increase limits
gh auth login
```

### Search Result Limits

GitHub search has these limits:
- Maximum 1000 results per search
- Rate limit: 30 requests per minute (authenticated)
- Use pagination for large result sets

### Empty Results

If search returns no results:
1. Check query syntax
2. Try broader search terms
3. Remove restrictive filters
4. Verify repository/org access permissions

---

## Integration with Other Tools

### Combine with git

```bash
# Find similar repositories and clone
gh search repos "terraform aws" --limit 5
gh repo clone owner/repo

# Create PR after pushing
git push origin feature-branch
gh pr create --fill
```

### Combine with jq

```bash
# Parse JSON output
gh pr list --json number,title,state | jq '.[] | select(.state=="OPEN")'

# Filter and format
gh repo list --json name,stars --limit 50 | jq 'sort_by(.stars) | reverse'
```

### Combine with grep/awk

```bash
# Filter text output
gh repo list --limit 100 | grep "mobile"
gh pr list | awk '{print $1, $2}'
```

---

## Examples

### Example 1: Research Authentication Implementation

```bash
# 1. Find popular authentication libraries
gh search repos "authentication library" --language javascript --stars ">1000" --limit 10

# 2. Search for OAuth2 implementation examples
gh search code "passport.use(new OAuth2Strategy" --language javascript --limit 20

# 3. Find related issues and solutions
gh search issues "oauth2 authentication" --state closed --comments ">5" --limit 10

# 4. View specific implementation
gh api repos/jaredhanson/passport/contents/lib/strategies/oauth2.js
```

### Example 2: Monitor Team's Pull Requests

```bash
# 1. List all open PRs in organization
gh search prs --owner avast --state open --sort updated --limit 30

# 2. Check PRs assigned to you
gh pr list --assignee @me --state open

# 3. View PR status
gh pr checks 123

# 4. View PR details
gh pr view 123 --comments
```

### Example 3: Find and Analyze Terraform Modules

```bash
# 1. Search for terraform AWS modules
gh search repos "terraform aws" --topic terraform --stars ">500" --limit 10

# 2. View repository
gh repo view terraform-aws-modules/terraform-aws-vpc

# 3. Search for specific resource usage
gh search code "aws_vpc" --repo terraform-aws-modules/terraform-aws-vpc

# 4. Clone for detailed analysis
gh repo clone terraform-aws-modules/terraform-aws-vpc
```

### Example 4: Track Security Vulnerabilities

```bash
# 1. Search for security-related issues
gh search issues "label:security vulnerability" --state open --limit 20

# 2. Find security patches in code
gh search code "security fix" --language go --limit 15

# 3. Check for CVE references
gh search issues "CVE-2024" --state all --limit 10

# 4. View security advisories
gh api repos/owner/repo/security-advisories
```

### Example 5: Discover Documentation

```bash
# 1. Find documentation repositories
gh search repos "documentation" --topic documentation --limit 15

# 2. Search for API documentation
gh search code "api reference" --path docs/ --extension .md --limit 20

# 3. Find README files with specific content
gh search code "getting started" --filename README.md --limit 10

# 4. View repository docs
gh repo view owner/repo
```

---

## Tips & Tricks

### 1. Use Aliases

Create gh aliases for common operations:
```bash
gh alias set prs 'pr list --author @me --state open'
gh alias set my-repos 'repo list --limit 50'
```

### 2. Save Complex Searches

Create shell aliases for complex searches:
```bash
alias gh-find-react='gh search code --language typescript --extension .tsx --limit 20'
alias gh-my-prs='gh pr list --author @me --state all --limit 30'
```

### 3. Use Output Formatting

Format output for readability:
```bash
gh pr list --json number,title,author --template '{{range .}}#{{.number}} - {{.title}} by @{{.author.login}}{{"\n"}}{{end}}'
```

### 4. Search Multiple Repositories

Use loops to search across multiple repos:
```bash
for repo in repo1 repo2 repo3; do
  echo "Searching $repo"
  gh search code "function" --repo "owner/$repo" --limit 5
done
```

### 5. Combine Search Types

Search across multiple types for comprehensive results:
```bash
# Search repositories
gh search repos "authentication" --limit 5

# Search code
gh search code "authentication" --limit 10

# Search issues
gh search issues "authentication" --limit 5
```

---

## Command Configuration Tips

### Frontmatter Options

```yaml
name: command-name          # Command name (required)
description: Short desc     # For TUI autocomplete
agent: general              # Agent type
subtask: false              # Run as subagent?
allowed-tools: bash         # Restrict to specific tools
```

### Variable Placeholders

- `$ARGUMENTS` - All arguments passed to command
- `$1`, `$2`, `$3` - Individual positional arguments
- `${VAR:-default}` - Argument with default value
- `!`command`` - Execute and inject shell output

---

## Summary

The `/github` command provides a powerful, flexible interface to GitHub using `gh` CLI:

- **Repository Search** - Find repos by stars, language, topics, and more
- **Code Search** - Search code across GitHub with filters
- **Pull Requests** - List, view, search, and manage PRs
- **Issues** - Track and search issues across projects
- **Documentation** - Find and view documentation
- **Extensible** - Create custom commands for specific workflows

All operations use the standard GitHub CLI (`gh`) under the hood, providing:
- Consistent authentication
- JSON output for scripting
- Rich filtering and sorting
- Integration with other tools

---

## Additional Resources

- **GitHub CLI Documentation**: https://cli.github.com/manual/
- **GitHub Search Syntax**: https://docs.github.com/en/search-github/searching-on-github
- **gh Command Reference**: `gh help` or `gh <command> --help`
