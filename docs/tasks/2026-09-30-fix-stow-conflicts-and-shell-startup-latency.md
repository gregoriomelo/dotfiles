# Task: Fix GNU Stow Conflicts and Shell Startup Latency

**Date:** 2026-09-30

## Goal
Resolve GNU Stow conflicts when stowing `ai/.agents/skills` over existing unmanaged directories in `$HOME`, and eliminate the 5-6 second startup latency experienced when opening new sessions in Ghostty.

## What Was Done
- **GNU Stow Conflict Resolution:**
  - Diagnosed Stow failure when linking `ai/.agents/skills` over a pre-existing physical directory (`~/.agents/skills`) containing unmanaged duplicate files.
  - Enhanced `clean-stow-conflicts` in [`Makefile`](file:///Users/gregoriomelo/dev/dotfiles/Makefile) to:
    - Ensure `$HOME/.agents` container directory exists.
    - Inspect package symlinks (`find $$pkg -type l`) to identify and remove unmanaged physical directories or stray files blocking symlinks.
  - Cleaned the conflicting unmanaged directory and restowed dotfiles so `~/.agents/rules` and `~/.agents/skills` are cleanly symlinked to dotfiles.
- **Shell Startup Latency Optimization:**
  - Isolated Ghostty startup latency to synchronous `pass-cli item view` execution inside shell startup scripts ([`nushell/.config/nushell/env.nu`](file:///Users/gregoriomelo/dev/dotfiles/nushell/.config/nushell/env.nu) and [`zsh/.zprofile`](file:///Users/gregoriomelo/dev/dotfiles/zsh/.zprofile)).
  - Created a local gitignored [`.env`](file:///Users/gregoriomelo/dev/dotfiles/.env) with `CONTEXT7_API_KEY`.
  - Added automatic `.env` caching to `env.nu` and `zsh/.zprofile` so any key retrieved from `pass-cli` on cold boot is saved locally, eliminating subsequent lookups.
  - Added `.env` file fallback checks in `zsh/.zprofile` prior to invoking `pass-cli`.

## Key Decisions
- **Unified Directory Container for Agents:** Treated `~/.agents` like `~/.claude` and `~/.gemini` by ensuring the container directory exists while symlinking its internal `rules` and `skills` directories to dotfiles.
- **Auto-Caching Secrets to Local `.env`:** Instead of removing `pass-cli` support or forcing manual setup, shell startup scripts now cache retrieved credentials once into gitignored `.env`, reducing subsequent startup from ~6 seconds down to ~25 milliseconds.

## Files Changed
- `Makefile` — Enhanced `clean-stow-conflicts` to handle package symlinks and ensure `~/.agents` directory.
- `nushell/.config/nushell/env.nu` — Added auto-caching of `CONTEXT7_API_KEY` to `.env`.
- `zsh/.zprofile` — Added `.env` resolution and auto-caching prior to `pass-cli` fallback.
- `docs/tasks/2026-09-30-fix-stow-conflicts-and-shell-startup-latency.md` — This task summary.

## Verification
- Verified `make clean-stow-conflicts` removes conflicting directories safely.
- Verified `make stow` symlinks all packages with zero warnings/errors.
- Verified `make health-check` passes all symlink and environment checks.
- Benchmarked shell startup:
  - Nushell interactive login: from 5.94s down to 0.022s (~270x faster).
  - Zsh interactive login: from 6.86s down to 0.064s (~107x faster).
