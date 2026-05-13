# Task: Git Commit Assistant Skill & Configuration Centralization

**Date:** 2026-05-13

## Goal
Transform static git commit rules into an interactive agent skill and centralize AI agent configurations (rules and skills) using GNU Stow for better maintainability across multiple agents (Gemini, Claude, Pi).

## What Was Done
- Created the `git-commit-assistant` skill with a structured workflow and a helper script for drafting messages with AI trailers.
- Centralized `rules/` and `skills/` into a new `ai/` package at the repository root.
- Set up a mirrored directory structure in `ai/` (`.gemini/`, `.claude/`, `.pi/agent/`) to enable cross-agent distribution via Stow.
- Updated the `Makefile` to include the `ai` package in `STOW_PACKAGES`.
- Simplified `ai/rules/git.md` by delegating procedural details (formatting, trailers) to the new skill.
- Removed redundant symlinks from individual agent packages (`gemini/`, `claude/`, `pi/`) in favor of the centralized `ai` package.

## Key Decisions
- **Skill over Rules**: Codifying procedural rules as a skill makes them actionable and reduces the token cost of the base "rules" file.
- **Centralized Package**: Using a dedicated `ai/` package with GNU Stow allows for a single source of truth that is automatically distributed to the correct hidden paths in the home directory.
- **Stow mirror**: Creating the hidden directories inside the `ai/` package ensures that `stow` correctly maps them to `~/.gemini`, `~/.claude`, etc., without colliding with other dotfiles.

## Files Changed
- `ai/skills/git-commit-assistant/SKILL.md` — new skill definition
- `ai/skills/git-commit-assistant/scripts/generate-commit-message.cjs` — helper script for commit drafting
- `ai/rules/git.md` — simplified rules delegating to the skill
- `Makefile` — added `ai` to `STOW_PACKAGES`
- `ai/.gemini/rules`, `ai/.gemini/skills`, etc. — new symlinks for Stow distribution
- `gemini/.gemini/rules`, `claude/.claude/rules`, etc. — removed redundant links

## Verification
- Ran `make stow` to verify successful symlinking to the home directory.
- Checked `~/.gemini/skills/git-commit-assistant` and verified it points back to the repo.
- Verified that `ai/rules/git.md` is updated and concise.

## Related Docs
- `ai/rules/git.md`
- `ai/skills/git-commit-assistant/SKILL.md`
