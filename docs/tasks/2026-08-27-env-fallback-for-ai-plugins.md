# Task: Support .env Fallback and Safe Pass-CLI Handling for AI Plugins Setup

**Date:** 2026-08-27

## Goal
Enable initial API key resolution (specifically `CONTEXT7_API_KEY`) from `.env` during `make ai-plugins` when bootstrapping a new computer, while ensuring `pass-cli` fails safely and non-interactively if it is not yet authenticated or configured.

## What Was Done
- Updated [scripts/setup-ai-plugins.sh](file:///Users/gregoriomelo/dev/dotfiles/scripts/setup-ai-plugins.sh) to:
  - Dynamically determine `$DOTFILES_DIR` instead of hardcoding paths.
  - Check for `CONTEXT7_API_KEY` in `$DOTFILES_DIR/.env` and `$HOME/.env` if not already set in the environment.
  - Guard `pass-cli` lookup with `pass-cli info` and redirected `< /dev/null` to prevent blocking interactive authentication prompts on new machines.
  - Skip Context7 setup gracefully with an informative warning (`⚠️ CONTEXT7_API_KEY not found...`) if the key is missing from all sources, allowing `make ai-plugins` to complete successfully with exit code `0`.
- Updated [.gitignore](file:///Users/gregoriomelo/dev/dotfiles/.gitignore) to exclude `.env` and `.env.*` to prevent credential leakage, while whitelisting `!.env.example`.
- Created [.env.example](file:///Users/gregoriomelo/dev/dotfiles/.env.example) documenting `CONTEXT7_API_KEY=` as an initial setup template.

## Key Decisions
- **Non-Interactive `pass-cli` Readiness Check:** Checking `pass-cli info >/dev/null 2>&1 < /dev/null` before invoking `pass-cli item view` guarantees that unauthenticated `pass-cli` installs on fresh computers will not hang or prompt for user login during automated setup.
- **`.env` Hierarchy:** Environment variables take precedence, followed by `$DOTFILES_DIR/.env`, then `$HOME/.env`, and finally `pass-cli`.
- **Option A Environment Pattern:** Standardized on `.env.example` as the committed reference template and `.env` as the gitignored local secrets file, avoiding `.env.local` to maintain a single, consistent convention.
- **Graceful Non-Zero Bypassing:** When API keys are completely absent on a fresh machine, the script logs a warning and exits cleanly instead of terminating the bootstrap pipeline.

## Files Changed
- `scripts/setup-ai-plugins.sh` — Added `.env` resolution, safe `pass-cli` readiness check, and graceful skip when key is missing.
- `.gitignore` — Added rules to ignore `.env` and `.env.*` while keeping `.env.example`.
- `.env.example` — Template defining `CONTEXT7_API_KEY=`.
- `docs/tasks/2026-08-27-env-fallback-for-ai-plugins.md` — Task summary record.

## Verification
- Verified missing-key execution: Ran `env -u CONTEXT7_API_KEY bash scripts/setup-ai-plugins.sh` and confirmed safe skip of Context7 setup without prompts or errors (exit code 0).
- Verified `.env` parsing: Tested key extraction across multiple `.env` formatting styles (unquoted, quoted, whitespace around `=`).
- Verified `make ai-plugins`: Executed end-to-end target successfully.
- Verified git status: Confirmed `.env` and `.env.local` are ignored while `.env.example` is tracked.

## Related Docs
- [docs/tasks/2026-08-19-context7-pass-cli-integration.md](file:///Users/gregoriomelo/dev/dotfiles/docs/tasks/2026-08-19-context7-pass-cli-integration.md)
- [ai/rules/security.md](file:///Users/gregoriomelo/dev/dotfiles/ai/rules/security.md)
- [scripts/setup-ai-plugins.sh](file:///Users/gregoriomelo/dev/dotfiles/scripts/setup-ai-plugins.sh)
