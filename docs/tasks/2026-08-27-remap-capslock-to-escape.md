# Task: Remap CapsLock to Escape in macOS Defaults

**Date:** 2026-08-27

## Goal
Investigate why macOS defaults appeared not to work when testing CapsLock in Vim, and configure CapsLock to act as Escape (`0x700000029`).

## What Was Done
- **Diagnosis of macOS Defaults & Keyboard Mapping:**
  - Audited all macOS preferences written by `scripts/macos-defaults.sh` (KeyRepeat, PressAndHold, Dock, Finder, Trackpad, Screenshots). Verified that all preferences are active and working.
  - Inspected `hidutil property --get "UserKeyMapping"` and discovered that CapsLock was previously mapped to Left Control (`0x7000000E0`) instead of Escape (`0x700000029`).
- **Remapped CapsLock to Escape:**
  - Updated `scripts/macos-defaults.sh` to map `HIDKeyboardModifierMappingDst` to `0x700000029` (Escape).
  - Updated the launchd LaunchAgent template (`com.local.keyremap.plist`) to persist the CapsLock → Escape remap across reboots.
  - Applied the mapping immediately with `hidutil` and reloaded the LaunchAgent with `launchctl`.
- **Documentation:**
  - Updated [README.md](file:///Users/gregoriomelo/dev/dotfiles/README.md) to explicitly document the CapsLock → Escape mapping under macOS Defaults.

## Key Decisions
- **Escape vs Left Control:** CapsLock mapped to Control does not send an `Escape` keycode in Vim (unless used in combinations like `Ctrl-[`), whereas mapping to `0x700000029` emits native `Escape`, immediately exiting insert mode to normal mode.
- **Immediate + Persistent Execution:** Used `hidutil property --set` for instant effect without requiring logout/restart, and updated `~/Library/LaunchAgents/com.local.keyremap.plist` loaded via `launchctl` to survive reboots.

## Files Changed
- `scripts/macos-defaults.sh` — Updated keymap to `0x700000029` and refreshed LaunchAgent generation.
- `README.md` — Documented CapsLock → Escape mapping under Keyboard defaults.

## Verification
- Ran `hidutil property --get "UserKeyMapping"` and confirmed `HIDKeyboardModifierMappingDst = 30064771113` (`0x700000029`).
- Checked `launchctl list | grep keyremap` and confirmed `com.local.keyremap` is registered and active.

## Related Docs
- [README.md](file:///Users/gregoriomelo/dev/dotfiles/README.md)
- [scripts/macos-defaults.sh](file:///Users/gregoriomelo/dev/dotfiles/scripts/macos-defaults.sh)
