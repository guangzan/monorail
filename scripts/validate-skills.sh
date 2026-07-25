#!/usr/bin/env bash
set -euo pipefail

REPO="$(cd "$(dirname "$0")/.." && pwd)"
SKILLS_DIR="$REPO/skills"

EXPECTED=(
  rail
  rail-setup
  rail-align
  rail-grill
  rail-spec
  rail-slice
  rail-build
  rail-pass
  rail-debug
  rail-tdd
  rail-review
)

USER_INVOKED=(
  rail
  rail-setup
  rail-align
  rail-grill
  rail-spec
  rail-slice
  rail-build
  rail-pass
)

MODEL_INVOKED=(
  rail-debug
  rail-tdd
  rail-review
)

fail=0

for name in "${EXPECTED[@]}"; do
  dir="$SKILLS_DIR/$name"
  skill="$dir/SKILL.md"
  yaml="$dir/agents/openai.yaml"
  if [[ ! -f "$skill" ]]; then
    echo "MISSING: $skill" >&2
    fail=1
    continue
  fi
  if [[ ! -f "$yaml" ]]; then
    echo "MISSING: $yaml" >&2
    fail=1
  fi
  fm_name="$(awk '/^name:/{print $2; exit}' "$skill")"
  if [[ "$fm_name" != "$name" ]]; then
    echo "NAME MISMATCH: $skill has name=$fm_name expected=$name" >&2
    fail=1
  fi
done

for name in "${USER_INVOKED[@]}"; do
  skill="$SKILLS_DIR/$name/SKILL.md"
  yaml="$SKILLS_DIR/$name/agents/openai.yaml"
  [[ -f "$skill" ]] || continue
  if ! grep -q '^disable-model-invocation: true' "$skill"; then
    echo "USER-INVOKED MISSING FLAG: $skill" >&2
    fail=1
  fi
  if [[ -f "$yaml" ]] && ! grep -q 'allow_implicit_invocation: false' "$yaml"; then
    echo "USER-INVOKED MISSING POLICY: $yaml" >&2
    fail=1
  fi
done

for name in "${MODEL_INVOKED[@]}"; do
  skill="$SKILLS_DIR/$name/SKILL.md"
  yaml="$SKILLS_DIR/$name/agents/openai.yaml"
  [[ -f "$skill" ]] || continue
  if grep -q '^disable-model-invocation:' "$skill"; then
    echo "MODEL-INVOKED MUST OMIT disable-model-invocation: $skill" >&2
    fail=1
  fi
  if [[ -f "$yaml" ]] && grep -q 'allow_implicit_invocation:' "$yaml"; then
    echo "MODEL-INVOKED MUST OMIT allow_implicit_invocation: $yaml" >&2
    fail=1
  fi
done

# Ban remote tracker instructions in skill bodies
while IFS= read -r -d '' f; do
  if grep -Eiq 'gh issue|glab issue|linear\.app|github.com/.*/issues' "$f"; then
    echo "REMOTE TRACKER LEAK: $f" >&2
    fail=1
  fi
done < <(find "$SKILLS_DIR" -name SKILL.md -print0 2>/dev/null || true)

if [[ "$fail" -ne 0 ]]; then
  echo "validate-skills: FAILED" >&2
  exit 1
fi
echo "validate-skills: OK"
