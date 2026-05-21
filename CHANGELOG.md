# Changelog

All notable changes to Star Guidelines are documented here. This project follows [Semantic Versioning](https://semver.org/).

## Unreleased

### Added
- GitHub Actions workflow that runs `scripts/check-repo.sh` on pushes and pull requests.
- Explicit activation handshake text for Claude Code, WorkBuddy, Cursor skill, reusable skill, and bundled plugin skill.

### Changed
- `scripts/check-repo.sh` now checks all adapter files for all seven core terms, validates handshake text, scans local Markdown links, and parses plugin metadata.
- Git author/committer identity and `origin/main` alignment checks are now opt-in release checks through environment variables; the remote alignment check fails if `origin/main` is missing.
- License now explicitly allows documented private or internal installation copies while preserving permission requirements for redistribution and productization.
- Install docs now call out that public redistribution, marketplace bundling, or committing copied adapters into public projects requires permission.

### Fixed
- Chinese README English-language badge now points to `README.md`.
- README handshake tables now match the actual adapter responses.

## [2.0.0] — 2026-05-19

### Added
- Frontier-style README with Star branding, manifesto, ASCII router diagram, and before/after examples.
- Mirrored Chinese README with the same structure and Star contract terms.
- `LICENSE` at the repo root: a custom source-available, permission-required license. Reading and quoting with attribution are free; redistribution, productization, competing rule kits, and model training require written permission.
- Short `License` section in both READMEs pointing at `LICENSE`.
- `CHANGELOG.md` for versioned change tracking.
- `.github/` issue and pull-request templates plus `CODEOWNERS`.
- `homepage` and `repository` metadata in `plugin.json` and `.claude-plugin/marketplace.json`.

### Changed
- README repository map now flags `core/CONTRACT.md` as the normative source.
- All adapter files now point at `core/CONTRACT.md` as the single source of truth.
- `scripts/check-repo.sh` now verifies required files, adapter coverage, Chinese README terms, and repository author identity.

## [1.0.0]

Initial release of the seven-rule operating contract with adapters for Cursor, Claude Code, Codex, and WorkBuddy.
