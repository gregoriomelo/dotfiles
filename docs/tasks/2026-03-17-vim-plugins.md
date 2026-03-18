# Task: Vim Plugin Setup

**Date:** 2026-03-17

## Context

The existing `vim/.vimrc` only had 2-space indentation settings. The user wanted to restore the feel of maximum-awesome (square/maximum-awesome), the classic curated vim config, with a file tree sidebar, search highlighting, status line, fuzzy file finder, and text surround operations.

## Prompts

1. "I miss some config I used to have for vim, like the file tree on the left and the highlight on search. help me search for popular plugins and configs for vim. I was used to maximum-awesome."
2. "before going forward, make sure this setup can be done (or is done) via `make`, ideally using `stow`, just like the other configs in this folder"
3. "let's change the <leader> to comma"
4. "what other plugins can we consider?" → selected fzf.vim and vim-surround

## Decisions

- **Plugin manager:** vim-plug (single-file, battle-tested, works with classic Vim)
- **File tree:** NERDTree (direct equivalent to maximum-awesome)
- **Status line:** vim-airline (no Nerd Font required)
- **Fuzzy finder:** fzf.vim (modern replacement for ctrlp; requires fzf Homebrew package)
- **Surround:** vim-surround (tpope, also in maximum-awesome)
- **Leader key:** `,` (matches maximum-awesome default)
- **vim-plug installation:** handled by `make vim-init` Makefile target, not auto-bootstrapped in vimrc

## Files Changed

- `vim/.vimrc` — plugin declarations, NERDTree/fzf/search config, keybindings
- `Makefile` — added `vim-init` target + added to `setup` dependency list
- `Brewfile` — added `fzf`
- `README.md` — updated directory tree, Make Targets, added Vim section, updated Documentation
- `docs/vim.md` — new vim reference doc
- `docs/tasks/2026-03-17-vim-plugins.md` — this file

## Key Bindings Added

| Key | Action |
|-----|--------|
| `,d` | Toggle NERDTree |
| `,t` | Fuzzy file finder |
| `,f` | Ripgrep full-text search |
| `,<space>` | Clear search highlight |
| `cs'"` | Change surrounding quote style |
| `ds"` | Delete surrounding character |
| `ysiw"` | Wrap word in quotes |
