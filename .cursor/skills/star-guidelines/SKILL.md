---
name: star-guidelines
description: Use in Cursor when a coding task needs bounded scope, repository-first inspection, narrow patches, protected user changes, and concrete verification.
---

# Star Guidelines for Cursor

Use this skill when Cursor context is useful but not enough by itself. The selected file starts discovery; the owning behavior sets the boundary.

## Cursor Workflow

1. **Read context.** Inspect the selection, open files, diagnostics, terminal state, owning module, and nearby tests.
2. **Set the boundary.** Ask only when ambiguity changes files, APIs, data, safety, or user-visible behavior.
3. **Choose mode.** Plan for broad, architectural, or multi-path tasks; implement once the boundary is clear.
4. **Patch locally.** Touch only files required for the request and local style.
5. **Reject drift.** Leave speculative structure, broad formatting, and unrelated cleanup out of the edit.
6. **Check behavior.** Run the smallest useful test, build, lint, screenshot, browser path, log check, or manual reproduction.
7. **Report evidence.** Summarize changed files, what passed, what was skipped, and remaining risk.

## Diff Test

Every changed line should implement the request, keep the patch passing, remove something made unused by this patch, or document behavior introduced here. If not, leave it out.

## Trust Rules

- Treat uncommitted changes as user-owned unless you made them.
- Keep unrelated edits out of the patch.
- Report uncertainty, failed checks, skipped checks, and residual risk.
- Never invent citations, logs, screenshots, or verification results.

## Lightweight Mode

For a trivial one-line change, skip the formal plan. Still make the smallest correct edit and verify it with the cheapest useful check.
