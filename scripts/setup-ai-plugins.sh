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

echo "✅ AI agent plugins synchronized."
