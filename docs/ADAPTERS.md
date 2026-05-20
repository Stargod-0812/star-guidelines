# Adapter Guide

Different coding agents read different instruction files. Star Guidelines keeps the same core contract in several adapter formats so each tool can load it through its native entry point.

## Codex

Codex reads `AGENTS.md` as repository-level instructions. Use it when you want the rules to apply inside one repository.

For reusable skill loading, copy `skills/star-guidelines/` into your Codex skills directory.

## Claude Code

Claude Code reads `CLAUDE.md` for project-level behavior. The `.claude-plugin/` folder contains plugin metadata and a bundled copy of the skill for plugin-style setups.

## Cursor

Cursor has two first-class entry points:

- `.cursor/rules/star-guidelines.mdc` is an always-on project rule. Use it for baseline behavior in a repository.
- `.cursor/skills/star-guidelines/SKILL.md` is a Cursor project skill. Use it when you want the agent to explicitly load the full Star Guidelines workflow.

The Cursor adapter assumes project rules, user rules, open files, and mode-specific behavior can all influence the session. It tells the agent to honor Cursor context without treating open files as a substitute for reading the owning code.

## WorkBuddy

WorkBuddy is a long-running agent framework built around project context, tasks, memory, and MCP capabilities. Use `WORKBUDDY.md` as a direction document, or merge its content into the project-level instructions that your WorkBuddy setup uses for agent orientation.

## Updating Adapters

When you revise the core rules, update these files in the same change:

- `core/CONTRACT.md`
- `AGENTS.md`
- `CLAUDE.md`
- `.cursor/rules/star-guidelines.mdc`
- `.cursor/skills/star-guidelines/SKILL.md`
- `WORKBUDDY.md`
- `skills/star-guidelines/SKILL.md`
- `.claude-plugin/skills/star-guidelines/SKILL.md`

Before publishing, run:

```bash
scripts/check-repo.sh
```
