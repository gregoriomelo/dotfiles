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
├── .gitignore                  # Excludes .DS_Store, repo-root .claude/
├── scripts/
│   └── macos-defaults.sh       # macOS system preferences
├── aliases/                    # Stow package
│   ├── .aliases                # Shell aliases (zsh format)
│   └── .config/nushell/
│       └── aliases.nu          # Shell aliases (nushell format)
├── zsh/                        # Stow package
│   ├── .zshrc
│   └── .zprofile               # Sets Homebrew shell env + DEV_HOME/DOTFILES_HOME
├── git/                        # Stow package
│   ├── .gitconfig
│   └── .config/git/global_ignore
├── tmux/                       # Stow package
│   └── .tmux.conf
├── glow/                       # Stow package
│   └── .config/glow/glow.yml
├── nushell/                    # Stow package
│   └── .config/nushell/
│       ├── env.nu              # PATH, Homebrew env, DEV_HOME, DOTFILES_HOME
│       └── config.nu           # Starship + direnv hook; sources aliases.nu
├── starship/                   # Stow package
│   └── .config/starship.toml   # Prompt theme: hostname, directory, git, languages
├── ai/                         # Shared AI configuration
│   ├── rules/                  # Shared rule files for both Claude and Gemini
│   │   ├── coding.md
│   │   ├── design.md
│   │   ├── docs.md
│   │   ├── git.md
│   │   ├── product.md
│   │   └── testing.md
│   └── skills/                 # Shared skill files for both Claude and Gemini
│       └── design/             # Shared design skill
├── claude/                     # Stow package
│   └── .claude/
│       ├── CLAUDE.md           # References symlinked rules/
│       ├── rules               → ../../ai/rules
│       └── skills              → ../../ai/skills
└── gemini/                     # Stow package
    └── .gemini/
        ├── GEMINI.md           # References symlinked rules/
        ├── rules               → ../../ai/rules
        └── skills              → ../../ai/skills
├── vim/                        # Stow package
│   └── .vimrc                  # 2-space indentation
```

## Make Targets

- **`make setup`** (default) — Runs all targets in order: `homebrew`, `brew`, `stow`, `tpm`, `macos`
- **`make homebrew`** — Installs Homebrew if missing (idempotent)
- **`make brew`** — Runs `brew bundle --file=Brewfile` (requires homebrew)
- **`make stow`** — Symlinks packages using GNU Stow (requires stow from brew)
- **`make tpm`** — Clones TPM + catppuccin/tmux, then installs all plugins (idempotent)
- **`make macos`** — Applies macOS defaults and restarts Dock/Finder
- **`make nushell-init`** — Generates `~/.cache/starship/init.nu` (one-time, run after `make stow`)
- **`make default-shell`** — Registers nushell in `/etc/shells` and sets it as the login shell (requires sudo)

**All targets are idempotent** — safe to run multiple times.

## Symlinks Created

After `make stow`, all of these point to `~/dev/dotfiles`:

```
~/.aliases                          → aliases/.aliases
~/.config/nushell/aliases.nu        → aliases/.config/nushell/aliases.nu
~/.zshrc                            → zsh/.zshrc
~/.zprofile                         → zsh/.zprofile
~/.gitconfig                        → git/.gitconfig
~/.config/git/global_ignore         → git/.config/git/global_ignore
~/.tmux.conf                        → tmux/.tmux.conf
~/.config/glow/glow.yml             → glow/.config/glow/glow.yml
~/.config/nushell/env.nu            → nushell/.config/nushell/env.nu
~/.config/nushell/config.nu         → nushell/.config/nushell/config.nu
~/.claude/CLAUDE.md                 → claude/.claude/CLAUDE.md
~/.claude/rules/                    → claude/.claude/rules/
~/.claude/skills/                   → claude/.claude/skills/
~/.gemini/GEMINI.md                 → gemini/.gemini/GEMINI.md
~/.gemini/rules/                    → gemini/.gemini/rules/
~/.gemini/skills/                   → gemini/.gemini/skills/
~/.vimrc                            → vim/.vimrc
~/.config/starship.toml             → starship/.config/starship.toml
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

## Tmux Configuration

See [tmux/.tmux.conf](tmux/.tmux.conf) for full details. See also [docs/tmux.md](docs/tmux.md).

**Prefix:** `Ctrl+a`

