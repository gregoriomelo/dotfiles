# 2026-02-22: Starship Config

## Summary

Added starship as a managed stow package in the dotfiles repo and configured the prompt.

## What was done

1. Created `starship/.config/starship.toml` with a clean baseline config.
2. Added `starship` to `STOW_PACKAGES` in the Makefile.
3. Removed the pre-existing broken symlink at `~/.config/starship.toml` and re-created it via `make stow`.
4. Added `[hostname]` module (always visible, bold dimmed green).
5. Created `docs/starship.md` with prompt segment reference.
6. Updated `README.md`: directory structure, symlinks table, and documentation index.

## Prompts used

1. "describe my starship configuration"
2. "1" (create the starship dotfiles package)
3. "add hostname to the starship config"
4. "do the documentation need updates? any other files need update? any dependencies to set?"

## Notes

- `starship` was already present in the Brewfile — no dependency changes needed.
- Nerd Font (Fira Mono / JetBrains Mono) is required for icons and is already in the Brewfile.

## References

- [docs/starship.md](../starship.md)
- [starship/.config/starship.toml](../../starship/.config/starship.toml)
- [README.md](../../README.md)
