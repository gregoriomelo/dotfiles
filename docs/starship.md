# Starship Prompt

Config: [`starship/.config/starship.toml`](../starship/.config/starship.toml)

Starship is the cross-shell prompt used by both **zsh** and **nushell**. See [docs/nushell.md](nushell.md) for how it is initialised in nushell (`make nushell-init`).

## Prompt Segments

| Segment | Description |
|---|---|
| `hostname` | Machine name, always visible (bold dimmed green) |
| `directory` | Current path, truncated to 4 levels, repo-aware |
| `git_branch` | Branch name with  icon |
| `git_status` | `⇡`/`⇣` for ahead/behind; `+` staged, `!` modified, `?` untracked, `-` deleted |
| `nodejs` | Node version when in a Node project |
| `python` | Python version when in a Python project |
| `rust` | Rust version when in a Rust project |
| `golang` | Go version when in a Go project |
| `java` | Java version when in a Java project |
| `character` | `❯` — green on success, red on error |

`package` is disabled (removes noisy version badge from prompt).

## Customisation Notes

- To show hostname only over SSH, set `ssh_only = true` in `[hostname]`.
- Language segments auto-detect based on project files; no manual toggle needed.
- Nerd Font (Fira Mono or JetBrains Mono) is required for icons — both are in the [Brewfile](../Brewfile).

## References

- [Starship documentation](https://starship.rs/config/)
- [Nushell integration](nushell.md)
