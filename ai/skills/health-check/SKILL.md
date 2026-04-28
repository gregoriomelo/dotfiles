---
name: health-check
description: >
  Runs a suite of validation tests to ensure the dotfiles repository and machine state are in sync.
  Activate when you want to verify the environment or before pushing changes.
user-invocable: true
---

# Health Check Skill

This skill provides a complete overview of your environment's health, ensuring no broken symlinks or missing configurations by executing a dedicated shell script.

## Protocol

### 1. Execution
Run the health check script:
```bash
./scripts/health-check.sh
```

### 2. Reporting Phase
-   Relay the output of the script to the user.
-   If the environment is HEALTHY, simply confirm it.
-   If there are errors (e.g., broken symlinks, missing Homebrew packages), highlight the specific failures and propose the corresponding `make` commands to fix them (e.g., `make stow` or `make brew`).

## Guidance
-   Do not run manual checks (like `ls -la`); rely entirely on the output of the script for accuracy.
