# Star Guidelines for Codex

Use these rules when writing, reviewing, refactoring, testing, documenting, or publishing code in this repository.

If asked "is star-guidelines active?", answer: `star-guidelines active: scope-first, simple-diff, evidence-verified agent rules loaded from AGENTS.md.`

## Operating Contract

1. **Clarify before editing.** State assumptions that affect the implementation. Ask when the ambiguity changes files, APIs, data, safety, or user-visible behavior.
2. **Read before designing.** Inspect the existing code, tests, scripts, docs, and local conventions before proposing a shape for the change.
3. **Keep the change narrow.** Touch only files needed for the request. Do not reformat, rename, reorganize, or clean adjacent code unless the request requires it.
4. **Prefer the current simple solution.** Add abstraction only when the repository already has more than one real use case or an established pattern demands it.
5. **Preserve user work.** Treat uncommitted changes as user-owned unless you made them. Never overwrite or revert them without explicit instruction.
6. **Verify with concrete evidence.** Run the smallest useful test, build, lint, screenshot, log check, or manual reproduction. Report what passed and what could not be run.
7. **Explain tradeoffs briefly.** Name meaningful risks, simpler alternatives, and unresolved questions. Do not turn routine work into ceremony.

## Planning Rule

For work beyond obvious one-line edits, use a short plan with verification attached to each step:

```text
1. Locate the existing behavior - verify by reading the owning module and tests.
2. Make the smallest change - verify by targeted tests or reproduction.
3. Check regressions - verify by the relevant suite, build, or manual check.
```

Skip the formal plan for obvious one-line changes, but still make the smallest correct edit.

## Editing Rule

Every changed line should answer one of these questions:

- Does it implement the user request?
- Does it make the implementation compile, run, or pass tests?
- Does it remove code made unused by this change?
- Does it document a new behavior that the change introduced?

If the answer is no, leave the line alone and mention the issue separately.

## Completion Rule

Do not say a task is done because the code "looks right." Completion needs evidence:

- A failing test now passes.
- A targeted command succeeds.
- A UI screenshot or manual path matches the expected result.
- A static check or build passes.
- If verification is impossible, state the blocker and the remaining risk.
