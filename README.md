# Dotfiles Bootstrap with GNU Stow

## Overview

This dotfiles repo uses **GNU Stow** to manage symlinks and a **Makefile** to automate setup on fresh macOS systems.

## Quick Start

On a fresh Mac:

```bash
mkdir -p ~/dev && cd ~/dev
git clone git@github.com:gregoriomelo/dotfiles.git dotfiles
cd dotfiles

# 1. Run interactive pre-flight checks (Xcode CLT, sudo, Mac App Store, GPG, .env, SSH)
make prepare

# 2. Run bootstrap installation
make setup
```

`make prepare` guides you through pre-flight requirements: verifies Xcode Command Line Tools and sudo, checks Mac App Store sign-in status, offers to generate `~/.gitconfig.local` if your GPG key is not yet present, helps initialize `.env`, and tests GitHub SSH connectivity. If all checks pass, it offers to run `make setup` immediately.

`make setup`:
1. Installs Homebrew (if missing)
2. Runs `brew bundle` to install all packages from Brewfile
3. Uses Stow to symlink configs to `$HOME`
4. Clones TPM (Tmux Plugin Manager)
5. Applies macOS developer defaults
6. Installs vim-plug and vim plugins

> [!NOTE]
> **Fresh Machine Setup Notes:**
> - **Mac App Store**: Sign into the Mac App Store before running `make setup` if using `mas` apps (e.g. Xcode).
> - **Git & GPG Signing**: Global git configuration enforces GPG commit signing by default. If your GPG signing keys are not yet imported, copy `git/.gitconfig.local.example` to `~/.gitconfig.local` (or run `make prepare` to generate it with `commit.gpgsign = false`) to avoid commit failures.

## Directory Structure

```
dotfiles/
├── Makefile                    # Entry point; run `make setup`
├── Brewfile                    # Homebrew packages (not stowed)
├── .env.example                # Initial API keys template (not stowed)
├── AGENTS.md                   # Project-scoped AI agent manifest (new)
├── CLAUDE.md                   # Project-scoped Claude Code instructions (new)
├── .agents/                    # Project-scoped subagent definitions
│   ├── steward.md              # Dotfiles maintenance subagent
│   └── macos.md                # (new) macOS settings subagent
├── scripts/
│   ├── prepare.sh              # Pre-flight onboarding checklist
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
│   ├── .gitconfig.local.example # Local git override template (~/.gitconfig.local)
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
│   ├── rules/                  # Shared rule files for all agents
│   │   ├── coding.md           # Preferred coding preferences
│   │   ├── design.md
│   │   ├── docs.md             # ADRs and task-recorder automation
│   │   ├── git.md
│   │   ├── product.md
│   │   ├── security.md
│   │   ├── testing.md
│   │   └── context7.md         # Context7 MCP documentation lookup
│   └── skills/                 # Shared skill files for all agents
│       ├── design/             # Design director mode
│       ├── task-recorder/      # Documentation automation
│       ├── usage-tracker/      # Resource consumption monitor
│       ├── alias-sync/         # (new) Zsh/Nushell alias sync
│       ├── brew-sync/          # (new) Brewfile synchronization
│       ├── health-check/       # (new) Environment validation suite
│       └── context7-mcp/       # On-demand API documentation lookups
├── claude/                     # Stow package
│   └── .claude/
│       ├── CLAUDE.md           # Global Claude instructions
│       ├── rules               → ../../ai/rules
│       └── skills              → ../../ai/skills
├── gemini/                     # Stow package
│   └── .gemini/
│       ├── GEMINI.md           # Global Gemini instructions
│       ├── rules               → ../../ai/rules
│       └── skills              → ../../ai/skills
├── pi/                         # Stow package
│   └── .pi/
│       └── agent/
│           └── skills          → ../../../ai/skills
└── vim/                        # Stow package
    └── .vimrc                  # Plugins: NERDTree, vim-airline, fzf.vim, vim-surround
```

## Make Targets

- **`make prepare`** — Interactive pre-flight checklist for fresh machine onboarding (Xcode CLT, sudo, Mac App Store, GPG, `.env`, GitHub SSH)
- **`make setup`** (default) — Runs all targets in order: `homebrew`, `brew`, `stow`, `tpm`, `macos`, `vim-init`
- **`make homebrew`** — Installs Homebrew if missing (idempotent)
- **`make brew`** — Runs `brew bundle --file=Brewfile` (requires homebrew)
- **`make stow`** — Symlinks packages using GNU Stow (requires stow from brew)
- **`make tpm`** — Clones TPM + catppuccin/tmux, then installs all plugins (idempotent)
- **`make macos`** — Applies macOS defaults and restarts Dock/Finder
- **`make vim-init`** — Installs vim-plug and all vim plugins (idempotent, requires stow)
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
~/.gitconfig.local.example          → git/.gitconfig.local.example
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
- Remaps CapsLock to Escape (via `hidutil` and launchd persistence)

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

