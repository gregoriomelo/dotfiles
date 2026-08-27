# Task: Post-Setup Onboarding Guide and Next Steps Automation

**Date:** 2026-08-27

## Goal
Make the dotfiles repository user-friendly by clarifying and automating the post-`make setup` next steps (such as configuring Nushell as the default shell, starting Tailscale, logging into CLIs, starting Colima/Docker, and granting macOS permissions).

## What Was Done
- **Interactive Post-Setup Script ([scripts/post-setup.sh](file:///Users/gregoriomelo/dev/dotfiles/scripts/post-setup.sh)):**
  - Created an interactive, status-aware post-setup script that inspects the current system state and highlights pending actions:
    1. **Default Shell (Nushell):** Checks `/etc/shells` and `dscl` UserShell. Prompts to run `make default-shell` and fully quit Ghostty/Terminal (`Cmd+Q`).
    2. **Services & Daemons:** Checks Tailscale daemon status (`tailscale status`) and Colima container runtime (`colima status`).
    3. **CLI Authentication & Secrets:** Checks GitHub CLI (`gh auth status`), Proton Pass CLI (`pass-cli info`), and Atuin (`atuin status`), with reminders for AI agent tools (`claude login`, `CONTEXT7_API_KEY`).
    4. **macOS App Permissions:** Lists explicit permissions required in System Settings (Alfred, Magnet, f.lux).
    5. **Session Recommendations:** Advises fully quitting terminal applications (`Cmd+Q`) and rebooting/logging out for macOS defaults to apply.
- **Makefile Integration ([Makefile](file:///Users/gregoriomelo/dev/dotfiles/Makefile)):**
  - Added `post-setup` and `health-check` to `.PHONY`.
  - Added `post-setup` target calling `@bash scripts/post-setup.sh`.
  - Added `health-check` target calling `@bash scripts/health-check.sh`.
  - Updated `setup:` target to run `post-setup` at completion, providing immediate guidance upon bootstrap completion.
- **Health Check Enhancements ([scripts/health-check.sh](file:///Users/gregoriomelo/dev/dotfiles/scripts/health-check.sh)):**
  - Updated step `[3/4]` to verify whether `/opt/homebrew/bin/nu` is registered in `/etc/shells` and set as the active login shell.
- **Trackpad Tap-to-Click Fix ([scripts/macos-defaults.sh](file:///Users/gregoriomelo/dev/dotfiles/scripts/macos-defaults.sh)):**
  - Identified that tap-to-click previously only configured the Bluetooth trackpad domain (`com.apple.driver.AppleBluetoothMultitouch.trackpad`), leaving MacBook built-in trackpads disabled (`com.apple.AppleMultitouchTrackpad Clicking = 0`).
  - Added defaults for `com.apple.AppleMultitouchTrackpad` and current host `NSGlobalDomain com.apple.mouse.tapBehavior`.
- **Documentation Updates ([README.md](file:///Users/gregoriomelo/dev/dotfiles/README.md) & [docs/nushell.md](file:///Users/gregoriomelo/dev/dotfiles/docs/nushell.md)):**
  - Added a dedicated "Post-Setup Guide (Next Steps)" section in `README.md` categorizing next steps by Shell, Services, Authentication, macOS Permissions, and Reboot.
  - Updated Quick Start to include step 3 (`make default-shell` / `make post-setup`) and added the `Cmd+Q` terminal relaunch note.
  - Updated Make Targets table in `README.md` to document `make post-setup` and `make health-check`.
  - Updated `docs/nushell.md` to note that `make nushell-init` is automated in `make setup` and document the `Cmd+Q` requirement.

## Key Decisions
- **Live Status Detection in Post-Setup:** Instead of printing static markdown, `scripts/post-setup.sh` evaluates live status (e.g. `gh auth status`, `tailscale status`, `pass-cli info`, `colima status`, `dscl` UserShell) so users see checkmarks (`✅`) for items already configured and warning indicators (`⚠️`) with exact commands for pending items.
- **Automated Trigger at Setup Completion:** Chaining `post-setup` at the end of `make setup` ensures users onboarding on fresh machines are immediately presented with actionable next steps rather than guessing what failed or what remains.
- **Explicit Terminal Quit Guidance:** Documented that macOS GUI terminals (like Ghostty) must be fully quit (`Cmd+Q`) rather than just opened in a new tab/window (`Cmd+N`) when changing login shells, as existing processes cache the previous launch environment.

## Files Changed
- `scripts/post-setup.sh` — Interactive post-setup checklist script.
- `scripts/macos-defaults.sh` — Added built-in trackpad domain and currentHost for tap-to-click.
- `Makefile` — Added `post-setup` and `health-check` targets; chained `post-setup` to `setup`.
- `scripts/health-check.sh` — Added login shell and `/etc/shells` verification.
- `README.md` — Added Post-Setup Guide section, updated Quick Start and Make Targets table.
- `docs/nushell.md` — Updated First-time Setup instructions.
- `docs/tasks/2026-08-27-post-setup-onboarding-guide.md` — Task documentation record.

## Verification
- `bash -n scripts/post-setup.sh`: Verified script syntax.
- `./scripts/post-setup.sh`: Verified execution and accurate detection of current system status (Nushell detected as configured, unauthenticated services flagged with remediation commands).
- `make -n post-setup health-check default-shell`: Verified Makefile dry-run targets.
- `make health-check`: Successfully ran all 4 health checks with environment reporting HEALTHY.

## Related Docs
- [README.md](file:///Users/gregoriomelo/dev/dotfiles/README.md)
- [docs/nushell.md](file:///Users/gregoriomelo/dev/dotfiles/docs/nushell.md)
- [docs/tasks/2026-08-27-add-make-prepare-target.md](file:///Users/gregoriomelo/dev/dotfiles/docs/tasks/2026-08-27-add-make-prepare-target.md)
- [docs/tasks/2026-08-27-enable-built-in-trackpad-tap-to-click.md](file:///Users/gregoriomelo/dev/dotfiles/docs/tasks/2026-08-27-enable-built-in-trackpad-tap-to-click.md)
