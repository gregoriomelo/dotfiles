# Tmux Configuration

Reference: [tmux/.tmux.conf](../tmux/.tmux.conf) · [README.md](../README.md)

## Theme

**Catppuccin Mocha** — loaded directly from `~/.tmux/plugins/tmux/catppuccin.tmux` (not via TPM, to avoid name conflicts and ordering issues).

Window style: `rounded`. Status bar positioned at top.

## Status Bar

| Position | Content |
|---|---|
| Left | Session name (green normally, red when prefix is active) |
| Right | Current directory basename + date/time |

## Keybindings

**Prefix:** `Ctrl+a`

### Session / Config

| Key | Action |
|---|---|
| `prefix + r` | Reload `~/.tmux.conf` |

### Panes

| Key | Action |
|---|---|
| `prefix + \|` | Split horizontally (opens in current path) |
| `prefix + -` | Split vertically (opens in current path) |
| `prefix + h/j/k/l` | Navigate panes (vim-style) |
| `prefix + H/J/K/L` | Resize pane (5 cells, repeatable) |
| `prefix + m` | Zoom/unzoom pane |

### Windows

| Key | Action |
|---|---|
| `Alt+H` | Previous window (no prefix needed) |
| `Alt+L` | Next window (no prefix needed) |

### Copy Mode

| Key | Action |
|---|---|
| `prefix + Enter` | Enter copy mode |
| `v` | Begin selection |
| `Ctrl+v` | Rectangle (block) selection |
| `y` | Copy selection and exit |
| `H` / `L` | Start / end of line |
| `Escape` | Cancel |

Copy mode uses vim keys throughout (`j/k` scroll, `/` search, etc.).

## Plugins

Managed by [TPM](https://github.com/tmux-plugins/tpm) (`~/.tmux/plugins/tpm`).

| Plugin | Purpose |
|---|---|
| `tmux-plugins/tmux-sensible` | Sensible defaults |
| `tmux-plugins/tmux-yank` | System clipboard integration in copy mode |
| `tmux-plugins/tmux-resurrect` | Save/restore sessions across reboots (`prefix + Ctrl+s` / `Ctrl+r`) |
| `tmux-plugins/tmux-continuum` | Auto-save every 15 min, auto-restore on tmux start |

**Install plugins:** `make tpm` (automated) or `prefix + I` inside tmux.
**Update plugins:** `prefix + U`
**Uninstall removed plugins:** `prefix + Alt+u`

## Session Persistence

tmux-resurrect saves session layout and pane contents. tmux-continuum automatically saves every 15 minutes and restores the last session when tmux starts.

Save manually: `prefix + Ctrl+s`
Restore manually: `prefix + Ctrl+r`