| Action | Key |
|---|---|
| Reload config | `prefix + r` |
| Split horizontal | `prefix + \|` |
| Split vertical | `prefix + -` |
| Navigate panes | `prefix + h/j/k/l` |
| Resize panes | `prefix + H/J/K/L` |
| Zoom pane | `prefix + m` |
| Previous/next window | `Alt+H` / `Alt+L` |
| Enter copy mode | `prefix + Enter` |
| Copy mode select | `v`, block: `Ctrl+v` |
| Copy selection | `y` |

**Plugins:** tmux-sensible, tmux-yank, tmux-resurrect, tmux-continuum, catppuccin/tmux (Mocha)

**Status bar:** Session name (left) — turns red when prefix is active. Directory + date/time (right).

## Nushell

Nushell is the default interactive shell. It is **not POSIX-compatible** — it has its own language (Nu) with different syntax for aliases and functions.

### First-time setup

After `make stow`, run these two additional steps:

```bash
make nushell-init    # generates ~/.cache/starship/init.nu
make default-shell   # registers nu in /etc/shells + chsh (requires sudo)
```

Then restart your terminal.

### Co-location convention for aliases

Aliases live **side-by-side** in the `aliases/` stow package:

```
aliases/
├── .aliases                        ← zsh format
└── .config/nushell/aliases.nu      ← nushell format
```

When adding or changing an alias, edit **both files**. See [docs/nushell.md](docs/nushell.md) for syntax reference.

## Claude Code

The `claude/` stow package manages only user-authored Claude Code configuration files. The `~/.claude/` directory also contains Claude-managed state (history, credentials, projects, etc.) which is **not** version-controlled.

**Managed files:**
- `CLAUDE.md` — Global instructions that reference modular rules
- `rules/` — Symlinked to `ai/rules/`
- `skills/` — Symlinked to `ai/skills/`

Stow creates individual symlinks inside `~/.claude/` (tree unfolding) so Claude-managed files coexist alongside the symlinked config.

## Gemini CLI

The `gemini/` stow package manages Gemini CLI configuration files. Similar to Claude, it uses a global `GEMINI.md` that references modular rules.

**Managed files:**
- `GEMINI.md` — Global instructions (located at `~/.gemini/GEMINI.md`)
- `rules/` — Symlinked to `ai/rules/`
- `skills/` — Symlinked to `ai/skills/`

Stow creates individual symlinks inside `~/.gemini/` so Gemini-managed files coexist alongside the symlinked config.

## Adding New Dotfiles

1. Create a new stow package (e.g., `nvim/`)
2. Place config at correct path (e.g., `nvim/.config/nvim/init.vim`)
3. Update `Makefile` stow target: `stow ... nvim`
4. Run `make stow` to create symlinks

## Verification

Check everything is set up correctly:

```bash
# All symlinks should point to ~/dev/dotfiles
ls -la ~/.aliases ~/.zshrc ~/.zprofile ~/.gitconfig ~/.tmux.conf ~/.config/git/global_ignore

# Homebrew should be accessible
zsh -l -c 'which brew'

# TPM should be installed
ls ~/.tmux/plugins/tpm

# macOS defaults applied
defaults read NSGlobalDomain KeyRepeat  # should be 2

# Nushell symlinks exist
ls -la ~/.config/nushell/

# Starship cache generated
ls ~/.cache/starship/init.nu

# Nushell basics work
nu -c "g --version"
nu -c "$env.DEV_HOME"
nu -c "$env.PATH | str join (char nl)" | grep homebrew

# Default shell changed (after make default-shell + terminal restart)
dscl . -read /Users/gregoriomelo UserShell   # should show /opt/homebrew/bin/nu
```

## Documentation

- **README.md** (this file) — Setup and usage
- **Makefile** — Automation targets
- **scripts/macos-defaults.sh** — System preferences configuration
- **docs/tmux.md** — Full tmux keybinding and plugin reference
- **docs/nushell.md** — Nushell setup, alias syntax reference, and co-location convention
- **docs/starship.md** — Starship prompt configuration reference
- **docs/tasks/** — Task summaries with context and prompts used
  - [2026-02-18: Aliases Consolidation](docs/tasks/2026-02-18-aliases-consolidation.md)
  - [2026-02-18: Tmux Config](docs/tasks/2026-02-18-tmux-config.md)
  - [2026-02-18: Nushell Default Shell](docs/tasks/2026-02-18-nushell-default-shell.md)
  - [2026-02-18: Claude Code Config](docs/tasks/2026-02-18-claude-code-config.md)
  - [2026-02-22: Starship Config](docs/tasks/2026-02-22-starship-config.md)

See also: `claude/.claude/CLAUDE.md` for global Claude Code instructions.
