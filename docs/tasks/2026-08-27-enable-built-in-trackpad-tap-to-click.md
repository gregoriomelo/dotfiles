# Task: Enable Tap-to-Click on Built-in Trackpads

**Date:** 2026-08-27

## Goal
Ensure tap-to-click is properly enabled for built-in MacBook trackpads as well as external Bluetooth trackpads when applying macOS defaults.

## What Was Done
- **Diagnosis of Trackpad Preferences:**
  - `scripts/macos-defaults.sh` previously only wrote to `com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true`.
  - On MacBooks without an external Bluetooth trackpad, this left `com.apple.AppleMultitouchTrackpad Clicking` unset (defaulting to false / `0`).
- **Configuration Updates:**
  - Added `defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true` for built-in multitouch trackpads.
  - Added `defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1` and `defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1` for host-level consistency.
- **Documentation:**
  - Preserved existing documentation in [README.md](file:///Users/gregoriomelo/dev/dotfiles/README.md) under macOS Defaults.

## Key Decisions
- **Current Host Domain:** macOS stores per-host pointer preferences under `com.apple.mouse.tapBehavior` in `ByHost`. Setting `-currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1` ensures system-wide UI processes honor tap-to-click immediately.

## Files Changed
- `scripts/macos-defaults.sh` — Added built-in trackpad domain and currentHost defaults.

## Verification
- Ran `defaults read com.apple.AppleMultitouchTrackpad Clicking` and confirmed value `1`.
- Verified script syntax with `bash -n scripts/macos-defaults.sh`.

## Related Docs
- [scripts/macos-defaults.sh](file:///Users/gregoriomelo/dev/dotfiles/scripts/macos-defaults.sh)
- [README.md](file:///Users/gregoriomelo/dev/dotfiles/README.md)
