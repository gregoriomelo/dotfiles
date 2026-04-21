---
name: brew-sync
description: >
  Synchronizes the Homebrew configuration (`Brewfile`) with your installed packages.
  Use when installing a new binary or to check if the repository is in sync with the machine.
user-invocable: true
---

# Brew Sync Skill

This skill ensures that your machine's state matches your repository's declaration, making bootstrapping on a new machine effortless.

## Protocol

### 1. Verification Phase
Run `brew bundle check` to see if there are any missing dependencies defined in the `Brewfile`.

### 2. Update Phase
When the user installs a new tool (e.g., via `brew install [package]`):
- Identify the type: `brew` (binary), `cask` (GUI app), `tap` (repository), or `mas` (Mac App Store).
- Append the corresponding line to the `Brewfile` under the appropriate category.

### 3. Cleanup Phase
Optionally run `brew bundle cleanup` if the user wants to remove packages that are not in the `Brewfile`.

## Guidance
- Always keep the `Brewfile` sorted by category for readability.
- If a package requires additional flags or is a cask, ensure the syntax is correct (e.g., `cask 'google-chrome'`).
- Inform the user once the `Brewfile` has been updated and suggest running `make setup` to confirm everything is linked.
