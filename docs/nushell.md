# Nushell Configuration

Nushell (`nu`) is the default interactive shell. See [README.md](../README.md#nushell) for setup overview.

## Config Files

| File | Purpose |
|---|---|
| `nushell/.config/nushell/env.nu` | PATH, Homebrew env, DEV_HOME, DOTFILES_HOME |
| `nushell/.config/nushell/config.nu` | Starship prompt, direnv hook, sources aliases |
| `aliases/.config/nushell/aliases.nu` | All alias/function definitions |

Nushell on macOS uses `~/Library/Application Support/nushell/` as its config dir. `make nushell-init` creates symlinks from there to the stow-managed `~/.config/nushell/` files.

## Alias Syntax Reference

Nushell is **not POSIX-compatible**. Here is the syntax translation from zsh:

| zsh | nushell |
|---|---|
| `alias g='git'` | `alias g = git` |
| `alias gpom='git push origin main'` | `alias gpom = git push origin main` |
| `alias brewup='cmd1; cmd2'` | `def brewup [] { cmd1; cmd2 }` |
| `function gpb { ... }` | `def gpb [] { ... }` |
| `history \| grep $1` | `history \| where command =~ $pattern` |
| `ls -l -G` | *(omitted — nushell built-in `ls` preferred)* |

## Co-location Convention

All alias definitions live in the `aliases/` stow package, side-by-side:

```
aliases/
├── .aliases                        ← zsh format
└── .config/nushell/aliases.nu      ← nushell format
```

**When adding a new alias, edit both files.** This is the single directory to look at for all aliases, regardless of shell.

## First-time Setup

After `make stow`:

```bash
make nushell-init    # generates ~/.cache/starship/init.nu + macOS config dir links
make default-shell   # registers nu in /etc/shells + chsh (requires sudo)
```

Restart the terminal after `make default-shell`.

## Verification

```bash
# Symlinks in stow target
ls -la ~/.config/nushell/

# Symlinks in macOS nushell config dir
ls -la ~/Library/Application\ Support/nushell/

# Starship cache
ls ~/.cache/starship/init.nu

# Test in login mode (as it runs when set as default shell)
nu -l -c "g --version"
nu -l -c '$env.DEV_HOME'
nu -l -c '$env.PATH | str join (char nl)' | grep homebrew

# Check default shell (after make default-shell + terminal restart)
dscl . -read /Users/gregoriomelo UserShell
```
