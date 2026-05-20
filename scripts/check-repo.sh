#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

required_files=(
  "README.md"
  "README.en.md"
  "AGENTS.md"
  "CLAUDE.md"
  "CURSOR.md"
  "WORKBUDDY.md"
  ".cursor/rules/star-guidelines.mdc"
  ".cursor/skills/star-guidelines/SKILL.md"
  "skills/star-guidelines/SKILL.md"
  ".claude-plugin/plugin.json"
  ".claude-plugin/marketplace.json"
  ".claude-plugin/skills/star-guidelines/SKILL.md"
  "core/CONTRACT.md"
  "docs/ADAPTERS.md"
  "docs/INSTALL.md"
  "EXAMPLES.md"
  "CHANGELOG.md"
  "LICENSE"
  "skills/star-guidelines/agents/openai.yaml"
)

for file in "${required_files[@]}"; do
  if [[ ! -f "$file" ]]; then
    echo "Missing required file: $file" >&2
    exit 1
  fi
done

required_terms=(
  "Clarify before editing"
  "Read before designing"
  "Keep the change narrow"
  "Preserve user work"
  "Verify with concrete evidence"
)

for term in "${required_terms[@]}"; do
  if ! grep -qF -- "$term" AGENTS.md CLAUDE.md .cursor/rules/star-guidelines.mdc core/CONTRACT.md; then
    echo "Core term missing from an adapter set: $term" >&2
    exit 1
  fi
done

required_zh_terms=(
  "先澄清"
  "先阅读"
  "保持改动狭窄"
  "保护用户工作"
  "用具体证据验证"
)

for term in "${required_zh_terms[@]}"; do
  if ! grep -qF -- "$term" README.md; then
    echo "Chinese README is missing core term: $term" >&2
    exit 1
  fi
done

expected_identity="Stargod-0812 <Stargod-0812@users.noreply.github.com>"

head_authors="$(git log --format='%an <%ae>' HEAD | sort -u)"
if [[ "$head_authors" != "$expected_identity" ]]; then
  echo "Unexpected HEAD author identity: $head_authors" >&2
  exit 1
fi

head_committers="$(git log --format='%cn <%ce>' HEAD | sort -u)"
if [[ "$head_committers" != "$expected_identity" ]]; then
  echo "Unexpected HEAD committer identity: $head_committers" >&2
  exit 1
fi

if git show-ref --verify --quiet refs/remotes/origin/main; then
  if [[ "$(git rev-parse refs/remotes/origin/main)" != "$(git rev-parse HEAD)" ]]; then
    echo "origin/main does not match HEAD. Force-push the cleaned main branch, then fetch/prune before publishing." >&2
    exit 1
  fi

  all_authors="$(git log --format='%an <%ae>' --all | sort -u)"
  if [[ "$all_authors" != "$expected_identity" ]]; then
    echo "Unexpected author identity reachable from refs: $all_authors" >&2
    exit 1
  fi
fi

echo "star-guidelines repository checks passed."
