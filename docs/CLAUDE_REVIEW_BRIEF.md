# Claude Review Brief

This note summarizes the current uncommitted changes for review. The goal of the patch is to make Star Guidelines' documented promise true: installable adapters, consistent activation handshakes, and a repository check that actually catches adapter drift.

## What Changed

### Handshake Consistency

Added or aligned `is star-guidelines active?` responses across the adapter surface:

- `CLAUDE.md`
- `WORKBUDDY.md`
- `.cursor/skills/star-guidelines/SKILL.md`
- `skills/star-guidelines/SKILL.md`
- `.claude-plugin/skills/star-guidelines/SKILL.md`
- `README.md`
- `README.zh.md`

The README adapter table now uses the exact response shape from each adapter instead of older placeholder phrases like `Cursor rule loaded` or `AGENTS rules loaded`.

### Stronger Repository Check

Reworked `scripts/check-repo.sh` so it now verifies:

- Required project files exist, including the new CI workflow.
- `core/CONTRACT.md` contains all seven contract labels.
- Every adapter file contains all seven contract labels.
- Every adapter contains its exact expected handshake text.
- Both READMEs contain all seven exact expected handshake strings from the adapter table.
- Chinese README includes the core Chinese terms.
- Local Markdown links resolve.
- Claude plugin JSON metadata parses.
- `skills/star-guidelines/agents/openai.yaml` contains required metadata fields.

Git author/committer identity and `origin/main` alignment are now opt-in release checks:

- `STAR_GUIDELINES_EXPECTED_IDENTITY='Name <email>' scripts/check-repo.sh`
- `STAR_GUIDELINES_CHECK_REMOTE_MAIN=1 scripts/check-repo.sh`

This keeps default CI usable on PR branches while preserving stricter release hygiene when needed. When `STAR_GUIDELINES_CHECK_REMOTE_MAIN=1` is set, missing `origin/main` is a failure because the release alignment check cannot be proven.

### CI Added

Added `.github/workflows/check-repo.yml` to run `scripts/check-repo.sh` on:

- Pull requests
- Pushes to `main`

### Documentation Fixes

Updated docs to match the new behavior:

- Fixed `README.zh.md` English badge from missing `README.en.md` to `README.md`.
- Updated README repository map to include `.github/`.
- Updated README maintenance section to describe the expanded checks.
- Updated `docs/INSTALL.md` with an explicit WorkBuddy handshake.
- Added an Unreleased section in `CHANGELOG.md`.
- Updated `LICENSE` and install docs to explicitly allow documented private/internal installation copies while keeping public redistribution, marketplace bundling, public-project copies, and productization permission-required.

## Verification Performed

The following checks passed:

```bash
bash -n scripts/check-repo.sh
scripts/check-repo.sh
STAR_GUIDELINES_CHECK_REMOTE_MAIN=1 scripts/check-repo.sh
git diff --check
```

Additional verification:

- Independent local Markdown link scan passed.
- Plugin JSON parse check passed.
- Ad hoc local adapter installation smoke test passed for:
  - Cursor rule
  - Cursor skill
  - Codex project file
  - Codex reusable skill
  - Claude project file
  - Claude plugin bundle
  - WorkBuddy direction file
- Code review agent found no blocking issue.

Expected remaining signal:

```bash
STAR_GUIDELINES_EXPECTED_IDENTITY='Stargod-0812 <Stargod-0812@users.noreply.github.com>' scripts/check-repo.sh
```

This still fails because the existing Git history includes `starrliao <starrliao@tencent.com>`. That is intentional after this patch: identity checks are release-only opt-in checks, not default CI gates.

## Review Focus

Please review especially:

- Whether `scripts/check-repo.sh` is strict enough to catch real adapter drift without creating brittle false failures.
- Whether `STAR_GUIDELINES_EXPECTED_IDENTITY` and `STAR_GUIDELINES_CHECK_REMOTE_MAIN` are the right boundaries for release-only checks.
- Whether `STAR_GUIDELINES_CHECK_REMOTE_MAIN=1` should require a local `origin/main` ref, as the current patch does.
- Whether the handshake wording is clear and stable enough for users to verify installation.
- Whether adding contract labels to skill files creates useful consistency or unnecessary repetition.
- Whether the LICENSE and install-doc private/internal installation allowance is legally and product-wise clear enough.

## Known Tradeoffs

- `CURSOR.md` is still treated as a usage guide, not an adapter contract file, so the script checks that it exists but does not require all seven contract labels there.
- The workflow runs on pull requests and pushes to `main`, not on every feature branch push.
- The Markdown link checker is intentionally local-only and does not validate external URLs.
