# Task: AI Agent Skills Expansion

**Date:** 2026-04-21

## Goal
Expand the project-scoped AI agent capabilities by adding specialized skills for alias synchronization, macOS configuration, Homebrew management, and environment health checks.

## What Was Done
1.  **alias-sync Skill:** Created `ai/skills/alias-sync/SKILL.md` to automate the synchronization of shell aliases between Zsh (`.aliases`) and Nushell (`aliases.nu`).
2.  **@macos Subagent:** Created `.agents/macos.md` as a specialist for `defaults` commands and `scripts/macos-defaults.sh` maintenance.
3.  **brew-sync Skill:** Created `ai/skills/brew-sync/SKILL.md` to ensure the `Brewfile` stays in sync with installed packages.
4.  **health-check Skill:** Created `ai/skills/health-check/SKILL.md` to run a validation suite across symlinks, Homebrew, and shell environments.
5.  **Manifest Update:** Updated `AGENTS.md` and `README.md` to document the new subagent and skills.

## Key Decisions
- **Cross-Shell Consistency:** The `alias-sync` skill explicitly handles the syntax differences between POSIX Zsh and structured Nushell.
- **Automation First:** The `@macos` subagent is instructed to prioritize `defaults write` commands over manual UI steps.
- **Verification Suite:** The `health-check` skill provides a single command to verify the integrity of the entire dotfiles installation.

## Files Changed
- `.agents/macos.md` (new)
- `ai/skills/alias-sync/SKILL.md` (new)
- `ai/skills/brew-sync/SKILL.md` (new)
- `ai/skills/health-check/SKILL.md` (new)
- `AGENTS.md`
- `README.md`

## Verification
- Verified all new files exist in their respective directories.
- Verified `AGENTS.md` and `README.md` descriptions are accurate.
- Run `git status` to confirm all new configuration is tracked.

## Related Docs
- [README.md](../../README.md)
- [AGENTS.md](../../AGENTS.md)
