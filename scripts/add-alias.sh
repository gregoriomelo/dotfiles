#!/bin/bash
# scripts/add-alias.sh
# Adds an alias to both Zsh and Nushell configurations

NAME=$1
COMMAND=$2

if [ -z "$NAME" ] || [ -z "$COMMAND" ]; then
  echo "Usage: $0 <name> <command>"
  echo "Example: $0 gs 'git status'"
  exit 1
fi

# Determine absolute paths
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ZSH_FILE="$DOTFILES_DIR/aliases/.aliases"
NU_FILE="$DOTFILES_DIR/aliases/.config/nushell/aliases.nu"

# Append to Zsh
echo "alias $NAME=\"$COMMAND\"" >> "$ZSH_FILE"

# Append to Nushell
echo "alias $NAME = $COMMAND" >> "$NU_FILE"

echo "✅ Alias '$NAME' successfully added to Zsh and Nushell configurations."
