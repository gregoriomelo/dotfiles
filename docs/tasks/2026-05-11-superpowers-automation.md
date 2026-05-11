# Task: Automate Superpowers AI Plugin Installation

**Date:** 2026-05-11

## Goal
Automate the installation and configuration of the 'Superpowers' AI agentic dev plugin across multiple AI tools (Claude Code, Gemini CLI, OpenCode) to support 'config as code' principles in the dotfiles repository.

## What Was Done
- Created a central automation script `scripts/setup-ai-plugins.sh` that handles marketplace registration and plugin installation for various AI agents.
- Added an `ai-plugins` target to the `Makefile` to trigger the automation script.
- Integrated the `ai-plugins` target into the main `setup` sequence to ensure plugins are synchronized during environment bootstrapping.

## Key Decisions
- **Automation over Symlinking:** Chose to automate the installation via CLI commands rather than symlinking configuration files (`settings.json`) to avoid managing sensitive information like API keys in version control.
- **Multi-Agent Support:** Designed the script to check for the existence of `claude`, `gemini`, and `opencode` before attempting installation, making the script resilient to different machine setups.
- **Marketplace Integration:** Specifically configured Claude Code to use the official Superpowers marketplace for reliable updates.

## Files Changed
- `scripts/setup-ai-plugins.sh` — New script to automate AI plugin management.
- `Makefile` — Added `ai-plugins` target and integrated it into the `setup` workflow.

## Verification
- Ran `make ai-plugins` successfully, which confirmed the installation of the Superpowers plugin for Claude Code.
- Verified that the script correctly skips agents that are not installed on the system.

## Related Docs
- [Superpowers Repository](https://github.com/obra/superpowers)
