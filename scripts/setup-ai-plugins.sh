#!/bin/bash
# scripts/setup-ai-plugins.sh
# Automates the installation of AI agent plugins (Superpowers)

set -e

echo "Setting up AI agent plugins..."

# Claude Code
if command -v claude &> /dev/null; then
  echo "Checking Claude Code plugins..."
  # Add marketplace if not present
  claude plugin marketplace add obra/superpowers-marketplace 2>/dev/null || true
  # Install/Update superpower plugin
  claude plugin install superpowers@superpowers-marketplace
  claude plugin install https://github.com/ayghri/i-have-adhd 2>/dev/null || true
fi

# Antigravity CLI (agy)
if command -v agy &> /dev/null; then
  echo "Checking Antigravity plugins..."
  # Add marketplace if needed, or just install by URL (agy supports plugin@marketplace or URL)
  agy plugin link obra/superpowers-marketplace https://github.com/obra/superpowers-marketplace 2>/dev/null || true
  agy plugin install superpowers@obra/superpowers-marketplace 2>/dev/null || agy plugin install https://github.com/obra/superpowers 2>/dev/null || true
  agy plugin install https://github.com/ayghri/i-have-adhd 2>/dev/null || true
fi

# OpenCode
if command -v opencode &> /dev/null; then
  echo "Checking OpenCode plugins..."
  opencode plugin https://github.com/obra/superpowers 2>/dev/null || true
  opencode plugin https://github.com/ayghri/i-have-adhd 2>/dev/null || true
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
