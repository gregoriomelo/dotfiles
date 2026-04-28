---
name: alias-sync
description: >
  Synchronizes shell aliases across Zsh (`aliases/.aliases`) and Nushell (`aliases/.config/nushell/aliases.nu`).
  Use this when the user says "Add alias [alias]='[command]'" or "Create a new alias."
user-invocable: true
---

# Alias Sync Skill

This skill ensures that your shell experience is consistent regardless of whether you are using Zsh or Nushell by utilizing an executable script for perfect reliability.

## Protocol

### 1. Parsing
Identify the alias name and the command from the user's request.
-   **Example:** `gs='git status'` -> Name: `gs`, Command: `git status`

### 2. Execution Phase
Run the dedicated script to safely write the alias to both configurations:
```bash
./scripts/add-alias.sh "[name]" "[command]"
```

## Guidance
-   If the command is highly complex or requires shell-specific logic (like functions or structured data pipelines), do not use the script. Instead, manually append the correctly translated formats to both files as a bespoke implementation.
-   For all standard aliases (e.g., string replacements), always use the script.
-   Inform the user once the synchronization is complete.
