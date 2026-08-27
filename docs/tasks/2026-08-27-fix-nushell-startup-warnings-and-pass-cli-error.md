# Task: Fix Nushell Startup Warnings and Pass-CLI Session Error

**Date:** 2026-08-27

## Goal
Eliminate shell startup errors caused by unauthenticated Proton Pass CLI (`pass-cli`) and resolve the Nushell configuration warning regarding duplicate Atuin keybinding names.

## What Was Done
- **Proton Pass CLI Graceful Fallback (`env.nu`):**
  - Updated `nushell/.config/nushell/env.nu` to check `.env` (in `$DOTFILES_HOME` and `$HOME`) before invoking `pass-cli`.
  - Wrapped `pass-cli item view` execution with `do { pass-cli ... } | complete` to silently capture output and prevent stderr error spam when `pass-cli` has no active session or is unauthenticated.
- **Unique Atuin Keybinding Identifiers (`atuin.nu`):**
  - Renamed the Ctrl+R keybinding from `atuin` to `atuin_search`.
  - Renamed the Up-arrow keybinding from `atuin` to `atuin_up_search`.
  - Silenced the Nushell `nu::shell::shared_keybindings_name` warning while retaining full Atuin history search functionality.
- **Documentation:**
  - Updated `docs/nushell.md` configuration files table to list `atuin.nu` and `CONTEXT7_API_KEY`.

## Key Decisions
- **`do { ... } | complete` vs `try { ... }`:** In Nushell, `try` catches pipeline errors but external commands still stream stderr directly to the terminal. Using `(do { pass-cli ... } | complete)` captures stdout, stderr, and exit status safely, allowing the shell to fall back cleanly without polluting interactive logins.
- **Distinct Atuin Keybinding Names:** Nushell validates that all bindings in `$env.config.keybindings` have unique `name` properties. Giving distinct descriptive names (`atuin_search` and `atuin_up_search`) satisfies the validator without altering key events or bindings.

## Files Changed
- `nushell/.config/nushell/env.nu` — Added `.env` fallback and silent `pass-cli` completion handling.
- `nushell/.config/nushell/atuin.nu` — Changed duplicate `atuin` keybinding names to `atuin_search` and `atuin_up_search`.
- `docs/nushell.md` — Documented `atuin.nu` and `CONTEXT7_API_KEY` in Nushell configs.

## Verification
- Ran `nu --interactive --login -c 'echo "startup test successful"'` and verified clean startup with zero warnings or errors.
- Ran `bash scripts/health-check.sh` and confirmed all symlinks and environment checks passed.

## Related Docs
- [docs/nushell.md](file:///Users/gregoriomelo/dev/dotfiles/docs/nushell.md)
- [docs/tasks/2026-08-27-env-fallback-for-ai-plugins.md](file:///Users/gregoriomelo/dev/dotfiles/docs/tasks/2026-08-27-env-fallback-for-ai-plugins.md)
- [README.md](file:///Users/gregoriomelo/dev/dotfiles/README.md)
