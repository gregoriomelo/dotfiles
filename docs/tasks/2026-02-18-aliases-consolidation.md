# Task: Consolidate Shell Aliases into Dotfiles

**Date:** 2026-02-18
**Status:** Completed

## Context

Shell aliases (including `g`=`git`, docker-compose shortcuts, etc.) were living in `~/dev/aliases` — a file outside the dotfiles repo and not version-controlled. The `.zshrc` sourced it via `source ~/dev/aliases`. This meant aliases weren't backed up, weren't stowed, and weren't managed alongside the rest of the dotfiles.

## Goal

Bring aliases fully into the dotfiles repo as a proper stow package so they are:
- Version-controlled in git
- Managed via GNU Stow like all other dotfiles
- Automatically symlinked on fresh machine setup

## Prompts Used

1. Initial prompt: User provided a detailed plan document describing the approach, files to modify/create, steps, and verification criteria.

## What Was Done

### Files Created

- **`aliases/.aliases`** — New stow package containing all aliases verbatim from `~/dev/aliases`

### Files Modified

- **`zsh/.zshrc`** — Changed `source ~/dev/aliases` → `source ~/.aliases`
- **`Makefile`** — Added `aliases` to the stow target: `stow ... aliases zsh git tmux glow`
- **`README.md`** — Added `aliases/` to the directory structure, symlinks table, and verification command

### Files Removed

- **`~/dev/aliases`** — Deleted after verifying the symlink worked correctly

## Verification

```bash
# Symlink confirmed:
ls -la ~/.aliases
# lrwxr-xr-x  ~/.aliases -> dev/dotfiles/aliases/.aliases

readlink ~/.aliases
# dev/dotfiles/aliases/.aliases

# Aliases load correctly:
source ~/.aliases
alias g
# g=git
```

## Related Docs

- [README.md](../../README.md) — Updated with aliases package info
- [Makefile](../../Makefile) — Updated stow target
