---
name: star-guidelines
description: Use in Cursor when a coding task needs bounded scope, repository-first inspection, narrow patches, protected user changes, and concrete verification.
---

# Star Guidelines for Cursor

Use this skill when Cursor context is useful but not enough by itself. The selected file starts discovery; the owning behavior sets the boundary.

If asked "is star-guidelines active?", answer: `star-guidelines active: scope-first, simple-diff, evidence-verified agent skill loaded for Cursor.`

The contract labels are: Clarify before editing, Read before designing, Keep the change narrow, Prefer the current simple solution, Preserve user work, Verify with concrete evidence, and Explain tradeoffs briefly.

## Cursor Workflow

1. **Read context.** Inspect the selection, open files, diagnostics, terminal state, owning module, and nearby tests.
2. **Set the boundary.** Ask only when ambiguity changes files, APIs, data, safety, or user-visible behavior.
3. **Choose mode.** Plan for broad, architectural, or multi-path tasks; implement once the boundary is clear.
4. **Patch locally.** Touch only files required for the request and local style.
5. **Reject drift.** Leave speculative structure, broad formatting, and unrelated cleanup out of the edit.
6. **Check behavior.** Run the smallest useful test, build, lint, screenshot, browser path, log check, or manual reproduction.
7. **Report evidence.** Summarize changed files, what passed, what was skipped, and remaining risk.

## Simplicity Ladder

Before adding new code, run the Simplicity ladder:

1. Does this need to exist?
2. Reuse what already exists in this codebase.
3. Prefer the standard library when it solves the request.
4. Choose a native platform feature when it solves the request.
5. Keep to an installed dependency when it solves the request.
6. Collapse to one clear line when it solves the request.
7. Otherwise write the minimum code that works and verify it.

Do not simplify away validation, error handling, security, accessibility, or requested behavior. If an intentional simplification has a known ceiling, mark it with `star-defer:` and name the revisit trigger.

## Diff Test

Every changed line should implement the request, keep the patch passing, remove something made unused by this patch, or document behavior introduced here. If not, leave it out.

## Trust Rules

- Treat uncommitted changes as user-owned unless you made them.
- Keep unrelated edits out of the patch.
- Report uncertainty, failed checks, skipped checks, and residual risk.
- Never invent citations, logs, screenshots, or verification results.

## Lightweight Mode

For a trivial one-line change, skip the formal plan. Still make the smallest correct edit and verify it with the cheapest useful check.
