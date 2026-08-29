# Task: Secure Context7 MCP Configurations Against Credential Leakage

**Date:** 2026-08-29

## Goal
Prevent plaintext Context7 API token leakage in version-controlled MCP configurations for OpenCode and Cursor by replacing hardcoded credentials with dynamic environment variable interpolation.

## What Was Done
- **OpenCode MCP Configuration:**
  - Configured [ai/.config/opencode/opencode.jsonc](file:///Users/gregoriomelo/dev/dotfiles/ai/.config/opencode/opencode.jsonc) to use OpenCode's native `{env:CONTEXT7_API_KEY}` syntax.
  - Verified `opencode mcp list` connects properly with injected environment variable.
- **Cursor MCP Configuration:**
  - Configured [ai/.cursor/mcp.json](file:///Users/gregoriomelo/dev/dotfiles/ai/.cursor/mcp.json) to use Cursor's native `${env:CONTEXT7_API_KEY}` syntax.
- **Setup Script Hardening:**
  - Updated [scripts/setup-ai-plugins.sh](file:///Users/gregoriomelo/dev/dotfiles/scripts/setup-ai-plugins.sh) to exclude `--cursor` and `--opencode` from `npx ctx7 setup --api-key` to prevent automated overwriting of stow-managed configs with static bearer tokens.
- **Rules Documentation:**
  - Added [ai/.config/opencode/AGENTS.md](file:///Users/gregoriomelo/dev/dotfiles/ai/.config/opencode/AGENTS.md) for OpenCode Context7 rule integration without credentials.

## Key Decisions
- **Native Env Interpolation:** Both OpenCode (`{env:KEY}`) and Cursor (`${env:KEY}`) natively support environment variable expansion in MCP headers, allowing dotfiles to remain strictly free of plaintext secrets while working seamlessly with shells configured via Proton Pass CLI (`pass-cli`).

## Files Changed
- `ai/.config/opencode/opencode.jsonc` — Used `{env:CONTEXT7_API_KEY}` in Authorization header.
- `ai/.cursor/mcp.json` — Used `${env:CONTEXT7_API_KEY}` in Authorization header.
- `ai/.config/opencode/AGENTS.md` — Context7 usage instructions for OpenCode.
- `scripts/setup-ai-plugins.sh` — Excluded cursor and opencode from destructive token overwrite.
- `docs/tasks/2026-08-29-secure-context7-mcp-credentials.md` — Task summary.

## Verification
- Verified zero secret matches across git diff with `git diff`.
- Tested `CONTEXT7_API_KEY="test-key" opencode mcp list` and confirmed successful server resolution and connection.
- Validated bash syntax on `scripts/setup-ai-plugins.sh`.

## Related Docs
- [ai/rules/security.md](../../ai/rules/security.md)
- [ai/rules/context7.md](../../ai/rules/context7.md)
