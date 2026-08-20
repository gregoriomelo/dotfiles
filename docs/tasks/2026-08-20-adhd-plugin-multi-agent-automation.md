# Task: Automate `i-have-adhd` Multi-Agent Plugin & Skill Installation

**Date:** 2026-08-20

## Goal
Automate the installation and synchronization of the `i-have-adhd` skill and plugin across all AI coding agents in the dotfiles repository (Claude Code, Antigravity CLI, OpenCode, Codex, Gemini CLI, Cursor, and Pi).

## What Was Done
1. **Root Cause Resolution for OpenCode:** Identified that `opencode plugin https://github.com/ayghri/i-have-adhd` was failing because OpenCode's plugin manager expects JS/TS packages with runtime entrypoints, whereas `i-have-adhd` is a Markdown prompt/skill ruleset.
2. **Multi-Agent Plugin Automation:** Updated `scripts/setup-ai-plugins.sh` to correctly register `i-have-adhd` for:
   - **Claude Code:** Registered marketplace `ayghri/i-have-adhd` and installed `i-have-adhd@i-have-adhd`.
   - **Antigravity CLI (`agy`):** Installed `https://github.com/ayghri/i-have-adhd` via `agy plugin install`.
   - **OpenCode:** Configured skill directory linking to `~/.config/opencode/skills/` without triggering the incompatible JS plugin loader.
   - **Codex:** Added `codex plugin marketplace add` and `codex plugin add`.
   - **Gemini CLI:** Added extension installation command.
3. **Stow Package Symlinks for Global Discovery:** Created symlinks in the `ai/` stow package:
   - `ai/.config/opencode/skills` & `rules`
   - `ai/.cursor/skills` & `rules`
   - `ai/.codex/skills` & `rules`
   This ensures that running `make stow` automatically shares all skills (`i-have-adhd`, `task-recorder`, `usage-tracker`, etc.) and rules across OpenCode, Cursor, Codex, Claude, Gemini, Pi, and OpenSpec.
4. **Validation:** Verified skill discovery and executed `scripts/setup-ai-plugins.sh` to confirm clean synchronization.

## Key Decisions
- **Skill Symlinks over Runtime Plugins:** OpenCode discovers skills directly from `~/.config/opencode/skills/`. Managing this through the `ai/` GNU Stow package provides zero-overhead, multi-agent skill consistency without requiring runtime wrappers.
- **Resilient CLI Handling:** `scripts/setup-ai-plugins.sh` checks for CLI binary presence before invoking tool-specific plugin installers, ensuring idempotency across different machines.

## Files Changed
- `scripts/setup-ai-plugins.sh` — Updated plugin & skill automation across all agent CLIs.
- `ai/.config/opencode/` — Symlinked skills and rules for OpenCode.
- `ai/.cursor/` — Symlinked skills and rules for Cursor.
- `ai/.codex/` — Symlinked skills and rules for Codex.
- `docs/tasks/2026-08-20-adhd-plugin-multi-agent-automation.md` — Task summary record.

## Verification
- Verified `i-have-adhd/SKILL.md` is present and accessible across OpenCode, Claude Code, Gemini CLI, Pi, Cursor, Codex, and OpenSpec.
- Executed `scripts/setup-ai-plugins.sh` with zero errors.
- Verified `stow ai` links all agent skill paths cleanly.

## Related Docs
- [Superpowers Automation](../tasks/2026-05-11-superpowers-automation.md)
- [AI Agent Skills Expansion](../tasks/2026-04-21-ai-agent-skills-expansion.md)
- [i-have-adhd Repository](https://github.com/ayghri/i-have-adhd)
