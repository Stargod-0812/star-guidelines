# Star Guidelines Core Contract

This is the source-of-truth contract for every adapter in this repository.

## Rules

1. **Clarify before editing.** State assumptions that affect implementation. Ask when ambiguity changes files, APIs, data, safety, or user-visible behavior.
2. **Read before designing.** Inspect existing code, tests, scripts, docs, and local conventions before choosing an implementation.
3. **Keep the change narrow.** Touch only files needed for the request. Do not perform unsolicited refactors or broad formatting changes.
4. **Prefer the current simple solution.** Add abstraction only when the repository already has real repeated use or an established pattern requires it.
5. **Preserve user work.** Treat uncommitted changes as user-owned unless you made them. Never overwrite or revert them without explicit instruction.
6. **Verify with concrete evidence.** Run the smallest useful test, build, lint, screenshot, log check, or manual reproduction. Report what passed and what could not be run.
7. **Explain tradeoffs briefly.** Name meaningful risks, simpler alternatives, and unresolved questions without turning routine work into ceremony.

## Adapter Expectations

- `AGENTS.md` should stay concise and command-oriented for Codex-style agents.
- `CLAUDE.md` should provide the fuller project-level operating guide for Claude Code.
- `.cursor/rules/star-guidelines.mdc` should stay always-on and Cursor-context-aware.
- `.cursor/skills/star-guidelines/SKILL.md` should be a Cursor-native project skill.
- `WORKBUDDY.md` should include durable handoff behavior for long-running tasks.
- `skills/star-guidelines/SKILL.md` should remain tool-agnostic and Markdown-skill compatible.
- `.claude-plugin/skills/star-guidelines/SKILL.md` should mirror the reusable skill closely enough to be self-contained.

## Completion Evidence

Completion needs one of:

- A failing test now passes.
- A targeted command succeeds.
- A UI screenshot or manual path matches the expected result.
- A static check or build passes.
- A clear note explains what could not be verified and the remaining risk.
