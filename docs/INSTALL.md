# Install Guide

These install commands are permitted for private or internal project use. Public redistribution, marketplace bundling, or committing copied adapters into a public project requires written permission; see [`../LICENSE`](../LICENSE).

## Codex Project Install

```bash
STAR_RAW=https://raw.githubusercontent.com/Stargod-0812/star-guidelines/main
curl -fsSL "$STAR_RAW/AGENTS.md" -o AGENTS.star-guidelines.md
```

Merge `AGENTS.star-guidelines.md` into `AGENTS.md`. Do not overwrite existing project rules.

## Codex Skill Install

From this repository:

```bash
mkdir -p ~/.codex/skills
cp -R skills/star-guidelines ~/.codex/skills/
```

## Claude Code Project Install

```bash
STAR_RAW=https://raw.githubusercontent.com/Stargod-0812/star-guidelines/main
curl -fsSL "$STAR_RAW/CLAUDE.md" -o CLAUDE.star-guidelines.md
```

Merge `CLAUDE.star-guidelines.md` into `CLAUDE.md`.

## Cursor Rule Install

```bash
mkdir -p .cursor/rules
STAR_RAW=https://raw.githubusercontent.com/Stargod-0812/star-guidelines/main
curl -fsSL "$STAR_RAW/.cursor/rules/star-guidelines.mdc" -o .cursor/rules/star-guidelines.mdc
```

## Cursor Skill Install

```bash
mkdir -p .cursor/skills/star-guidelines
STAR_RAW=https://raw.githubusercontent.com/Stargod-0812/star-guidelines/main
curl -fsSL "$STAR_RAW/.cursor/skills/star-guidelines/SKILL.md" -o .cursor/skills/star-guidelines/SKILL.md
```

## WorkBuddy Install

Add `WORKBUDDY.md` to the place where your WorkBuddy setup keeps agent-facing directions, or merge it into the project-level instructions used by WorkBuddy.

After installing, ask:

```text
is star-guidelines active?
```

The response should mention `WorkBuddy direction loaded`. If your WorkBuddy setup has no fixed project direction path, treat the merge location as environment-specific and keep the `WORKBUDDY.md` heading and handshake text intact.
