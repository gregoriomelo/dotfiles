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
fi

# Gemini CLI
if command -v gemini &> /dev/null; then
  echo "Checking Gemini CLI extensions..."
  # Install with --consent to bypass interactive prompts in scripts
  gemini extensions install https://github.com/obra/superpowers --auto-update --consent 2>/dev/null || true
fi

# OpenCode
if command -v opencode &> /dev/null; then
  echo "Checking OpenCode plugins..."
  opencode plugin https://github.com/obra/superpowers 2>/dev/null || true
fi

echo "✅ AI agent plugins synchronized."
