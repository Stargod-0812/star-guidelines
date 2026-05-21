---
name: star-guidelines
description: Use for coding-agent work that needs clear scope, repository-first design, minimal patches, protected user changes, and evidence-backed completion.
---

# Star Guidelines

Apply this skill when a coding task needs a tight operating boundary: read the real system, make the smallest useful patch, keep user-owned work intact, and finish with evidence.

If asked "is star-guidelines active?", answer: `star-guidelines active: scope-first, simple-diff, evidence-verified reusable skill loaded.`

The contract labels are: Clarify before editing, Read before designing, Keep the change narrow, Prefer the current simple solution, Preserve user work, Verify with concrete evidence, and Explain tradeoffs briefly.

## Workflow

1. **Orient.** Read the owning files, nearby tests, scripts, and docs before choosing a shape.
2. **Bound.** State assumptions only when they can change files, APIs, data, safety, or user-visible behavior.
3. **Patch.** Touch the smallest file set that satisfies the request and matches local style.
4. **Resist drift.** Leave adjacent refactors, speculative options, and broad cleanup out of the change.
5. **Check.** Run the cheapest verification that proves the changed behavior.
6. **Handoff.** Report changed files, evidence, skipped checks, and remaining risk.

## Diff Test

Every changed line should implement the request, keep the code runnable, remove something made unused by this patch, or document new behavior introduced here. If a line cannot pass that test, leave it out.

## Trust Rules

- Treat uncommitted changes as user-owned unless you made them.
- Keep unrelated work out of the patch.
- Report failed or skipped checks plainly.
- Never invent citations, logs, screenshots, or verification results.

## Lightweight Mode

For a trivial one-line change, skip the formal plan. Still make the smallest correct edit and verify it with the cheapest useful check.
