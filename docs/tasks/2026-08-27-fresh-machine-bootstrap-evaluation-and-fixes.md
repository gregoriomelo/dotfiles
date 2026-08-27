# Task: Fresh Machine Bootstrap Evaluation and Comprehensive Fixes

**Date:** 2026-08-27

## Goal
Evaluate the dotfiles repository to identify all failure points, friction, and assumptions that would break `make setup` on a fresh macOS installation, and resolve each issue with dedicated, verified small commits.

## What Was Done
- **Makefile Bootstrap Fixes ([commit `3bc0237`](file:///Users/gregoriomelo/dev/dotfiles/Makefile)):**
  - Exported `PATH := /opt/homebrew/bin:/usr/local/bin:$(PATH)` near the top of [Makefile](file:///Users/gregoriomelo/dev/dotfiles/Makefile) so subshells find Homebrew binaries immediately after installation even before shell restart.
  - Added `mkdir -p "$$HOME/.gnupg" "$$HOME/.claude" "$$HOME/.gemini"` to `clean-stow-conflicts` to ensure these exist as physical directories before GNU Stow runs, avoiding whole-directory symlinking.
  - Added `mkdir -p "$$NUDIR"` in `nushell-init` prior to creating macOS symlinks.
  - Added `mkdir -p "$$HOME/.gnupg"` before `chmod 700` in `gpg-init`.
- **macOS LaunchAgents Directory Creation ([commit `1f364ec`](file:///Users/gregoriomelo/dev/dotfiles/scripts/macos-defaults.sh)):**
  - Added `mkdir -p "$HOME/Library/LaunchAgents"` in [scripts/macos-defaults.sh](file:///Users/gregoriomelo/dev/dotfiles/scripts/macos-defaults.sh) before writing `com.local.keyremap.plist`.
- **Script Permissions & Noise Reduction ([commit `81780b7`](file:///Users/gregoriomelo/dev/dotfiles/scripts/health-check.sh)):**
  - Added `2>/dev/null` to the symlink integrity scan in [scripts/health-check.sh](file:///Users/gregoriomelo/dev/dotfiles/scripts/health-check.sh) to suppress macOS TCC permission errors.
  - Set executable mode `100755` on [scripts/health-check.sh](file:///Users/gregoriomelo/dev/dotfiles/scripts/health-check.sh) and [scripts/add-alias.sh](file:///Users/gregoriomelo/dev/dotfiles/scripts/add-alias.sh) in Git.
- **Dynamic User Paths & Python Modernization ([commit `eecb785`](file:///Users/gregoriomelo/dev/dotfiles/nushell/.config/nushell/env.nu)):**
  - Replaced hardcoded `/Users/gregoriomelo` paths with dynamic `($env.HOME | path join ...)` in [nushell/.config/nushell/env.nu](file:///Users/gregoriomelo/dev/dotfiles/nushell/.config/nushell/env.nu).
  - Replaced hardcoded `/Users/gregoriomelo` path with `$HOME` in [zsh/.zshrc](file:///Users/gregoriomelo/dev/dotfiles/zsh/.zshrc).
  - Modernized `http_server` alias from Python 2 `SimpleHTTPServer` to Python 3 `http.server` in [aliases/.aliases](file:///Users/gregoriomelo/dev/dotfiles/aliases/.aliases) and [aliases/.config/nushell/aliases.nu](file:///Users/gregoriomelo/dev/dotfiles/aliases/.config/nushell/aliases.nu).
- **Brewfile `mas` & Local Git Config Template ([commit `988488f`](file:///Users/gregoriomelo/dev/dotfiles/Brewfile)):**
  - Added `brew 'mas'` under tooling in [Brewfile](file:///Users/gregoriomelo/dev/dotfiles/Brewfile).
  - Created [git/.gitconfig.local.example](file:///Users/gregoriomelo/dev/dotfiles/git/.gitconfig.local.example) with instructions for temporarily disabling GPG signing or setting a machine-specific key.
  - Whitelisted `!git/.gitconfig.local.example` in [.gitignore](file:///Users/gregoriomelo/dev/dotfiles/.gitignore).
  - Documented fresh setup guidance in [README.md](file:///Users/gregoriomelo/dev/dotfiles/README.md).

## Key Decisions
- **Fail-Safe Directory Pre-Creation:** Ensured all scripts and Makefile targets run `mkdir -p` before attempting to write files or apply symlinks to avoid fatal missing-directory errors on virgin systems.
- **Whole-Directory Symlink Prevention:** Pre-creating target directories like `~/.gnupg` forces GNU Stow to symlink individual files rather than symlinking the parent directory into the repository working tree.
- **Self-Contained Execution Environment:** Exporting `PATH` directly in `Makefile` makes `make setup` resilient to subshell isolation during bootstrap.

## Files Changed
- `Makefile` — Exported Homebrew PATH and added directory guards.
- `scripts/macos-defaults.sh` — Created `~/Library/LaunchAgents`.
- `scripts/health-check.sh` — Made executable and silenced TCC stderr.
- `scripts/add-alias.sh` — Made executable in Git index.
- `nushell/.config/nushell/env.nu` — Dynamic user home directory paths.
- `zsh/.zshrc` — Dynamic `$HOME` path for `.opencode/bin`.
- `aliases/.aliases` — Modernized `http_server` to Python 3.
- `aliases/.config/nushell/aliases.nu` — Modernized `http_server` to Python 3.
- `Brewfile` — Declared `brew 'mas'`.
- `git/.gitconfig.local.example` — Created local override template.
- `.gitignore` — Whitelisted `!git/.gitconfig.local.example`.
- `README.md` — Updated documentation for fresh machine setup.

## Verification
- `make -n setup`: Verified complete dependency graph and recipe syntax with zero errors.
- `./scripts/health-check.sh`: Verified direct executable execution with no permission errors and no TCC noise.
- `nu -c 'source nushell/.config/nushell/env.nu; echo $env.DEV_HOME'`: Verified dynamic path evaluation in Nushell.
- `zsh -n zsh/.zshrc aliases/.aliases`: Verified clean Zsh syntax.
- `git ls-files --stage scripts/`: Confirmed `100755` executable permissions across all scripts.

## Related Docs
- [README.md](file:///Users/gregoriomelo/dev/dotfiles/README.md)
- [docs/tasks/2026-08-27-mas-in-brewfile-and-gitconfig-local-template.md](file:///Users/gregoriomelo/dev/dotfiles/docs/tasks/2026-08-27-mas-in-brewfile-and-gitconfig-local-template.md)
- [docs/tasks/2026-05-11-local-git-config.md](file:///Users/gregoriomelo/dev/dotfiles/docs/tasks/2026-05-11-local-git-config.md)
