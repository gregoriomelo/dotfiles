# Task: Install and Integrate Excalidraw Diagram Skill Across All Agents

**Date:** 2026-09-10

## Goal
Install the `excalidraw-diagram` skill (from https://github.com/coleam00/excalidraw-diagram-skill) and make it available across all AI agent runtimes (Claude Code, Gemini CLI, Antigravity, OpenCode, Codex, Pi, Cursor, OpenSpec), configure `uv` in `Brewfile`, and initialize headless Chromium Playwright rendering for automated visual layout validation.

## What Was Done
- **Skill Installation & Parity:**
  - Installed `excalidraw-diagram` into [`ai/skills/excalidraw-diagram/`](file:///Users/gregoriomelo/dev/dotfiles/ai/skills/excalidraw-diagram) including `SKILL.md` and reference assets (`references/color-palette.md`, `references/element-templates.md`, `references/json-schema.md`, `references/pyproject.toml`, `references/render_template.html`, `references/render_excalidraw.py`).
  - Unified agent skills access: created `ai/.agents/` symlinks (`skills -> ../skills`, `rules -> ../rules`) and restowed with GNU Stow so `~/.agents/skills` is shared across all runtimes (Codex, Antigravity, Gemini CLI, etc.).
  - Added `.agents/skills -> ../ai/skills` in the dotfiles workspace root for local workspace discovery.
- **Runtime-Agnostic Invocation:**
  - Updated `SKILL.md` and `render_excalidraw.py` so rendering commands dynamically discover the skill directory across `~/.agents/skills`, `~/.claude/skills`, and `~/skills` with `find -L`.
  - Resolved local pathing and module loading in `render_excalidraw.py` and `render_template.html` by configuring route interception under `https://esm.sh/__render.html` and setting `window.EXCALIDRAW_ASSET_PATH` to ensure clean ES module and font asset resolution.
- **Dependency & Environment Setup:**
  - Added `brew 'uv'` to [`Brewfile`](file:///Users/gregoriomelo/dev/dotfiles/Brewfile) under `# python`.
  - Installed `uv` and initialized the Playwright environment (`playwright==1.62.0`) in `ai/skills/excalidraw-diagram/references/.venv`.
  - Downloaded and cached headless Chromium (`~/Library/Caches/ms-playwright/chromium-1234`).
  - Added automated renderer synchronization to [`scripts/setup-ai-plugins.sh`](file:///Users/gregoriomelo/dev/dotfiles/scripts/setup-ai-plugins.sh).
- **Documentation:**
  - Registered `@excalidraw-diagram` skill in [`AGENTS.md`](file:///Users/gregoriomelo/dev/dotfiles/AGENTS.md) and [`README.md`](file:///Users/gregoriomelo/dev/dotfiles/README.md).

## Key Decisions
- **Unified Stow Symlinks over Duplicate Copies:** Instead of duplicating skill folders across agent directories, leveraged GNU Stow and symlinks (`ai/skills` -> `~/.claude/skills`, `~/.gemini/skills`, `~/.agents/skills`, etc.) as the single source of truth.
- **In-Memory Route Interception for Headless Renderer:** Rather than spinning up a local web server or facing `file://` CORS restrictions with ES modules, used Playwright's `page.route` to fulfill `render_template.html` under `https://esm.sh` origin, enabling clean module loading and instant diagram rendering.

## Files Changed
- `Brewfile` — Added `brew 'uv'`.
- `ai/skills/excalidraw-diagram/` — Skill instruction and reference files.
- `ai/.agents/` — Rules and skills symlinks for `~/.agents` stow mapping.
- `.agents/skills` — Workspace symlink to `../ai/skills`.
- `scripts/setup-ai-plugins.sh` — Automated setup hook for renderer dependencies.
- `AGENTS.md` — Registered `excalidraw-diagram` in skills list.
- `README.md` — Updated directory tree and features list.
- `docs/tasks/2026-09-10-excalidraw-diagram-skill.md` — Task summary.

## Verification
- Verified `uv --version` (`uv 0.12.12`).
- Ran `render_excalidraw.py` with test diagram JSON and verified successful PNG output generation and visual formatting.
- Executed `scripts/setup-ai-plugins.sh` to confirm automation works cleanly without warnings or errors.
- Ran `scripts/health-check.sh` to verify symlink integrity.

## Related Docs
- [AGENTS.md](../../AGENTS.md)
- [README.md](../../README.md)
- [ai/skills/excalidraw-diagram/SKILL.md](../../ai/skills/excalidraw-diagram/SKILL.md)
