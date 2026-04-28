#!/bin/bash
# scripts/health-check.sh
# Runs a suite of validation tests to ensure dotfiles and machine state are in sync

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ERRORS=0

echo "🔍 Running Health Check..."

echo ""
echo "[1/4] Checking Symlink Integrity..."
# We search for broken symlinks in the home directory that point to dev/dotfiles
BROKEN_LINKS=$(find "$HOME" -maxdepth 3 -type l -exec sh -c 'for x; do [ ! -e "$x" ] && readlink "$x" | grep -q "dev/dotfiles" && echo "$x"; done' _ {} +)
if [ -n "$BROKEN_LINKS" ]; then
    echo "❌ Found broken symlinks:"
    echo "$BROKEN_LINKS"
    ERRORS=$((ERRORS+1))
else
    echo "✅ All symlinks are healthy."
fi

echo ""
echo "[2/4] Checking Homebrew Sync..."
if command -v brew >/dev/null 2>&1; then
    if brew bundle check --file="$DOTFILES_DIR/Brewfile" >/dev/null 2>&1; then
        echo "✅ Brewfile is in sync with installed packages."
    else
        echo "❌ Brewfile is out of sync. Run 'make brew' to fix."
        ERRORS=$((ERRORS+1))
    fi
else
    echo "❌ Homebrew is not installed."
    ERRORS=$((ERRORS+1))
fi

echo ""
echo "[3/4] Checking Nushell Environment..."
if [ -f "$HOME/.cache/starship/init.nu" ]; then
    echo "✅ Starship cache for Nushell exists."
else
    echo "❌ Missing ~/.cache/starship/init.nu. Run 'make nushell-init' to fix."
    ERRORS=$((ERRORS+1))
fi

echo ""
echo "[4/4] Checking Git Status..."
cd "$DOTFILES_DIR" || exit
if [ -z "$(git status --porcelain)" ]; then
    echo "✅ Git working directory is clean."
else
    echo "⚠️ Git has unstaged or untracked changes."
fi

echo ""
if [ "$ERRORS" -eq 0 ]; then
    echo "🎉 Environment is HEALTHY."
    exit 0
else
    echo "💥 Environment has $ERRORS issue(s). Please review the logs above."
    exit 1
fi
