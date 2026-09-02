# Task: Modernize macOS Defaults for macOS Tahoe (macOS 26)

**Date:** 2026-09-01

## Goal
Audit and modernize `scripts/macos-defaults.sh` for macOS Tahoe (macOS 26): clean up obsolete/no-op preferences and add developer-oriented defaults for Finder, Window Manager, TextEdit, Activity Monitor, and Keyboard.

## What Was Done
- **Cleaned Up Deprecated / No-Op Keys:**
  - Removed `NSNavPanelExpandedStateForSaveMode` and `PMPrintingExpandedStateForPrint` (legacy dialog disclosure states no longer used in SwiftUI sheets).
  - Removed `com.apple.LaunchServices LSQuarantine -bool false` (Gatekeeper ignores user defaults; quarantine cleaning is handled per-binary in `make quarantine-clean`).
- **Added Modern Tahoe Developer Defaults:**
  - **Keyboard:** Disabled inline predictive text suggestions (`NSAutomaticInlinePredictionEnabled = false`).
  - **Window Manager & Spaces:** Set click wallpaper to reveal desktop to Stage Manager only (`EnableStandardClickToShowDesktop = false`) to prevent accidental window hiding, disabled automatic space reordering (`mru-spaces = false`), and enabled window grouping by app in Mission Control (`expose-group-apps = true`).
  - **Finder:** Set default search scope to current folder (`FXDefaultSearchScope = "SCcf"`) and disabled file extension change warning (`FXEnableExtensionChangeWarning = false`).
  - **TextEdit:** Configured default mode to plain text (`RichText = 0`).
  - **Activity Monitor:** Configured launch view to display all processes sorted by CPU usage descending (`ShowCategory = 0`, `SortColumn = "CPUUsage"`, `SortDirection = 0`).
- **Documentation:**
  - Updated [README.md](file:///Users/gregoriomelo/dev/dotfiles/README.md) under macOS Defaults.

## Key Decisions
- **Tahoe Window Management & Predictors:** macOS Tahoe introduces inline predictive text and wallpaper click minimization. Disabling these friction points provides a cleaner developer typing and multi-window workflow.
- **Finder & Spaces UX:** Restricting search to active folders and maintaining deterministic Spaces layouts simplifies daily navigation.

## Files Changed
- `scripts/macos-defaults.sh` — Cleaned up deprecated keys and added modern Tahoe defaults.
- `README.md` — Updated macOS defaults reference section.
- `docs/tasks/2026-09-01-modernize-macos-defaults.md` — Created task record.

## Verification
- Executed `bash scripts/macos-defaults.sh` cleanly with zero exit code.
- Verified system defaults with `defaults read com.apple.WindowManager EnableStandardClickToShowDesktop` and `defaults read NSGlobalDomain NSAutomaticInlinePredictionEnabled`.

## Related Docs
- [scripts/macos-defaults.sh](file:///Users/gregoriomelo/dev/dotfiles/scripts/macos-defaults.sh)
- [README.md](file:///Users/gregoriomelo/dev/dotfiles/README.md)
