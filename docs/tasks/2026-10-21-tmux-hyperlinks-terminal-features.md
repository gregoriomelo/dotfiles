# Task: Enable Terminal Hyperlinks in Tmux

**Date:** 2026-10-21

## Goal
Enable OSC 8 terminal hyperlink passthrough in tmux so URLs and formatted links printed by CLI tools (Git, GitHub CLI, compilers, etc.) can be clicked directly in terminal emulators like Ghostty.

## What Was Done
- Configured `set -as terminal-features ",*:hyperlinks"` in `tmux/.tmux.conf`.
- Reloaded active tmux server configuration.
- Updated `README.md` task logs list.

## Key Decisions
- **Terminal Features Hyperlinks (`terminal-features`):** In tmux 3.4+, OSC 8 hyperlink escape sequences are discarded by default unless explicitly permitted in `terminal-features`. Using `,*:hyperlinks` enables hyperlink support across all outer terminal emulators.

## Files Changed
- `tmux/.tmux.conf` — Added `set -as terminal-features ",*:hyperlinks"`.
- `README.md` — Added task link.

## Verification
- Checked `tmux show -s terminal-features` to confirm `*:hyperlinks` is active in the running tmux server.
- Verified plain text URLs can also be clicked via Ghostty's mouse-capture bypass shortcut (`Shift + Cmd + Click`).

## Related Docs
- [docs/tmux.md](../tmux.md)
- [README.md](../../README.md)
