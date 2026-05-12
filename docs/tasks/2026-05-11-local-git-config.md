# Task: Setup Local Git Configuration Pattern

**Date:** 2026-05-11

## Goal
Establish a pattern for machine-specific or private git configuration that is not committed to the repository, allowing for sensitive info (like private emails) to be handled safely.

## What Was Done
- Modified `git/.gitconfig` to include `~/.gitconfig.local`.
- Created a template `git/.gitconfig.local` file (ignored by git).
- Updated `.gitignore` to ensure `git/.gitconfig.local` is never tracked.
- Refreshed symlinks using `make stow` to link the new local config file.

## Key Decisions
- **Include Pattern:** Used the `[include]` directive in the main `.gitconfig` so that local overrides are automatically picked up by git.
- **Gitignore Safety:** Added the file specifically to `.gitignore` to prevent accidental commits of private data.
- **Stow Integration:** Kept the file within the `git/` folder structure so it is managed by GNU Stow alongside other git configurations.

## Files Changed
- `.gitignore` — added `git/.gitconfig.local`.
- `git/.gitconfig` — added `[include]` for the local file.
- `git/.gitconfig.local` — created local-only config template.

## Verification
- Verified with `git config --list --show-origin` (manually) that settings in the local file override or augment global ones.
- Confirmed the symlink exists in `~/`.

## Related Docs
- [Git Include Documentation](https://git-scm.com/docs/git-config#_includes)
