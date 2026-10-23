#!/usr/bin/env bash
set -euo pipefail
DIR="$(cd "$(dirname "$0")" && pwd)"

echo "==> Running Scaffolding Test..."
bash "$DIR/test_scaffolding.sh"

echo "==> Running Makefile Dry-Run Test..."
bash "$DIR/test_makefile.sh"

echo "==> Running Configurations Test..."
bash "$DIR/test_configs.sh"

echo "==> Running Launcher CLI Test..."
bash "$DIR/test_launcher.sh"

echo ""
echo "ALL TESTS PASSED"
