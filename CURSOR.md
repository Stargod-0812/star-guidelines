# Using Star Guidelines with Cursor

Star Guidelines ships two Cursor-native adapters:

- `.cursor/rules/star-guidelines.mdc` for always-on project behavior.
- `.cursor/skills/star-guidelines/SKILL.md` for Cursor Agent Skill loading.

## In This Repository

Load this repository in Cursor. The rule has `alwaysApply: true`, so Cursor applies it automatically.

To confirm the rule is active, ask:

```text
is star-guidelines active?
```

Expected answer:

```text
star-guidelines active: scope-first, simple-diff, evidence-verified agent rules loaded for Cursor.
```

## In Another Repository

Install the project rule:

```bash
mkdir -p .cursor/rules
STAR_RAW=https://raw.githubusercontent.com/Stargod-0812/star-guidelines/main
curl -fsSL "$STAR_RAW/.cursor/rules/star-guidelines.mdc" -o .cursor/rules/star-guidelines.mdc
```

Install the project skill:

```bash
mkdir -p .cursor/skills/star-guidelines
STAR_RAW=https://raw.githubusercontent.com/Stargod-0812/star-guidelines/main
curl -fsSL "$STAR_RAW/.cursor/skills/star-guidelines/SKILL.md" -o .cursor/skills/star-guidelines/SKILL.md
```

If the target repository already has Cursor rules, merge the operating contract instead of creating conflicting always-on rules.

## Cursor-Specific Behavior

Star Guidelines expects Cursor agents to:

- Treat user rules, workspace rules, and project rules as higher priority than Star Guidelines when they are more specific.
- Use open files and cursor context as clues, then read the owning code before editing.
- Switch to planning when the task is ambiguous, broad, or architectural.
- Keep implementation in Agent mode scoped to the agreed change.
- Verify UI work with screenshots or browser checks when visual behavior matters.
- Report skipped checks and remaining risk in the final answer.

## Keep Adapters in Sync

When you update the core guidance, update these files together:

- `core/CONTRACT.md`
- `AGENTS.md`
- `CLAUDE.md`
- `.cursor/rules/star-guidelines.mdc`
- `.cursor/skills/star-guidelines/SKILL.md`
- `WORKBUDDY.md`
- `skills/star-guidelines/SKILL.md`
- `.claude-plugin/skills/star-guidelines/SKILL.md`
