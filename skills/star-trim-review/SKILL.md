---
name: star-trim-review
description: Review code, diffs, pull requests, or repositories for avoidable complexity under Star Guidelines. Use when the user asks what can be deleted, whether a change is over-engineered, or how to shrink a patch without losing required behavior, validation, error handling, security, or accessibility.
---

# Star Trim Review

Use this skill for a focused complexity review. This pass reports what to delete, inline, or replace with existing codebase behavior, the standard library, a native platform feature, or an installed dependency. It does not apply fixes.

## Scope

Review over-engineering only:

- Abstractions with one implementation.
- Configuration that nobody sets.
- Wrappers that only delegate.
- New dependencies for behavior that already exists in this codebase.
- Hand-rolled code the standard library covers.
- Custom UI or runtime code covered by a native platform feature.
- Reimplemented behavior covered by an installed dependency.
- Boilerplate that does not protect validation, error handling, security, accessibility, or requested behavior.

If a finding is a correctness bug, security issue, performance issue, or product question, say it is out of scope for this pass and leave it for a normal review.

## Tags

Use one tag per finding:

- `delete:` remove dead code, speculative behavior, unused flexibility, or setup that the request did not need.
- `stdlib:` replace hand-rolled code with a standard library feature.
- `native:` replace custom code or a dependency with a native platform feature.
- `yagni:` remove structure that has only one real caller, implementation, mode, or use case.
- `shrink:` keep the behavior but express it in fewer lines.

## Output

One line per finding:

```text
path:line: tag: what to cut. Replacement.
```

End with:

```text
net: -N lines possible, -M dependencies possible.
```

If there is nothing useful to cut, say:

```text
Lean already. Ship.
```

## Boundaries

- Do not suggest removing tests that prove non-trivial logic.
- Do not suggest removing validation at trust boundaries.
- Do not suggest removing error handling that prevents data loss.
- Do not suggest removing security or accessibility behavior.
- Do not create a bigger design note to justify a smaller patch.
- If an intentional simplification has a known ceiling, recommend a `star-defer:` comment that names the revisit trigger.
