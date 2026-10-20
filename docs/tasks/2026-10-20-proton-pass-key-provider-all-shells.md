# Task: Configure PROTON_PASS_KEY_PROVIDER=fs Across All Shells

**Date:** 2026-10-20

## Goal
Ensure `PROTON_PASS_KEY_PROVIDER=fs` is consistently set as code across Nushell, Zsh (login, interactive, and non-interactive subshells), Bash (login and interactive), and bootstrap scripts to prevent keyring/filesystem database key mismatches with `pass-cli`.

## What Was Done
- Created `zsh/.zshenv` and updated `zsh/.zshrc` so all Zsh invocations (including non-login interactive shells and `zsh -c` subshells) export `PROTON_PASS_KEY_PROVIDER=fs`.
- Created a new `bash/` GNU Stow package (`bash/.bashrc` and `bash/.bash_profile`) exporting `PROTON_PASS_KEY_PROVIDER=fs`, configuring Homebrew/environment variables, and sourcing `~/.aliases`.
- Added `$env.PROTON_PASS_KEY_PROVIDER = 'fs'` to `nushell/.config/nushell/config.nu` alongside `nushell/.config/nushell/env.nu`.
- Registered `bash` in `STOW_PACKAGES` and exported `PROTON_PASS_KEY_PROVIDER := fs` in `Makefile` and `scripts/post-setup.sh`.
- Updated `README.md` with the new `bash/` stow package, `.zshenv`, and symlinks.

## Key Decisions
- **Global Zsh Env (`.zshenv`):** Previously, `PROTON_PASS_KEY_PROVIDER=fs` was only in `zsh/.zprofile`, which is skipped in non-login Zsh sessions (such as subshells spawned when Nushell is the login shell or by IDE/AI agents). Placing it in `.zshenv` guarantees every Zsh process inherits the `fs` provider.
- **Dedicated `bash/` Stow Package:** Followed the `@steward` Stow-First Protocol by managing `~/.bashrc` and `~/.bash_profile` under `bash/` so Bash sessions share the same environment and aliases.

## Files Changed
- `zsh/.zshenv` — Added global Zsh environment exports including `PROTON_PASS_KEY_PROVIDER=fs`.
- `zsh/.zshrc` — Added `export PROTON_PASS_KEY_PROVIDER=fs`.
- `bash/.bashrc` — Created Bash interactive configuration with `PROTON_PASS_KEY_PROVIDER=fs`, `CONTEXT7_API_KEY` loading, and `~/.aliases`.
- `bash/.bash_profile` — Created Bash login configuration sourcing `~/.bashrc`.
- `nushell/.config/nushell/config.nu` — Added `$env.PROTON_PASS_KEY_PROVIDER = 'fs'`.
- `Makefile` — Added `bash` to `STOW_PACKAGES` and exported `PROTON_PASS_KEY_PROVIDER := fs`.
- `scripts/post-setup.sh` — Exported `PROTON_PASS_KEY_PROVIDER=fs` prior to `pass-cli info` check.
- `README.md` — Documented `bash/` stow package, `.zshenv`, and task log link.

## Verification
- Stowed `zsh`, `bash`, and `nushell` packages into `$HOME`.
- Verified `PROTON_PASS_KEY_PROVIDER=fs` across clean environments (`env -i`) for `zsh -c`, `zsh -i -c`, `zsh -l -c`, `bash -i -c`, `bash -l -c`, and `nu -l -c`.

## Related Docs
- [README.md](../../README.md)
- [2026-08-19: Integrate Context7 MCP with Secure Pass-CLI Secret Provisioning](2026-08-19-context7-pass-cli-integration.md)
