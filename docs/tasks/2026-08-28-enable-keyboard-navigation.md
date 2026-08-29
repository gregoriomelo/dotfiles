# Task: Enable macOS Keyboard Navigation Programmatically

**Date:** 2026-08-28

## Goal
Enable the macOS "Keyboard navigation" setting programmatically to allow `Tab` to cycle focus across all UI controls (buttons, checkboxes, text fields), and persist this configuration within the dotfiles repository.

## What Was Done
- **Investigated Preference Domain and Key:**
  - Verified that macOS controls the "Keyboard navigation" toggle via `NSGlobalDomain` key `AppleKeyboardUIMode`.
  - Confirmed that setting `AppleKeyboardUIMode -int 2` turns on navigation between all controls.
- **Configured and Applied Preference:**
  - Added `defaults write NSGlobalDomain AppleKeyboardUIMode -int 2` to [scripts/macos-defaults.sh](file:///Users/gregoriomelo/dev/dotfiles/scripts/macos-defaults.sh#L18-L19).
  - Executed the `defaults write` command immediately on the local system and confirmed with `defaults read`.
- **Documentation:**
  - Updated [README.md](file:///Users/gregoriomelo/dev/dotfiles/README.md#L225-L230) to document the keyboard navigation behavior under the Keyboard section.

## Key Decisions
- **Preference Key:** Used `NSGlobalDomain AppleKeyboardUIMode -int 2`. A value of `2` activates full control navigation across dialogs and windows in macOS, matching Apple's standard behavior for the UI toggle.

## Files Changed
- `scripts/macos-defaults.sh` — Added `defaults write NSGlobalDomain AppleKeyboardUIMode -int 2`.
- `README.md` — Documented keyboard navigation under macOS Defaults.
- `docs/tasks/2026-08-28-enable-keyboard-navigation.md` — Task summary.

## Verification
- Executed `defaults write NSGlobalDomain AppleKeyboardUIMode -int 2`.
- Verified value with `defaults read NSGlobalDomain AppleKeyboardUIMode` (returned `2`).
- Validated script syntax with `bash -n scripts/macos-defaults.sh`.

## Related Docs
- [scripts/macos-defaults.sh](file:///Users/gregoriomelo/dev/dotfiles/scripts/macos-defaults.sh)
- [README.md](file:///Users/gregoriomelo/dev/dotfiles/README.md)
