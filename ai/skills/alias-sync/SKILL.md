---
name: alias-sync
description: >
  Synchronizes shell aliases across Zsh (`aliases/.aliases`) and Nushell (`aliases/.config/nushell/aliases.nu`).
  Use this when the user says "Add alias [alias]='[command]'" or "Create a new alias."
user-invocable: true
---

# Alias Sync Skill

This skill ensures that your shell experience is consistent regardless of whether you are using Zsh or Nushell.

## Protocol

### 1. Parsing
Identify the alias name and the command.
-   **Example:** `gs='git status'`

### 2. Format Translation

#### Zsh Format (`aliases/.aliases`)
-   Simple alias: `alias [name]='[command]'`
-   Function: `function [name] { [command] }`

#### Nushell Format (`aliases/.config/nushell/aliases.nu`)
-   Simple alias: `alias [name] = [command]` (note the spaces around `=`)
-   Command/Function: `def [name] [] { [command] }`
-   Environment variables: Use `$env.VAR_NAME` instead of `$VAR_NAME`.

### 3. Execution Phase
-   **Step 1:** Append the Zsh-formatted alias to `aliases/.aliases`.
-   **Step 2:** Append the Nushell-formatted alias to `aliases/.config/nushell/aliases.nu`.
-   **Step 3:** Group aliases by category (e.g., `# git`, `# docker`) if possible, or append to the end under a `# New Aliases` section if the category is unclear.

## Guidance
-   If the command uses shell-specific features (like pipes or complex logic), prioritize creating a `def` in Nushell to ensure it handles structured data correctly.
-   Inform the user once the synchronization is complete.
