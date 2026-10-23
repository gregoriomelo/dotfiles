#!/usr/bin/env bash
set -euo pipefail
DIR="$(cd "$(dirname "$0")/.." && pwd)"

# Test dry-run of core targets
make -C "$DIR" -n setup >/dev/null
make -C "$DIR" -n models >/dev/null
make -C "$DIR" -n upgrade >/dev/null
make -C "$DIR" -n fit >/dev/null
make -C "$DIR" -n serve >/dev/null
make -C "$DIR" -n status >/dev/null
echo "PASS: Makefile dry-run test"
