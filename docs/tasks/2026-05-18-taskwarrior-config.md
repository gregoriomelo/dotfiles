# Task: Taskwarrior Configuration

**Date:** 2026-05-18

## Goal
Configure Taskwarrior using a GNU Stow package with a light theme, integrating it into the existing Makefile setup to match the project's configuration patterns.

## What Was Done
- Created a new `task` stow package directory.
- Implemented `task/.taskrc` with project-consistent settings (2-space indentation, light-256 theme).
- Updated `Makefile` to include `task` in `STOW_PACKAGES`.
- Added a `task-init` target to the `Makefile` to bootstrap the `~/.task` directory non-interactively.
- Integrated `task-init` into the main `setup` target.
- Verified the configuration by running `make stow` and `make task-init`.

## Key Decisions
- **Stow Package:** Followed the repository's convention of using GNU Stow for dotfiles management by creating a dedicated `task` package.
- **Theme Choice:** Selected the `light-256` theme to ensure visual consistency with the Ghostty Light Owl theme and the light-themed tmux panes.
- **Bootstrapping:** Added the `task-init` target to handle the creation of the `~/.task` data directory and perform initial non-interactive setup, avoiding interactive prompts during the bootstrap process.

## Files Changed
- `task/.taskrc` — New configuration file for Taskwarrior.
- `Makefile` — Added `task` package and `task-init` target.
- `Brewfile` — Verified `task` inclusion (proactively maintained by subagent).

## Verification
- Run `task version` to verify Taskwarrior is functional.
- Run `task diagnostics` to check configuration and theme loading.
- Run `ls -la ~/.taskrc` to verify the symlink.

## Related Docs
- `README.md`
- `docs/vim.md` — Reference for 2-space indentation preference.
