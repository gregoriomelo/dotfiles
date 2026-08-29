# Task: Switch Tailscale from Homebrew Formula to Mac App Store

**Date:** 2026-08-29

## Goal
Replace the headless Homebrew CLI formula (`brew 'tailscale'`) with the official macOS GUI application (`Tailscale.app`) via the Mac App Store (`mas`), and remove the old formula.

## What Was Done
- **Uninstalled CLI Formula:**
  - Ran `brew uninstall tailscale` to remove the Homebrew formula and daemon files.
- **Updated Brewfile:**
  - Removed `brew 'tailscale'` from the `# dev` section.
  - Added `mas 'Tailscale', id: 1475387142` under the `# apps` section.
- **Triggered App Store Install:**
  - Opened the Mac App Store page directly (`macappstore://apps.apple.com/app/id1475387142`) for installation.

## Key Decisions
- **Mac App Store Distribution:** Tailscale's macOS GUI app uses Apple Network Extensions for seamless VPN routing without requiring a root daemon or kernel extensions. Using `mas 'Tailscale', id: 1475387142` integrates with the existing `Brewfile` and `mas` setup.

## Files Changed
- `Brewfile` — Replaced `brew 'tailscale'` with `mas 'Tailscale', id: 1475387142`.
- `docs/tasks/2026-08-29-switch-tailscale-to-mas.md` — Task documentation.

## Verification
- Confirmed `brew uninstall tailscale` succeeded (`which tailscale` returned not found).
- Validated `Brewfile` syntax.
- Confirmed `mas search tailscale` returns ID `1475387142`.

## Related Docs
- [Brewfile](file:///Users/gregoriomelo/dev/dotfiles/Brewfile)
