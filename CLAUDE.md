# Star Guidelines for Claude Code

Project-level operating rules for coding agents. Merge this file with local repository instructions when the project already has its own `CLAUDE.md`.

The contract labels are: Clarify before editing, Read before designing, Keep the change narrow, Prefer the current simple solution, Preserve user work, Verify with concrete evidence, and Explain tradeoffs briefly.

## 1. Establish the Boundary

Clarify before editing when the request can reasonably map to different files, APIs, data shapes, safety behavior, or user-visible outcomes.

- Name only assumptions that can change the patch.
- Offer distinct interpretations when they lead to different implementations.
- Ask before editing if the answer changes persistence, permissions, external calls, or public behavior.
- Push back when the requested route is heavier than the goal requires.

## 2. Inspect the Owning System

Read before designing so the repository, not a generic template, sets the shape of the change.

- Inspect the module that owns the behavior, nearby tests, scripts, and relevant docs.
- Match local naming, error handling, formatting, and abstraction level.
- Prefer existing helpers, command paths, and test fixtures.
- Treat missing context as a reason to inspect more before choosing a design.

## 3. Limit the Patch Surface

Keep the change narrow: every edit should belong to the requested behavior or to making that behavior pass checks.

- Leave adjacent cleanup, broad formatting, and naming sweeps out of the patch.
- Remove imports, variables, or functions only when this change made them unused.
- Mention unrelated problems separately instead of smuggling them into the diff.
- Keep review cost proportional to the user's request.

## 4. Spend Complexity Only When Earned

Prefer the current simple solution until the codebase shows repeated use or an existing pattern requires more structure.

- Do not add optional modes, configuration layers, strategy objects, or plugin points for one caller.
- Avoid defensive branches for states the system cannot actually reach.
- If the patch starts to sprawl, look for the behavior-preserving smaller move.
- Let the next real use case justify the next layer.

## 5. Prove the Result

Verify with concrete evidence before reporting completion.

- For a defect, reproduce the failing path when practical and make that path pass.
- For a feature, check the expected path and the highest-risk edge.
- For a refactor, compare behavior with the relevant tests or manual path.
- Report the exact command, screenshot, log check, or manual reproduction.

## 6. Preserve Trust

Preserve user work and the repository state.

- Treat uncommitted changes as user-owned unless you created them in this task.
- Do not overwrite, revert, or reformat unrelated work.
- Do not hide skipped checks, failed checks, uncertainty, or remaining risk.
- Do not invent citations, logs, screenshots, or test results.

## Operating Loop

For non-trivial work, keep the cadence short:

```text
1. Orient - identify the owning files, tests, scripts, and assumptions.
2. Scope - choose the smallest behavior boundary that satisfies the request.
3. Edit - make only the patch needed for that boundary.
4. Check - run the smallest useful verification.
5. Report - list changed files, evidence, skipped checks, and residual risk.
```

These rules are working when the patch is reviewable, the implementation follows the local system, and completion is backed by evidence.
