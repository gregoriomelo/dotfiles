# Task: Declare mas in Brewfile and Provide Local Gitconfig Example Template

**Date:** 2026-08-27

## Goal
Fix fresh machine setup by ensuring the Mac App Store CLI (`mas`) is installed before any `mas` formulas are evaluated in `Brewfile`, and provide a tracked template for local Git configuration overrides to prevent GPG signing errors on uninitialized machines.

## What Was Done
- Added `brew 'mas'` under `# tooling #` in [Brewfile](file:///Users/gregoriomelo/dev/dotfiles/Brewfile) right after `brew 'stow'`.
- Created [git/.gitconfig.local.example](file:///Users/gregoriomelo/dev/dotfiles/git/.gitconfig.local.example) with overrides for `[user]` signing key and `[commit]` `gpgsign = false`.
- Updated [.gitignore](file:///Users/gregoriomelo/dev/dotfiles/.gitignore) to whitelist `!git/.gitconfig.local.example` while preserving exclusion of `git/.gitconfig.*`.
- Updated [README.md](file:///Users/gregoriomelo/dev/dotfiles/README.md) with:
  - Fresh machine setup note in Quick Start regarding signing into the Mac App Store and handling Git GPG signing.
  - Tracking in Directory Structure and Symlinks Created tables.
  - Dedicated `## Git` section explaining machine-specific overrides.
  - Verification commands for Git configuration.

## Key Decisions
- **Declare `mas` in Tooling:** `mas` applications (like Xcode, Magnet, The Unarchiver) were defined in `Brewfile` without declaring the `mas` CLI formula in the tooling section, causing bundle failures on fresh systems without preinstalled `mas`.
- **Whitelisted Example Pattern:** Maintained the existing pattern established with `.env` / `!.env.example` by un-ignoring `!git/.gitconfig.local.example` while keeping machine-specific `.gitconfig.local` untracked.
- **Action-Oriented Documentation:** Clearly instructed new machine setups to sign into Mac App Store prior to `make setup` and provide quick steps to copy the local template to disable `gpgsign` temporarily until GPG keys are imported.

## Files Changed
- `Brewfile` — Added `brew 'mas'` under tooling.
- `git/.gitconfig.local.example` — Created template for machine-specific git configurations.
- `.gitignore` — Whitelisted `!git/.gitconfig.local.example`.
- `README.md` — Documented fresh machine considerations and local git configuration workflow.
- `docs/tasks/2026-08-27-mas-in-brewfile-and-gitconfig-local-template.md` — Task summary record.

## Verification
- Verified `git check-ignore -v git/.gitconfig.local.example` is not ignored.
- Verified `git check-ignore -v git/.gitconfig.local` remains ignored.
- Verified `git status` shows `git/.gitconfig.local.example` as tracked/stageable.

## Related Docs
- [docs/tasks/2026-05-11-local-git-config.md](file:///Users/gregoriomelo/dev/dotfiles/docs/tasks/2026-05-11-local-git-config.md)
- [README.md](file:///Users/gregoriomelo/dev/dotfiles/README.md)
