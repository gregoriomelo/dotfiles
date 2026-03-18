# Vim Configuration

See also: [README.md](../README.md#vim)

## Plugin Manager

[vim-plug](https://github.com/junegunn/vim-plug) — installed automatically by `make vim-init`.

Plugins live in `~/.vim/plugged/` (runtime artifacts, not tracked in dotfiles).

To install/update plugins manually:
```
:PlugInstall
:PlugUpdate
```

## Plugins

| Plugin | Purpose |
|--------|---------|
| [preservim/nerdtree](https://github.com/preservim/nerdtree) | File tree sidebar |
| [vim-airline/vim-airline](https://github.com/vim-airline/vim-airline) | Status line |
| [junegunn/fzf.vim](https://github.com/junegunn/fzf.vim) | Fuzzy file/content search (requires `fzf` from Homebrew) |
| [tpope/vim-surround](https://github.com/tpope/vim-surround) | Surround text objects |

## Keybindings

`<leader>` is set to `,`

### File Navigation

| Key | Action |
|-----|--------|
| `,d` | Toggle NERDTree file tree |
| `,t` | Fuzzy file finder (`:Files`) |
| `,f` | Full-text search across project (`:Rg`) |

### Search

| Key | Action |
|-----|--------|
| `/pattern` | Search with incremental highlight |
| `,<space>` | Clear search highlight |

Searches are case-insensitive unless uppercase letters are used (`smartcase`).

### vim-surround

| Key | Action |
|-----|--------|
| `cs'"` | Change surrounding `'foo'` → `"foo"` |
| `cs"'` | Change surrounding `"foo"` → `'foo'` |
| `ds"` | Delete surrounding `"` |
| `ysiw"` | Wrap word under cursor in `"` |
| `yss"` | Wrap entire line in `"` |
| `S"` | Wrap visual selection in `"` (visual mode) |

## Setup

`fzf` must be installed via Homebrew for fzf.vim to work. It is included in the Brewfile and installed by `make brew`.

`make vim-init` handles everything:
1. Downloads vim-plug to `~/.vim/autoload/plug.vim` if not present
2. Runs `vim +PlugInstall +qall` to install all plugins headlessly

## Nushell compatibility

This repo uses nushell as the default shell. Vim inherits it as `&shell`, which breaks any plugin that shells out with POSIX redirection (e.g. `cmd > tmpfile`). The vimrc fixes this with:

```vim
set shell=/bin/sh
```

This affects only how vim runs external commands — it does not change the interactive shell.
