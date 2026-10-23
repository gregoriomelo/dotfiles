#!/usr/bin/env bash
set -euo pipefail
DIR="$(cd "$(dirname "$0")/.." && pwd)"

# Verify aider.conf.yml is removed
if [[ -f "$DIR/config/aider.conf.yml" ]]; then
  echo "FAIL: aider.conf.yml still exists" >&2
  exit 1
fi

# Verify JSON syntax
python3 -m json.tool "$DIR/config/opencode-provider.json" >/dev/null
python3 -m json.tool "$DIR/config/pi-settings-snippet.json" >/dev/null

echo "PASS: configs test"
