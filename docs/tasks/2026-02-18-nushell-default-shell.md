# Task: Make Nushell the Default Shell

**Date:** 2026-02-18

## Summary

Configured Nushell v0.110.0 (already installed via Homebrew) as the default interactive shell, with all current conveniences replicated in native Nu syntax.

## Approach

**Co-location strategy**: Both alias files live in the `aliases/` stow package — one for zsh, one for nushell. A single directory to edit when aliases change.

**macOS-specific behavior**: Nushell on macOS uses `~/Library/Application Support/nushell/` instead of `~/.config/nushell/`. The `nushell-init` Makefile target bridges this by creating symlinks from the macOS config dir to the stow-managed `~/.config/nushell/` files.

**Starship init fix**: The plan used `starship init nu | save -f ...` (nushell syntax), but Makefile runs under `/bin/sh`. Fixed to use `starship init nu > ...` (shell redirect).

## Files Created

- `aliases/.config/nushell/aliases.nu` — nushell alias/function definitions
- `nushell/.config/nushell/env.nu` — PATH, Homebrew, DEV_HOME, DOTFILES_HOME
- `nushell/.config/nushell/config.nu` — starship, direnv, sources aliases
- `docs/nushell.md` — full reference doc

## Files Modified

- `zsh/.zprofile` — added DEV_HOME and DOTFILES_HOME exports
- `Makefile` — added `nushell` to stow target; added `nushell-init` and `default-shell` targets
- `README.md` — updated directory structure, symlinks table, Make targets, added Nushell section

## Key Decisions

1. **Co-location over single-source**: Nushell's incompatible syntax makes a shared alias file impossible. Both files live in `aliases/` to minimize the edit surface.
2. **`~/.config/nushell/` as canonical path**: Stow targets the XDG path; macOS-specific linking is handled as a one-time init step rather than polluting the stow package structure.
3. **`nu -l` for login mode**: When nushell is the login shell, it loads config.nu automatically. `nu -c` without `-l` skips config by design.

## Prompts Used

The plan was authored by Claude Code in plan mode. Implementation prompt:

> "Implement the following plan: [plan content included the full specification]"

## Verification Commands

```bash
# Symlinks
ls -la ~/.config/nushell/
ls -la ~/Library/Application\ Support/nushell/

# Starship cache
ls ~/.cache/starship/init.nu

# Functional test
nu -l -c "g --version"
nu -l -c '$env.DEV_HOME'
nu -l -c '$env.PATH | str join (char nl)' | grep homebrew

# Default shell (after make default-shell)
dscl . -read /Users/gregoriomelo UserShell
```
