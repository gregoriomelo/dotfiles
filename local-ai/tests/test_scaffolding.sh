#!/usr/bin/env bash
set -euo pipefail
DIR="$(cd "$(dirname "$0")/.." && pwd)"

# Verify Brewfile contains ollama and opencode, and NOT aider
grep -q 'brew "ollama"' "$DIR/Brewfile"
grep -q 'brew "opencode"' "$DIR/Brewfile"
if grep -q 'aider' "$DIR/Brewfile"; then
  echo "FAIL: aider still in Brewfile" >&2
  exit 1
fi

# Verify models.manifest contains qwen3-coder:30b
grep -q 'qwen3-coder:30b' "$DIR/models.manifest"
echo "PASS: scaffolding test"
