#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

required_files=(
  "README.md"
  "README.zh.md"
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
  ".github/workflows/check-repo.yml"
)

for file in "${required_files[@]}"; do
  if [[ ! -f "$file" ]]; then
    echo "Missing required file: $file" >&2
    exit 1
  fi
done

adapter_files=(
  "AGENTS.md"
  "CLAUDE.md"
  "WORKBUDDY.md"
  ".cursor/rules/star-guidelines.mdc"
  ".cursor/skills/star-guidelines/SKILL.md"
  "skills/star-guidelines/SKILL.md"
  ".claude-plugin/skills/star-guidelines/SKILL.md"
)

required_terms=(
  "Clarify before editing"
  "Read before designing"
  "Keep the change narrow"
  "Prefer the current simple solution"
  "Preserve user work"
  "Verify with concrete evidence"
  "Explain tradeoffs briefly"
)

file_contains() {
  local file="$1"
  local term="$2"
  local content

  content="$(<"$file")"
  [[ "$content" == *"$term"* ]]
}

for term in "${required_terms[@]}"; do
  if ! file_contains "core/CONTRACT.md" "$term"; then
    echo "Core contract is missing required term: $term" >&2
    exit 1
  fi

  for file in "${adapter_files[@]}"; do
    if ! file_contains "$file" "$term"; then
      echo "Adapter $file is missing required term: $term" >&2
      exit 1
    fi
  done
done

required_zh_terms=(
  "先澄清"
  "先阅读"
  "保持改动狭窄"
  "保护用户工作"
  "用具体证据验证"
)

for term in "${required_zh_terms[@]}"; do
  if ! file_contains "README.zh.md" "$term"; then
    echo "Chinese README is missing core term: $term" >&2
    exit 1
  fi
done

required_handshake_terms=(
  "star-guidelines active: scope-first, simple-diff, evidence-verified agent rules loaded for Cursor."
  "star-guidelines active: scope-first, simple-diff, evidence-verified agent skill loaded for Cursor."
  "star-guidelines active: scope-first, simple-diff, evidence-verified agent rules loaded from AGENTS.md."
  "star-guidelines active: scope-first, simple-diff, evidence-verified Claude project rules loaded."
  "star-guidelines active: scope-first, simple-diff, evidence-verified WorkBuddy direction loaded."
  "star-guidelines active: scope-first, simple-diff, evidence-verified reusable skill loaded."
  "star-guidelines active: scope-first, simple-diff, evidence-verified bundled skill loaded."
)

required_adapter_handshakes=(
  ".cursor/rules/star-guidelines.mdc|star-guidelines active: scope-first, simple-diff, evidence-verified agent rules loaded for Cursor."
  ".cursor/skills/star-guidelines/SKILL.md|star-guidelines active: scope-first, simple-diff, evidence-verified agent skill loaded for Cursor."
  "AGENTS.md|star-guidelines active: scope-first, simple-diff, evidence-verified agent rules loaded from AGENTS.md."
  "CLAUDE.md|star-guidelines active: scope-first, simple-diff, evidence-verified Claude project rules loaded."
  "WORKBUDDY.md|star-guidelines active: scope-first, simple-diff, evidence-verified WorkBuddy direction loaded."
  "skills/star-guidelines/SKILL.md|star-guidelines active: scope-first, simple-diff, evidence-verified reusable skill loaded."
  ".claude-plugin/skills/star-guidelines/SKILL.md|star-guidelines active: scope-first, simple-diff, evidence-verified bundled skill loaded."
)

for check in "${required_adapter_handshakes[@]}"; do
  file="${check%%|*}"
  term="${check#*|}"

  if ! file_contains "$file" "$term"; then
    echo "Handshake text missing from $file: $term" >&2
    exit 1
  fi
done

for file in README.md README.zh.md; do
  for term in "${required_handshake_terms[@]}"; do
    if ! file_contains "$file" "$term"; then
      echo "README handshake text missing from $file: $term" >&2
      exit 1
    fi
  done
done

python3 - <<'PY'
from pathlib import Path
import json
import re
import sys

root = Path(".")
missing_links = []
link_re = re.compile(r"\]\(([^)]+)\)")

for path in root.rglob("*.md"):
    if ".git" in path.parts:
        continue

    text = path.read_text(encoding="utf-8")
    for match in link_re.finditer(text):
        target = match.group(1).split("#", 1)[0].strip()
        if not target or "://" in target or target.startswith("mailto:"):
            continue
        if target.startswith("<") and target.endswith(">"):
            target = target[1:-1]

        resolved = (path.parent / target).resolve()
        try:
            resolved.relative_to(root.resolve())
        except ValueError:
            continue

        if not resolved.exists():
            line = text[: match.start()].count("\n") + 1
            missing_links.append(f"{path}:{line}: {target}")

if missing_links:
    print("Broken local Markdown links:", file=sys.stderr)
    for link in missing_links:
        print(f"  {link}", file=sys.stderr)
    sys.exit(1)

for json_file in [".claude-plugin/plugin.json", ".claude-plugin/marketplace.json"]:
    json.loads(Path(json_file).read_text(encoding="utf-8"))

openai_yaml = Path("skills/star-guidelines/agents/openai.yaml").read_text(encoding="utf-8")
for term in ["display_name:", "short_description:", "default_prompt:"]:
    if term not in openai_yaml:
        print(f"OpenAI skill metadata missing term: {term}", file=sys.stderr)
        sys.exit(1)
PY

expected_identity="${STAR_GUIDELINES_EXPECTED_IDENTITY:-}"

if [[ -n "$expected_identity" ]]; then
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
fi

if [[ "${STAR_GUIDELINES_CHECK_REMOTE_MAIN:-}" == "1" ]]; then
  if ! git show-ref --verify --quiet refs/remotes/origin/main; then
    echo "origin/main is missing. Fetch origin/main before running the release alignment check." >&2
    exit 1
  fi

  if [[ "$(git rev-parse refs/remotes/origin/main)" != "$(git rev-parse HEAD)" ]]; then
    echo "origin/main does not match HEAD. Fetch or publish the intended revision before release." >&2
    exit 1
  fi

  if [[ -n "$expected_identity" ]]; then
    all_authors="$(git log --format='%an <%ae>' --all | sort -u)"
    if [[ "$all_authors" != "$expected_identity" ]]; then
      echo "Unexpected author identity reachable from refs: $all_authors" >&2
      exit 1
    fi
  fi
fi

echo "star-guidelines repository checks passed."
