<div align="center">

# Star Guidelines

**An operating contract for frontier coding agents.**

One native adapter per IDE. One seven-rule contract underneath. No drift between environments.

[![Stars](https://img.shields.io/github/stars/Stargod-0812/star-guidelines?style=flat-square&logo=github&label=stars&color=111)](https://github.com/Stargod-0812/star-guidelines/stargazers)
[![Last commit](https://img.shields.io/github/last-commit/Stargod-0812/star-guidelines?style=flat-square&color=111)](https://github.com/Stargod-0812/star-guidelines/commits/main)
[![Adapters](https://img.shields.io/badge/adapters-Cursor%20%7C%20Claude%20%7C%20Codex%20%7C%20WorkBuddy-111?style=flat-square)](#the-adapter-router)
[![Contract](https://img.shields.io/badge/contract-7%20rules-111?style=flat-square)](#the-star-contract)
[![Version](https://img.shields.io/badge/version-2.0.0-111?style=flat-square)](./CHANGELOG.md)
[![Lang](https://img.shields.io/badge/简体中文-111?style=flat-square)](./README.zh.md)

</div>

---

> Frontier coding agents do not fail at the model layer. They fail at the operating layer — guessing scope, editing outside the task, ignoring uncommitted work, fabricating completion, and loading the wrong rules per IDE. **Star Guidelines is the contract that closes that gap.**

## Why this exists

Most coding-agent failures look like skill gaps. They are not. They are operating gaps.

- The agent picks an interpretation when the request is ambiguous, instead of asking.
- The agent edits code outside the requested scope because it looks improvable.
- The agent invents abstractions before the repository has earned them.
- The agent overwrites uncommitted user work.
- The agent says "done" without a test, build, screenshot, or reproduction.
- The agent loads `.cursor/rules/` in a Claude project, or `CLAUDE.md` in Cursor, and the two surfaces cancel each other out.

Better models do not fix any of this. A contract does.

## How it is different

| Star Guidelines | Most agent rule kits |
| --- | --- |
| One adapter per IDE, no overlap | One file, hope every IDE reads it |
| Seven rules, single normative source in `core/CONTRACT.md` | Long checklists that drift across files |
| Verifiable handshake (`is star-guidelines active?`) | No way to confirm the rules loaded |
| Curated by one person, on purpose | Committee-edited, lowest-common-denominator |
| Refusal to ship without evidence is a feature | "It looks right" passes for completion |

## Who it is for

Engineers who use coding agents on real codebases and have already been burned by unsolicited edits, fabricated completion, abstractions for one use case, and rules that quietly stopped applying. If you have never paid for one of those mistakes, you do not need this yet.

This is a personal kit, curated aggressively. It is not a starter template.

---

## The adapter router

```text
                    ┌────────────────────────────┐
                    │     core/CONTRACT.md       │   ← normative source
                    │       7 Star rules         │
                    └─────────────┬──────────────┘
                                  │
        ┌──────────────┬──────────┴──────────┬──────────────┐
        │              │                     │              │
     Cursor       Claude Code              Codex        WorkBuddy
     ──────       ───────────              ─────        ─────────
   .cursor/rules   CLAUDE.md             AGENTS.md      WORKBUDDY.md
   .cursor/skills  .claude-plugin/       skills/        (project direction)
```

One environment, one primary adapter. Use the table below as the source of truth for which file gets loaded where.

| Running in | Primary adapter | Optional companion | Agent should say |
| --- | --- | --- | --- |
| Cursor project rules | `.cursor/rules/star-guidelines.mdc` | `.cursor/skills/star-guidelines/SKILL.md` | `Cursor rule loaded` |
| Cursor project skill | `.cursor/skills/star-guidelines/SKILL.md` | `.cursor/rules/star-guidelines.mdc` | `Cursor skill loaded` |
| Codex / AGENTS-aware IDE | `AGENTS.md` | `skills/star-guidelines/SKILL.md` | `AGENTS rules loaded` |
| Codex-style skill runner | `skills/star-guidelines/SKILL.md` | `skills/star-guidelines/agents/openai.yaml` | `skill loaded` |
| Claude Code project | `CLAUDE.md` | none | `Claude project rules loaded` |
| Claude plugin-style setup | `.claude-plugin/` | none | `bundled skill loaded` |
| WorkBuddy long task | `WORKBUDDY.md` | project task context | `WorkBuddy direction loaded` |
| New adapter work | `core/CONTRACT.md` | existing adapter examples | `contract source loaded` |

Do not install every adapter into one project. Each file is written for a specific loader. If your project already has rules, merge the matching adapter into the existing rule surface — do not stack them.

## Quick install

### Cursor

```bash
STAR_RAW=https://raw.githubusercontent.com/Stargod-0812/star-guidelines/main
mkdir -p .cursor/rules
curl -fsSL "$STAR_RAW/.cursor/rules/star-guidelines.mdc" \
  -o .cursor/rules/star-guidelines.mdc
```

For a fuller Cursor project skill alongside the always-on rule:

```bash
STAR_RAW=https://raw.githubusercontent.com/Stargod-0812/star-guidelines/main
mkdir -p .cursor/skills/star-guidelines
curl -fsSL "$STAR_RAW/.cursor/skills/star-guidelines/SKILL.md" \
  -o .cursor/skills/star-guidelines/SKILL.md
```

### Claude Code

```bash
STAR_RAW=https://raw.githubusercontent.com/Stargod-0812/star-guidelines/main
curl -fsSL "$STAR_RAW/CLAUDE.md" \
  -o CLAUDE.star-guidelines.md
```

Merge `CLAUDE.star-guidelines.md` into the project's `CLAUDE.md`. For plugin-style setups, bundle the package instead:

```bash
git clone https://github.com/Stargod-0812/star-guidelines.git
cp -R star-guidelines/.claude-plugin /path/to/your/claude-plugin-location/star-guidelines
```

### Codex

```bash
STAR_RAW=https://raw.githubusercontent.com/Stargod-0812/star-guidelines/main
curl -fsSL "$STAR_RAW/AGENTS.md" \
  -o AGENTS.star-guidelines.md
```

Merge into the existing `AGENTS.md`. For the reusable skill:

```bash
git clone https://github.com/Stargod-0812/star-guidelines.git
mkdir -p ~/.codex/skills
cp -R star-guidelines/skills/star-guidelines ~/.codex/skills/
```

### WorkBuddy

```bash
STAR_RAW=https://raw.githubusercontent.com/Stargod-0812/star-guidelines/main
curl -fsSL "$STAR_RAW/WORKBUDDY.md" \
  -o WORKBUDDY.star-guidelines.md
```

Merge into your WorkBuddy project-level direction area. Use it for long-running work, memory-aware flows, MCP-heavy tasks, and cross-session handoffs.

## Agent handshake

After installation, ask:

```text
is star-guidelines active?
```

| IDE | Expected answer mentions |
| --- | --- |
| Cursor | Cursor rules or Cursor skill |
| Codex | `AGENTS.md` or `$star-guidelines` |
| Claude Code | the seven-rule operating contract |
| WorkBuddy | project boundary, memory/context check, consent, evidence, durable handoff |

If the answer names the wrong adapter, remove the extra rule surface and keep only the adapter for the running IDE.

---

## The Star Contract

The seven rules every adapter carries. Source of truth: [`core/CONTRACT.md`](./core/CONTRACT.md). The other adapter files are projections of this file into each IDE's native loader.

1. **Clarify before editing.** State assumptions that affect implementation. Ask when ambiguity changes files, APIs, data, safety, or user-visible behavior.
2. **Read before designing.** Inspect existing code, tests, scripts, docs, and local conventions before choosing an implementation.
3. **Keep the change narrow.** Touch only files needed for the request. No unsolicited refactors. No broad formatting changes.
4. **Prefer the current simple solution.** Add abstraction only when the repository already has real repeated use, or an established pattern requires it.
5. **Preserve user work.** Treat uncommitted changes as user-owned unless you made them. Never overwrite or revert without explicit instruction.
6. **Verify with concrete evidence.** Run the smallest useful test, build, lint, screenshot, log check, or manual reproduction. Report what passed and what could not be run.
7. **Explain tradeoffs briefly.** Name meaningful risks, simpler alternatives, and unresolved questions. Do not turn routine work into ceremony.

The contract scales with risk. A one-line typo fix stays light. A cross-module refactor earns a plan and evidence.

## What good looks like

```text
Orient   →   read the owning files, tests, scripts, docs, and local conventions
Scope    →   state only the assumptions that can change the implementation
Edit     →   touch the smallest set of files that satisfy the request
Verify   →   run the smallest useful check and report exact evidence
Report   →   say what changed, what passed, what was skipped, what risk remains
```

Five steps. No ceremony. Each step has a verification check attached.

## Before and after

Two scenes from [`EXAMPLES.md`](./EXAMPLES.md). Many more there.

**Bug fix — missing due date crashes reminders.**

A weak agent turns one null path into notification policy, trial handling, and fallback scheduling. A Star agent keeps the behavior change to the crash boundary:

```diff
- reminder_at = customer["due_date"] - timedelta(days=3)
+ due_date = customer.get("due_date")
+ if due_date is None:
+     return None
+ reminder_at = due_date - timedelta(days=3)
```

**Completion report — feature done.**

A weak agent says "Done."

A Star agent says: "Changed `src/webhooks/retry.ts` and `src/webhooks/retry.test.ts`. Verified with `npm test -- webhooks/retry.test.ts`. I did not run the full suite. Remaining risk: provider-specific retry throttling was not covered."

The user can see the changed surface, the evidence, and the untested edge. That is the bar.

---

## Repository map

```text
star-guidelines/
├── core/
│   └── CONTRACT.md                            # normative source (the 7 rules)
├── AGENTS.md                                  # Codex / AGENTS-aware IDEs
├── CLAUDE.md                                  # Claude Code project rules
├── CURSOR.md                                  # Cursor usage guide
├── WORKBUDDY.md                               # long-running agent direction
├── .cursor/
│   ├── rules/star-guidelines.mdc              # Cursor always-on rule
│   └── skills/star-guidelines/SKILL.md        # Cursor project skill
├── skills/star-guidelines/
│   ├── SKILL.md                               # reusable Markdown skill
│   └── agents/openai.yaml                     # skill-aware runner metadata
├── .claude-plugin/                            # Claude plugin-style package
├── docs/
│   ├── ADAPTERS.md                            # adapter guide
│   └── INSTALL.md                             # short install guide
├── EXAMPLES.md                                # good and bad agent behavior
├── CHANGELOG.md                               # versioned changes
└── scripts/check-repo.sh                      # consistency + history checks
```

## Design principles

- **One loader, one adapter.** No IDE should need to guess which file matters.
- **Local code beats generic advice.** The agent must read the repository before shaping a change.
- **Small diffs are a feature.** Unrelated cleanup belongs in a follow-up, not in a hidden side quest.
- **Verification is part of the work.** A completion report without evidence is not complete.
- **User work is sacred.** Existing uncommitted changes are not disposable context.
- **The contract is normative.** When an adapter and `core/CONTRACT.md` disagree, the contract wins.

## Maintenance

When changing the contract, update every adapter in the same change:

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

The script enforces file presence, contract-term coverage in every adapter, `origin/main` alignment, and `Stargod-0812` authorship across reachable refs. See [CHANGELOG.md](./CHANGELOG.md) for version history.

## License

Star Guidelines is **source-available, permission-required**. You are free to read the kit and reference it in your own work with attribution. Redistributing it, bundling it into a product, building a competing rule kit on top of it, or training a model against it requires written permission from the author. See [`LICENSE`](./LICENSE).

---

<div align="center">

Built and curated by **[Star](https://github.com/Stargod-0812)** · v2.0.0 · Personal kit, used in production

</div>
