# Dotfiles Bootstrap with GNU Stow

## Overview

This dotfiles repo uses **GNU Stow** to manage symlinks and a **Makefile** to automate setup on fresh macOS systems.

## Quick Start

On a fresh Mac:

```bash
cd ~/dev/dotfiles
make setup
```

This single command:
1. Installs Homebrew (if missing)
2. Runs `brew bundle` to install all packages from Brewfile
3. Uses Stow to symlink configs to `$HOME`
4. Clones TPM (Tmux Plugin Manager)
5. Applies macOS developer defaults

## Directory Structure

```
dotfiles/
├── Makefile                    # Entry point; run `make setup`
├── Brewfile                    # Homebrew packages (not stowed)
├── .gitignore                  # Excludes .DS_Store, .claude/
├── scripts/
│   └── macos-defaults.sh       # macOS system preferences
├── zsh/                        # Stow package
│   ├── .zshrc
│   └── .zprofile               # Sets Homebrew shell env
├── git/                        # Stow package
│   ├── .gitconfig
│   └── .config/git/global_ignore
└── tmux/                       # Stow package
    └── .tmux.conf
```

## Make Targets

- **`make setup`** (default) — Runs all targets in order: `homebrew`, `brew`, `stow`, `tpm`, `macos`
- **`make homebrew`** — Installs Homebrew if missing (idempotent)
- **`make brew`** — Runs `brew bundle --file=Brewfile` (requires homebrew)
- **`make stow`** — Symlinks packages using GNU Stow (requires stow from brew)
- **`make tpm`** — Clones TPM if not present (idempotent)
- **`make macos`** — Applies macOS defaults and restarts Dock/Finder

**All targets are idempotent** — safe to run multiple times.

## Symlinks Created

After `make stow`, all of these point to `~/dev/dotfiles`:

```
~/.zshrc                      → zsh/.zshrc
~/.zprofile                   → zsh/.zprofile
~/.gitconfig                  → git/.gitconfig
~/.config/git/global_ignore   → git/.config/git/global_ignore
~/.tmux.conf                  → tmux/.tmux.conf
```

## macOS Defaults

`scripts/macos-defaults.sh` applies:

**Keyboard:**
- Fast key repeat (2) & short initial delay (15ms)
- Disables press-and-hold, auto-correct, auto-capitalize, smart quotes/dashes

**Dock:**
- Auto-hide with zero delay
- Icon size 48, no recent apps

**Finder:**
- Shows file extensions, hidden files, path bar, status bar
- List view, folders first, no .DS_Store on network/USB volumes

**Trackpad:**
- Tap to click enabled

**Screenshots:**
- Save to `~/Screenshots` as PNG without shadow

**Misc:**
- Expanded save/print panels
- Disabled quarantine dialog

## Adding New Dotfiles

1. Create a new stow package (e.g., `nvim/`)
2. Place config at correct path (e.g., `nvim/.config/nvim/init.vim`)
3. Update `Makefile` stow target: `stow ... nvim`
4. Run `make stow` to create symlinks

## Verification

Check everything is set up correctly:

```bash
# All symlinks should point to ~/dev/dotfiles
ls -la ~/.zshrc ~/.zprofile ~/.gitconfig ~/.tmux.conf ~/.config/git/global_ignore

# Homebrew should be accessible
zsh -l -c 'which brew'

# TPM should be installed
ls ~/.tmux/plugins/tpm

# macOS defaults applied
defaults read NSGlobalDomain KeyRepeat  # should be 2
```

## Documentation

- **BOOTSTRAP.md** (this file) — Setup and usage
- **Makefile** — Automation targets
- **scripts/macos-defaults.sh** — System preferences configuration

See also: `.claude/CLAUDE.md` for global dotfiles instructions.
