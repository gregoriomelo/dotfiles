# Task: Configure Shell History Limit and Real-Time Sync

**Date:** 2026-07-14

## Goal
Configure command history to exceed 10,000 lines for Zsh and Nushell, and set up real-time history sharing between them.

## What Was Done
- Modified `Brewfile` to install the `atuin` package via Homebrew.
- Updated `zsh/.zshrc` to increase local history limits to 100,000 lines, configure standard history options, and dynamically load the Atuin integration if the binary is present.
- Updated `nushell/.config/nushell/config.nu` to set fallback local history limits to 100,000 lines and source the static Atuin integration.
- Created `nushell/.config/nushell/atuin.nu` containing the static output of `atuin init nu` to allow parse-time resolution.
- Created the `atuin` Stow package under `atuin/.config/atuin/config.toml` to version-control Atuin configurations (fuzzy mode, compact style, sync settings).
- Updated the `Makefile` to include the `atuin` package in `STOW_PACKAGES`.
- Re-ran `make stow` to symlink all configurations to `$HOME`.

## Key Decisions
- **100,000 lines history limit**: Configured local fallback limits to 100,000 lines, ensuring plenty of space.
- **Atuin integration**: Added Atuin for real-time history sharing, resolving the format incompatibility between Zsh (`~/.zsh_history`) and Nushell (SQLite database).
- **Static Atuin Nu config**: Saved the output of `atuin init nu` as a version-controlled file `nushell/.config/nushell/atuin.nu` instead of evaluating it dynamically at startup. This conforms to Nushell's parse-time constant constraints and avoids shell startup delays.
- **Atuin Config-as-Code**: Put the Atuin `config.toml` under a version-controlled `atuin` package to ensure full portability across development environments.

## Files Changed
- [Brewfile](file:///Users/gregoriomelo/dev/dotfiles/Brewfile) — Added `atuin` Homebrew dependency.
- [Makefile](file:///Users/gregoriomelo/dev/dotfiles/Makefile) — Added `atuin` to `STOW_PACKAGES`.
- [atuin/.config/atuin/config.toml](file:///Users/gregoriomelo/dev/dotfiles/atuin/.config/atuin/config.toml) — Added version-controlled Atuin configuration file.
- [nushell/.config/nushell/config.nu](file:///Users/gregoriomelo/dev/dotfiles/nushell/.config/nushell/config.nu) — Configured fallback SQLite history settings and loaded Atuin.
- [nushell/.config/nushell/atuin.nu](file:///Users/gregoriomelo/dev/dotfiles/nushell/.config/nushell/atuin.nu) — Version-controlled static Nushell integration script.
- [zsh/.zshrc](file:///Users/gregoriomelo/dev/dotfiles/zsh/.zshrc) — Added 100,000 lines limit, setopts, and Atuin integration.

## Verification
- Run `zsh -n ~/.zshrc` to confirm syntax is clean.
- Run `nu -c 'echo "Loaded"'` to confirm Nushell starts up and parses config cleanly.
- Try running commands in Zsh or Nushell, and run `history` or search with `Ctrl+R` to see history sync (or check `atuin doctor` to verify correct setup).

## Related Docs
- [docs/nushell.md](file:///Users/gregoriomelo/dev/dotfiles/docs/nushell.md) — Shell command reference.
