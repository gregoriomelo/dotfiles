# Task: Integrate Context7 MCP with Secure Pass-CLI Secret Provisioning

**Date:** 2026-08-19

## Goal
Enable Context7 across all AI coding agents (Claude Code, Cursor, Antigravity, OpenCode, Gemini CLI) while safely provisioning the `CONTEXT7_API_KEY` token from Proton Pass (`pass-cli`) without storing plaintext credentials in the git repository.

## What Was Done
- Configured `PROTON_PASS_KEY_PROVIDER = 'fs'` across Nushell and Zsh to prevent macOS Keychain `-25308` GUI interaction blockages in non-interactive subshells and tmux sessions.
- Added dynamic `CONTEXT7_API_KEY` loading from Proton Pass in `nushell/.config/nushell/env.nu` and `zsh/.zprofile`, with guard checks to prevent redundant lookups.
- Automated multi-agent MCP registration in `scripts/setup-ai-plugins.sh` via `npx ctx7 setup --claude --cursor --antigravity --opencode --gemini --mcp -y --api-key ...`.
- Added shared agent rule `ai/rules/context7.md` and skill `ai/skills/context7-mcp/` across the repository.
- Updated `gemini/.gemini/GEMINI.md`, `AGENTS.md`, and `README.md` to reference the new rule and skill.

## Key Decisions
- **Proton Pass `fs` Provider:** Switched from OS `keyring` to filesystem storage for `pass-cli` so headless scripts, IDE terminals, and background agent subshells can decrypt and access secrets non-interactively without graphical prompts.
- **Dynamic Session Injection:** Avoided `.env` files inside dotfiles to strictly adhere to `ai/rules/security.md` against credential leakage.
- **Automated AI Setup (`make ai-plugins`):** Tied Context7 registration into the existing `scripts/setup-ai-plugins.sh` run by `make setup`, ensuring one-command idempotency.

## Files Changed
- `nushell/.config/nushell/env.nu` — Added `PROTON_PASS_KEY_PROVIDER` and dynamic `CONTEXT7_API_KEY` evaluation.
- `zsh/.zprofile` — Added `PROTON_PASS_KEY_PROVIDER` and dynamic `CONTEXT7_API_KEY` evaluation.
- `scripts/setup-ai-plugins.sh` — Automated `npx ctx7 setup` across all AI coding agents.
- `ai/rules/context7.md` — Prompt rule for documentation lookups with Context7.
- `ai/skills/context7-mcp/` — On-demand skill definition for Context7 MCP.
- `gemini/.gemini/GEMINI.md` — Linked `@./rules/context7.md`.
- `AGENTS.md` — Documented Context7 rule and skill.
- `README.md` — Updated directory tree with new rules and skills.

## Verification
- Tested `nu` and `zsh` session initialization to verify non-blocking execution.
- Executed `npx ctx7 setup` across all supported agent flags (`--cursor`, `--claude`, `--antigravity`, `--opencode`, `--gemini`) and confirmed clean configuration of MCP servers, skills, and rules without OAuth prompts.
- Ran `scripts/setup-ai-plugins.sh` to confirm full integration with `make ai-plugins`.

## Related Docs
- [AGENTS.md](../../AGENTS.md)
- [README.md](../../README.md)
- [ai/rules/security.md](../../ai/rules/security.md)