## Vim

See [docs/vim.md](docs/vim.md) for full details.

**Plugin manager:** vim-plug (auto-installed by `make vim-init`)

**Plugins:** NERDTree, vim-airline, fzf.vim, vim-surround

| Key | Action |
|-----|--------|
| `,d` | Toggle file tree (NERDTree) |
| `,t` | Fuzzy file finder (fzf) |
| `,f` | Full-text search across project (Rg) |
| `,<space>` | Clear search highlight |
| `cs'"` | Change surrounding `'` → `"` |
| `ds"` | Delete surrounding `"` |
| `ysiw"` | Wrap word in `"` |

## Git

Global git configuration in `git/.gitconfig` enables GPG commit signing by default (`commit.gpgsign = true`) and includes `~/.gitconfig.local` for machine-specific overrides.

### Fresh Machine Setup

If GPG signing keys are not yet imported on a new machine:
1. Copy `git/.gitconfig.local.example` to `~/.gitconfig.local`:
   ```bash
   cp git/.gitconfig.local.example ~/.gitconfig.local
   ```
2. Uncomment `gpgsign = false` under `[commit]` (or configure your signing key under `[user]`) to prevent commit signing failures until keys are imported.

## Project AI Agents

This repository includes a project-scoped AI agent configuration that provides a specialized experience for any coding agent (Claude, Gemini, Pi) working on these dotfiles.

- **`AGENTS.md`**: The central manifest defining specialized subagents and rules.
- **`@steward` subagent**: Enforces repository conventions (Stow-first, Makefile integrity, alias co-location).
- **`@macos` subagent**: (new) Manages macOS system preferences and `macos-defaults.sh`.
- **`@task-recorder` skill**: Automates the generation of `docs/tasks/` summaries.
- **`@usage-tracker` skill**: Provides real-time visibility into Claude plan consumption.
- **`@alias-sync` skill**: (new) Ensures shell aliases are identical in Zsh and Nushell.
- **`@brew-sync` skill**: (new) Keeps the `Brewfile` in sync with your machine.
- **`@health-check` skill**: (new) Runs a suite of validation tests to ensure your environment is healthy.

To use these features, simply interact with your agent as usual while in this directory. You can explicitly call subagents (e.g., `@steward fix the Makefile` or `@macos show hidden files`) or invoke skills (e.g., `"Record this task"` or `"Check my environment health"`).

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
ls -la ~/.aliases ~/.zshrc ~/.zprofile ~/.gitconfig ~/.gitconfig.local.example ~/.tmux.conf ~/.config/git/global_ignore

# Check git configuration (and optional signing override)
git config --get commit.gpgsign

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
dscl . -read "$HOME" UserShell   # should show /opt/homebrew/bin/nu
```

## Documentation

- **README.md** (this file) — Setup and usage
- **Makefile** — Automation targets
- **scripts/prepare.sh** — Pre-flight onboarding checklist
- **scripts/macos-defaults.sh** — System preferences configuration
- **docs/vim.md** — Vim plugin reference and keybindings
- **docs/tmux.md** — Full tmux keybinding and plugin reference
- **docs/nushell.md** — Nushell setup, alias syntax reference, and co-location convention
- **docs/starship.md** — Starship prompt configuration reference
- **docs/tasks/** — Task summaries with context and prompts used
  - [2026-02-18: Aliases Consolidation](docs/tasks/2026-02-18-aliases-consolidation.md)
  - [2026-02-18: Tmux Config](docs/tasks/2026-02-18-tmux-config.md)
  - [2026-02-18: Nushell Default Shell](docs/tasks/2026-02-18-nushell-default-shell.md)
  - [2026-02-18: Claude Code Config](docs/tasks/2026-02-18-claude-code-config.md)
  - [2026-02-22: Starship Config](docs/tasks/2026-02-22-starship-config.md)
  - [2026-03-17: Vim Plugin Setup](docs/tasks/2026-03-17-vim-plugins.md)
  - [2026-08-27: Fresh Machine Bootstrap Evaluation and Fixes](docs/tasks/2026-08-27-fresh-machine-bootstrap-evaluation-and-fixes.md)
  - [2026-08-27: Mas in Brewfile & Gitconfig Local Template](docs/tasks/2026-08-27-mas-in-brewfile-and-gitconfig-local-template.md)
  - [2026-08-27: Add Make Prepare Target](docs/tasks/2026-08-27-add-make-prepare-target.md)

See also: `claude/.claude/CLAUDE.md` for global Claude Code instructions.
