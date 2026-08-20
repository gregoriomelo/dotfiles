#!/bin/bash
# scripts/setup-ai-plugins.sh
# Automates the installation of AI agent plugins and skills (Superpowers, i-have-adhd, Context7)

set -e

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
    ln -sf "$HOME/dev/dotfiles/ai/skills/i-have-adhd" "$HOME/.config/opencode/skills/i-have-adhd" 2>/dev/null || true
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
  
  if [ -z "$CONTEXT7_API_KEY" ] && command -v pass-cli &>/dev/null; then
    export PROTON_PASS_KEY_PROVIDER=fs
    CONTEXT7_API_KEY="$(pass-cli item view "pass://Personal/Context7/password" 2>/dev/null || true)"
  fi

  if [ -n "$CONTEXT7_API_KEY" ]; then
    npx ctx7 setup --claude --cursor --antigravity --opencode --gemini --mcp -y --api-key "$CONTEXT7_API_KEY" 2>/dev/null || true
  fi
fi

echo "✅ AI agent plugins synchronized."
