# Task: Bring Claude Code Config into Dotfiles

**Date:** 2026-02-18

## Goal

Version-control user-authored Claude Code configuration via GNU Stow, keeping it portable across machines while leaving Claude-managed state (history, credentials, projects) untouched.

## What Was Done

1. **Fixed `.gitignore`** — Changed `.claude/` to `/.claude/` so only the repo-root local project config is ignored, not the `claude/.claude/` stow package.

2. **Created `claude/` stow package** with 7 files:
   - `.claude/CLAUDE.md` — Global instructions referencing modular rules
   - `.claude/statusline-command.sh` — Custom status line script
   - `.claude/rules/` — 5 instruction modules (git, docs, testing, coding, product)

3. **Removed originals** from `~/.claude/` so stow could create symlinks in their place.

4. **Updated Makefile** — Added `claude` to the stow target.

5. **Updated README.md** — Added directory structure, symlinks table entries, and a Claude Code section.

## Key Decision

Stow uses **tree unfolding** for the `claude` package: since `~/.claude/` already exists with other Claude-managed content, stow creates individual symlinks for each file/directory rather than symlinking the entire `.claude/` directory. This lets version-controlled config coexist with Claude's runtime state.

## Files Changed

- `.gitignore`
- `Makefile`
- `README.md`
- `claude/.claude/CLAUDE.md` (new)
- `claude/.claude/statusline-command.sh` (new)
- `claude/.claude/rules/*.md` (new, 5 files)

## Verification

```bash
ls -la ~/.claude/CLAUDE.md ~/.claude/statusline-command.sh ~/.claude/rules/
```

All symlinks point to `~/dev/dotfiles/claude/.claude/`.

## Note

`claude/.claude/settings.json` was later removed from version control (untracked + gitignored) as it contains Claude-managed preferences that vary per machine.

## Related Docs

- [README.md](../../README.md) — Claude Code section
