#!/bin/bash
# scripts/setup-ai-plugins.sh
# Automates the installation of AI agent plugins and skills (Superpowers, i-have-adhd, Context7)

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "Setting up AI agent plugins and skills..."

# Claude Code
if command -v claude &> /dev/null; then
  echo "Checking Claude Code plugins..."
  # Superpowers marketplace & plugin
  claude plugin marketplace add obra/superpowers-marketplace 2>/dev/null || true
  claude plugin install superpowers@superpowers-marketplace 2>/dev/null || true
  # i-have-adhd marketplace & plugin
  claude plugin marketplace add ayghri/i-have-adhd 2>/dev/null || true
  claude plugin install i-have-adhd@i-have-adhd 2>/dev/null || true
fi

# Antigravity CLI (agy)
if command -v agy &> /dev/null; then
  echo "Checking Antigravity plugins..."
  agy plugin link obra/superpowers-marketplace https://github.com/obra/superpowers-marketplace 2>/dev/null || true
  agy plugin install superpowers@obra/superpowers-marketplace 2>/dev/null || agy plugin install https://github.com/obra/superpowers 2>/dev/null || true
  agy plugin install https://github.com/ayghri/i-have-adhd 2>/dev/null || true
fi

# OpenCode
if command -v opencode &> /dev/null; then
  echo "Checking OpenCode plugins & skills..."
  opencode plugin https://github.com/obra/superpowers 2>/dev/null || true
  mkdir -p "$HOME/.config/opencode/skills"
  if [ ! -L "$HOME/.config/opencode/skills" ] && [ ! -d "$HOME/.config/opencode/skills/i-have-adhd" ]; then
    ln -sf "$DOTFILES_DIR/ai/skills/i-have-adhd" "$HOME/.config/opencode/skills/i-have-adhd" 2>/dev/null || true
  fi
fi

# Codex
if command -v codex &> /dev/null; then
  echo "Checking Codex plugins..."
  codex plugin marketplace add ayghri/i-have-adhd --ref main 2>/dev/null || true
  codex plugin add i-have-adhd@i-have-adhd 2>/dev/null || true
fi

# Gemini CLI
if command -v gemini &> /dev/null; then
  echo "Checking Gemini CLI extensions & commands..."
  gemini extensions install https://github.com/ayghri/i-have-adhd 2>/dev/null || true
fi

# Context7 (Documentation MCP)
if command -v npx &> /dev/null; then
  echo "Checking Context7 MCP integrations..."
  
  # 1. Fallback to .env in dotfiles root or HOME if CONTEXT7_API_KEY is not already in environment
  if [ -z "$CONTEXT7_API_KEY" ]; then
    for env_file in "$DOTFILES_DIR/.env" "$HOME/.env"; do
      if [ -f "$env_file" ]; then
        val="$(grep -E '^[[:space:]]*(export[[:space:]]+)?CONTEXT7_API_KEY[[:space:]]*=' "$env_file" 2>/dev/null | tail -n 1 | sed -E 's/^[[:space:]]*(export[[:space:]]+)?CONTEXT7_API_KEY[[:space:]]*=[[:space:]]*//' | tr -d '"' | tr -d "'" | tr -d '\r' | xargs)"
        if [ -n "$val" ]; then
          CONTEXT7_API_KEY="$val"
          break
        fi
      fi
    done
  fi

  # 2. Fallback to pass-cli only if installed, authenticated, and usable (fail safely)
  if [ -z "$CONTEXT7_API_KEY" ] && command -v pass-cli &>/dev/null; then
    export PROTON_PASS_KEY_PROVIDER=fs
    # Ensure pass-cli is authenticated and does not prompt interactively
    if pass-cli info >/dev/null 2>&1 < /dev/null; then
      CONTEXT7_API_KEY="$(pass-cli item view "pass://Personal/Context7/password" < /dev/null 2>/dev/null || true)"
    fi
  fi

  # 3. Setup Context7 if key is available; otherwise skip gracefully without errors
  if [ -n "$CONTEXT7_API_KEY" ]; then
    npx ctx7 setup --claude --cursor --antigravity --opencode --gemini --mcp -y --api-key "$CONTEXT7_API_KEY" 2>/dev/null || true
  else
    echo "⚠️ CONTEXT7_API_KEY not found in environment, .env, or pass-cli. Skipping Context7 setup."
  fi
fi

echo "✅ AI agent plugins synchronized."
