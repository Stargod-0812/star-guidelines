<div align="center">

# Star Guidelines

**The execution-layer operating system for coding agents.**

Seven non-negotiable rules. One native adapter per IDE. Zero drift across Cursor / Claude Code / Codex / WorkBuddy.

[![Stars](https://img.shields.io/github/stars/Stargod-0812/star-guidelines?style=flat-square&logo=github&label=stars&color=111)](https://github.com/Stargod-0812/star-guidelines/stargazers)
[![Last commit](https://img.shields.io/github/last-commit/Stargod-0812/star-guidelines?style=flat-square&color=111)](https://github.com/Stargod-0812/star-guidelines/commits/main)
[![Adapters](https://img.shields.io/badge/adapters-Cursor%20%7C%20Claude%20%7C%20Codex%20%7C%20WorkBuddy-111?style=flat-square)](#adapter-architecture)
[![Contract](https://img.shields.io/badge/contract-7%20rules-111?style=flat-square)](#the-star-contract)
[![Version](https://img.shields.io/badge/v2.0.0-111?style=flat-square)](./CHANGELOG.md)
[![简体中文](https://img.shields.io/badge/简体中文-111?style=flat-square)](./README.zh.md)

</div>

---

> **TL;DR** — Frontier coding agents don't fail at intelligence. They fail at execution discipline. Star Guidelines is an installable, verifiable, cross-IDE execution contract — install it, ask one question, confirm it's active.

---

## Why this exists

Six systemic failure modes of coding agents. None of them are model capability problems:

| Failure mode | Root cause | Real cost |
| --- | --- | --- |
| Picks a direction when the request is ambiguous | Missing clarification gate | Rollback cost ×2, trust erosion |
| Edits code outside the task boundary | Missing scope constraint | PR diff bloat, exponential review cost |
| Stacks three layers of abstraction for one caller | Missing simplicity bias | Technical debt arrives early |
| Overwrites uncommitted user changes | Missing ownership boundary | Lost work — highest-severity trust incident |
| Reports "Done" without running any verification | Missing evidence requirement | False completion → production incident |
| Loads Cursor rules in Claude, or vice versa | Missing adapter isolation | Rules cancel out = running naked |

Better models will not fix these. An execution contract with enforcement will.

---

## The Star Contract

Source of truth: [`core/CONTRACT.md`](./core/CONTRACT.md). Every adapter is a projection of these seven rules into the target IDE's native loader.

| # | Rule | Trigger | Agent behavior |
| --- | --- | --- | --- |
| 1 | **Clarify before editing** | Ambiguity touches files / API / data / safety / visible behavior | State assumptions, ask before acting |
| 2 | **Read before designing** | Any non-trivial change | Read owning module, tests, docs, conventions first |
| 3 | **Keep the change narrow** | Every edit | Touch only files the request needs; no drive-by refactors |
| 4 | **Prefer the current simple solution** | Temptation to add abstraction / config / strategy pattern | No new layer without >1 real caller |
| 5 | **Preserve user work** | Uncommitted changes exist | Owned by the user by default; don't touch without instruction |
| 6 | **Verify with concrete evidence** | Before reporting completion | Run smallest useful test/build/lint/screenshot/repro |
| 7 | **Explain tradeoffs briefly** | Meaningful risk or alternative exists | One or two sentences; don't turn routine work into ceremony |

> Contract intensity scales linearly with risk. A typo fix stays ultra-light; a cross-module refactor requires plan + evidence + risk report.

---

## Execution loop

The seven rules constrain **what not to do**. The execution loop defines **how to do it**:

```text
┌─────────┐     ┌─────────┐     ┌─────────┐     ┌─────────┐     ┌─────────┐
│  Orient │ ──▶ │  Scope  │ ──▶ │  Edit   │ ──▶ │ Verify  │ ──▶ │ Report  │
└─────────┘     └─────────┘     └─────────┘     └─────────┘     └─────────┘
 Read owning     State assumptions  Touch smallest   Run smallest     Report: what
 files/tests/    that affect the    file set         useful check     changed, passed,
 docs/conventions implementation                    + collect evidence skipped, risk left
```

Five steps. Each has an exit condition. No ceremony.

**Rules vs loop**: The loop is the operation path; rules are guardrails at each step. Orient is constrained by Rule 2, Edit by Rules 3/4/5, Verify by Rule 6.

---

## Adapter architecture

Core design decision: **each IDE loads rules through its own native format, not a universal file that hopes every loader reads it.**

```text
                    ┌────────────────────────────┐
                    │     core/CONTRACT.md       │   ← single source of truth
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

### Adapter entry table

| Environment | Primary adapter | Optional companion | Handshake response |
| --- | --- | --- | --- |
| Cursor project rules | `.cursor/rules/star-guidelines.mdc` | `.cursor/skills/…/SKILL.md` | `star-guidelines active: scope-first, simple-diff, evidence-verified agent rules loaded for Cursor.` |
| Cursor project skill | `.cursor/skills/star-guidelines/SKILL.md` | `.cursor/rules/…` | `star-guidelines active: scope-first, simple-diff, evidence-verified agent skill loaded for Cursor.` |
| Codex / AGENTS IDE | `AGENTS.md` | `skills/star-guidelines/SKILL.md` | `star-guidelines active: scope-first, simple-diff, evidence-verified agent rules loaded from AGENTS.md.` |
| Codex skill runner | `skills/star-guidelines/SKILL.md` | `agents/openai.yaml` | `star-guidelines active: scope-first, simple-diff, evidence-verified reusable skill loaded.` |
| Claude Code project | `CLAUDE.md` | — | `star-guidelines active: scope-first, simple-diff, evidence-verified Claude project rules loaded.` |
| Claude plugin setup | `.claude-plugin/` | — | `star-guidelines active: scope-first, simple-diff, evidence-verified bundled skill loaded.` |
| WorkBuddy long task | `WORKBUDDY.md` | project task context | `star-guidelines active: scope-first, simple-diff, evidence-verified WorkBuddy direction loaded.` |

> **Key principle**: Do not install every adapter into one project. Each file targets a specific loader. If the project already has rules, **merge** the matching adapter into the existing rule surface.

---

## Quick install

> [!TIP]
> Every command is idempotent. Re-running overwrites the old version without conflict.

> [!NOTE]
> These install commands are permitted for private or internal project use. Public redistribution, marketplace bundling, or committing copied adapters into a public project requires written permission; see [`LICENSE`](./LICENSE).

### Cursor (recommended: always-on rule)

```bash
STAR_RAW=https://raw.githubusercontent.com/Stargod-0812/star-guidelines/main
mkdir -p .cursor/rules
curl -fsSL "$STAR_RAW/.cursor/rules/star-guidelines.mdc" \
  -o .cursor/rules/star-guidelines.mdc
```

<details>
<summary>Optional: Cursor project skill (fuller workflow guidance)</summary>

```bash
mkdir -p .cursor/skills/star-guidelines
curl -fsSL "$STAR_RAW/.cursor/skills/star-guidelines/SKILL.md" \
  -o .cursor/skills/star-guidelines/SKILL.md
```

</details>

### Claude Code

```bash
STAR_RAW=https://raw.githubusercontent.com/Stargod-0812/star-guidelines/main
curl -fsSL "$STAR_RAW/CLAUDE.md" -o CLAUDE.star-guidelines.md
```

Merge into the project's `CLAUDE.md`. For plugin-style setups:

<details>
<summary>Plugin bundle install</summary>

```bash
git clone https://github.com/Stargod-0812/star-guidelines.git
cp -R star-guidelines/.claude-plugin /path/to/target/star-guidelines
```

</details>

### Codex

```bash
STAR_RAW=https://raw.githubusercontent.com/Stargod-0812/star-guidelines/main
curl -fsSL "$STAR_RAW/AGENTS.md" -o AGENTS.star-guidelines.md
```

Merge into `AGENTS.md`. Global skill install:

<details>
<summary>Global skill install</summary>

```bash
git clone https://github.com/Stargod-0812/star-guidelines.git
mkdir -p ~/.codex/skills
cp -R star-guidelines/skills/star-guidelines ~/.codex/skills/
```

</details>

### WorkBuddy

```bash
STAR_RAW=https://raw.githubusercontent.com/Stargod-0812/star-guidelines/main
curl -fsSL "$STAR_RAW/WORKBUDDY.md" -o WORKBUDDY.star-guidelines.md
```

Merge into your WorkBuddy project-level direction area. Suited for long-running tasks, cross-session handoffs, and MCP-heavy workflows.

---

## Verification handshake

Installation does not guarantee activation. **Confirm with a handshake**:

```text
is star-guidelines active?
```

| IDE | Correct response should mention |
| --- | --- |
| Cursor | `rules loaded for Cursor` or `skill loaded for Cursor` |
| Codex | `rules loaded from AGENTS.md` or `reusable skill loaded` |
| Claude Code | `Claude project rules loaded` |
| WorkBuddy | `WorkBuddy direction loaded` |

**Diagnosis**: If the response mentions the wrong adapter (e.g., "Claude project rules" inside Cursor), a rule conflict exists. Remove the file that doesn't belong to the current IDE.

---

## With Star Guidelines vs without

### Scene 1: Bug fix — missing due date crashes reminders

**Without Star (typical agent drift)**:

```diff
- reminder_at = customer["due_date"] - timedelta(days=3)
+ customer.setdefault("timezone", "UTC")
+ customer.setdefault("notification_channel", "email")
+ if customer.get("status") == "trial":
+     return None
+ if not customer.get("due_date"):
+     return datetime.now(timezone.utc) + timedelta(days=7)
+ reminder_at = customer["due_date"] - timedelta(days=3)
```

A null check became notification policy + trial handling + fallback scheduling. Undiscussed. Untested.

**With Star (Rule 3 + Rule 6 active)**:

```diff
- reminder_at = customer["due_date"] - timedelta(days=3)
+ due_date = customer.get("due_date")
+ if due_date is None:
+     return None
+ reminder_at = due_date - timedelta(days=3)
```

Fixes only the crash boundary. If the product wants fallback scheduling, that's a separate request.

### Scene 2: Feature request — manual retry button for failed webhooks

**Without Star**:

```text
I'll build a webhook operations console: retry policies, audit streams,
live status, Slack notifications.
```

**With Star (Rule 1 + Rule 4 active)**:

```text
1. Locate existing webhook failure model and retry path. Verify: read service + tests.
2. Add one UI action calling the existing retry path. Verify: route test.
3. Run webhook-related tests, report skipped checks.
```

Scope locked to "one button calling an existing path," not "build an operations platform."

### Scene 3: Completion report

**Without Star**:

```text
Done.
```

**With Star (Rule 6 + Rule 7 active)**:

```text
Changed src/webhooks/retry.ts and src/webhooks/retry.test.ts.
Verified: npm test -- webhooks/retry.test.ts (passed).
Full suite not run.
Remaining risk: provider-specific retry throttling not covered.
```

The reviewer sees exactly: what changed, what passed, what was skipped, what risk remains.

> More scenarios in [`EXAMPLES.md`](./EXAMPLES.md).

---

## Design philosophy

### Why seven rules, not more

Rule-set effectiveness is inversely proportional to rule count. Beyond 10 rules, agents shift from strict compliance to best-effort approximation. Seven is near the upper bound of what an agent can fully attend to within its context window.

### Why one adapter per IDE

Each IDE has a completely different rule-loading mechanism:

- **Cursor** reads `.mdc` files under `.cursor/rules/`, supports `alwaysApply: true` frontmatter
- **Claude Code** reads `CLAUDE.md` at project root, or loads via plugin mechanism
- **Codex** reads `AGENTS.md`, supports skill directory structure
- **WorkBuddy** reads project direction, integrates with memory/task context

A universal file that "hopes" every IDE reads it is a compromise. Star Guidelines rejects that compromise — native-format adapters for every loader guarantee 100% rule coverage.

### Why contract over advice

Advice ("you should...") can be ignored. A contract ("when triggered, the agent must...") has mandatory exit conditions. Every Star rule has an explicit trigger condition and a corresponding behavior — not a best-practice list.

---

## Compared to alternatives

| Dimension | Star Guidelines | Community `.cursorrules` templates | Generic AI coding guidelines |
| --- | --- | --- | --- |
| IDE coverage | 4 native adapters | Cursor only | No IDE-specific adaptation |
| Rule count | 7 (fully attendable by agents) | Typically 15-50+ | Unlimited |
| Verification | Executable handshake | None | None |
| Normative source | Single file `core/CONTRACT.md` | No normative source concept | N/A |
| Completion standard | Evidence required | Usually not enforced | None |
| Maintenance cost | `check-repo.sh` auto-checks consistency | Manual | N/A |
| Architecture | Adapter pattern (isolation) | Single file (all-in-one) | Document (no architecture) |

---

## Repository structure

```text
star-guidelines/
├── core/
│   └── CONTRACT.md                    # Normative source · single source of truth
├── AGENTS.md                          # Codex adapter · command-oriented style
├── CLAUDE.md                          # Claude Code adapter · project rules style
├── CURSOR.md                          # Cursor usage guide
├── WORKBUDDY.md                       # WorkBuddy adapter · long-running direction
├── .cursor/
│   ├── rules/star-guidelines.mdc      # Cursor always-on rule (alwaysApply: true)
│   └── skills/star-guidelines/SKILL.md # Cursor project skill
├── skills/star-guidelines/
│   ├── SKILL.md                       # IDE-agnostic reusable skill
│   └── agents/openai.yaml            # OpenAI skill runner metadata
├── .claude-plugin/
│   ├── plugin.json                    # Claude plugin manifest
│   ├── marketplace.json               # Marketplace metadata
│   └── skills/star-guidelines/SKILL.md # Bundled skill copy
├── .github/
│   ├── workflows/check-repo.yml       # CI: repository consistency check
│   ├── ISSUE_TEMPLATE/                # Bug/proposal issue templates
│   ├── PULL_REQUEST_TEMPLATE.md       # Adapter sync checklist
│   └── CODEOWNERS                     # Maintainer review boundary
├── docs/
│   ├── ADAPTERS.md                    # Adapter deep-dive
│   └── INSTALL.md                     # Per-platform install docs
├── EXAMPLES.md                        # 7 before/after scenarios
├── CHANGELOG.md                       # Versioned changes
├── LICENSE                            # Source-available, permission-required
└── scripts/
    └── check-repo.sh                  # CI: file presence + term coverage + identity
```

---

## Design principles

| Principle | Meaning |
| --- | --- |
| **One loader, one adapter** | No IDE should guess which file is active. Each loader gets exactly one entry point. |
| **Local code over generic advice** | The agent must read the current repo's code/tests/conventions before deciding implementation shape. |
| **Small diffs as a feature** | Unrelated cleanup is a separate PR, not a hidden side effect of the current change. |
| **Verification is work** | A completion report without evidence equals incomplete. |
| **User work is sacred** | Uncommitted changes = user's private property. Not to be touched without permission. |
| **Contract is normative** | When an adapter and `core/CONTRACT.md` conflict, the contract wins. |
| **Risk-proportional ceremony** | A typo fix needs no plan; a cross-module refactor requires plan + evidence + risk. |

---

## Maintenance & consistency

When changing the core contract, **sync all 8 adapter files in the same commit**:

```text
core/CONTRACT.md                       ← change here
AGENTS.md                              ← sync
CLAUDE.md                              ← sync
.cursor/rules/star-guidelines.mdc      ← sync
.cursor/skills/star-guidelines/SKILL.md ← sync
WORKBUDDY.md                           ← sync
skills/star-guidelines/SKILL.md        ← sync
.claude-plugin/skills/…/SKILL.md       ← sync
```

Run the consistency check before publishing:

```bash
scripts/check-repo.sh
```

The script verifies:
- All required files exist
- All seven core terms are covered in every adapter
- Handshake text is present in every adapter and README
- Chinese README contains all Chinese core terms
- Local Markdown links resolve
- Plugin JSON and OpenAI skill metadata parse
- GitHub Actions runs the same check on pushes and pull requests
- Optional release checks: set `STAR_GUIDELINES_EXPECTED_IDENTITY` for Git author/committer identity consistency and `STAR_GUIDELINES_CHECK_REMOTE_MAIN=1` to require `origin/main` alignment

---

## Who it's for

**Without solid engineering fundamentals** — Star Guidelines is a safety net.

The biggest risk for these users is not recognizing when an agent is drifting: they can't distinguish scope creep from normal implementation, over-abstraction from reasonable encapsulation, fabricated completion from real verification. With Star Guidelines installed, the agent self-constrains at the execution layer — effectively borrowing a set of senior engineering judgment. From "don't know what you don't know" to "the agent holds the line for me."

**With solid engineering fundamentals** — Star Guidelines is an attention multiplier.

These users spot agent problems instantly, but shouldn't need to manually enforce standards every session. Without Star Guidelines, every conversation starts with: "don't touch other files," "run a test before saying done," "don't add abstractions I didn't ask for." With it installed, the babysitting disappears — the agent comes pre-loaded with your engineering standards, and you review outcomes instead of supervising process.

**Common thread**: The more frequently you use agents, and the heavier the tasks you delegate, the more value Star Guidelines delivers. It doesn't teach you to code. It teaches agents not to go rogue.

---

## License

**Source-available, permission-required.**

Free to use: read, study, evaluate, and quote excerpts with attribution and link.

Written permission required: redistribute, mirror, bundle into a product, build a competing rule kit on top of it, or use for model training.

See [`LICENSE`](./LICENSE).

---

<div align="center">

Designed & built by **[Star](https://github.com/Stargod-0812)** · v2.0.0

</div>
