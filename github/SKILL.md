---
name: github
description: Interact with GitHub using gh CLI for repositories, pull requests, issues, code search, and documentation. Use when working with GitHub operations, searching code, finding repos, or managing PRs and issues.
user-invocable: true
allowed-tools: bash
agent: general
subtask: false
---

# GitHub (gh CLI)

## Quick Start

```bash
gh auth status
gh auth switch
```

Use `gh auth switch` to select the right host:
- `github.com` (vaclavbenes)
- `git-gen.ida.avast.com` (vaclav-benes)
- `git.int.avast.com` (benesv)

## Core Operations

### Repositories
```bash
gh search repos "terraform aws" --limit 20
gh repo view owner/repo
gh repo clone owner/repo
```

### Code Search
```bash
gh search code "OAuth2" --repo owner/repo
gh search code "router.post" --language javascript --limit 20
```

### Pull Requests
```bash
gh pr list --state open --limit 20
gh pr view 123
gh pr diff 123
```

### Issues
```bash
gh issue list --state open --limit 20
gh issue view 456
gh issue create --title "Bug: Login fails" --body "Detailed description"
```

### Documentation
```bash
gh search code "getting started" --filename README.md --limit 10
```

## Best Practices
- Always set `--limit` for searches.
- Prefer `--json` output when scripting.
- Confirm auth with `gh auth status` before querying.

## Extended Guide

For the full command catalog, advanced examples, and workflows, see:
- [Guide](references/guide.md)
*** End Patch}"});
