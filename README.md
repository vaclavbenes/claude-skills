# Coding Agent Skills

A collection of skills for AI coding agents (such as [Claude Code](https://claude.ai/code) and Antigravity AI) that extend their capabilities with specialized tools and workflows.

## Skills

| Skill | Description |
|-------|-------------|
| [confluence](confluence/SKILL.md) | Read, search, create, and manage Confluence pages via confluence-cli |
| [github](github/SKILL.md) | Interact with GitHub repositories, PRs, issues, and code search using gh CLI |
| [grill-me](grill-me/SKILL.md) | Interview-style stress-testing of plans and designs |
| [jira-cli](jira-cli/SKILL.md) | Core Jira ticket workflows — search, create, edit, transitions, sprints |
| [teamcity-cli](teamcity-cli/SKILL.md) | Work with TeamCity CI/CD builds, logs, queues, and pipelines |
| [weasyprint](weasyprint/SKILL.md) | Convert HTML to PDF and clone PDFs as editable HTML using WeasyPrint |

## Installation

You can install all the skills to your agent's configuration directory automatically using the provided installation script:

```bash
./install.sh
```

The script will automatically detect local installations of supported agents:
- **Claude Code**: Installs to `~/.claude/skills`
- **Antigravity AI**: Installs to `~/.gemini/config/skills`

And copy the skills into the respective directories.

### Options
- `--claude`: Force installation for Claude Code only.
- `--antigravity` / `--gemini`: Force installation for Antigravity AI only.
- `--both`: Force installation for both.
- `-h`, `--help`: Show the help message.

## Usage

Skills are loaded by compatible AI coding agents via the `Skill` tool.
