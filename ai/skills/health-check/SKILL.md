---
name: health-check
description: >
  Runs a suite of validation tests to ensure the dotfiles repository and machine state are in sync.
  Activate when you want to verify the environment or before pushing changes.
user-invocable: true
---

# Health Check Skill

This skill provides a complete overview of your environment's health, ensuring no broken symlinks or missing configurations.

## Validation Suite

### 1. Symlink Integrity
- Run `ls -la ~ | grep 'dev/dotfiles'` to verify all stow packages are correctly symlinked.
- Look for broken links (red in terminal, or `[ -L "$target" ] && [ ! -e "$target" ]`).

### 2. Homebrew Sync
- Run `brew bundle check` to ensure all packages in the `Brewfile` are installed on the local machine.

### 3. Nushell Environment
- Run `nu -c "check-env"` (if the command is defined) or simply `nu -c "$env.DEV_HOME"` to ensure the shell knows where the repository is.
- Verify `~/.cache/starship/init.nu` exists.

### 4. Git Integrity
- Run `git status` to check for unstaged changes or untracked files that should be part of a stow package.

## Protocol

### 1. Assessment Phase
Run all checks in the validation suite.

### 2. Diagnosis Phase
Report any findings:
- **Missing Symlinks:** "Package `vim` is not symlinked to `~/.vimrc`."
- **Homebrew Drifts:** "Package `fzf` is in the `Brewfile` but not installed."

### 3. Resolution Phase (Optional)
Offer to run the corresponding `Makefile` target (e.g., `make stow` or `make brew`) to fix the issues.

## Guidance
- Use a clean, bulleted format for the report.
- End with a clear summary: "Environment is HEALTHY" or "Environment has [N] issues."
