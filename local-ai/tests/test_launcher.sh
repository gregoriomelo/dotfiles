#!/usr/bin/env bash
set -euo pipefail
DIR="$(cd "$(dirname "$0")/.." && pwd)"
BIN="$DIR/bin/local-ai"

test -x "$BIN"
# Verify help flag works
HELP_OUT="$("$BIN" --help)"
echo "$HELP_OUT" | grep -q "Usage: local-ai"

# Verify dry-run check mode
CHECK_OUT="$("$BIN" --check)"
echo "$CHECK_OUT" | grep -q "models configured in manifest"

# Verify opencode model selection is respected if ollama & opencode are available
if command -v opencode >/dev/null 2>&1 && curl -s -f http://localhost:11434/api/tags >/dev/null 2>&1; then
  MODEL_OUT="$("$BIN" -a opencode -m qwen3-coder:30b -- api model.default)"
  echo "$MODEL_OUT" | grep -q '"id":"qwen3-coder:30b"'
fi

echo "PASS: launcher test"
