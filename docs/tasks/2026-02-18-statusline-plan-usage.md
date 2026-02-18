# Task: Fix Statusline Plan Usage Display

**Date:** 2026-02-18

## Goal

Fix the stale plan usage display in the Claude Code status line.

## Problem

The statusline script was fetching plan usage from `claude.ai/api/organizations/.../usage` using a cookie file that didn't exist. The cached values in `~/.claude/plan-usage-cache.json` and `~/.claude/plan-usage.json` were stale, so the displayed percentage never changed.

## Investigation

We explored several approaches to get live plan data:

| Approach | Result |
|---|---|
| OAuth API (`api.anthropic.com/api/oauth/usage`) | HTTP 401 — "OAuth authentication is currently not supported" |
| `claude.ai` API with OAuth token | HTTP 403 — Blocked by Cloudflare bot protection |
| `claude.ai` API with browser cookies | Requires `cf_clearance` cookie that expires every ~30 min |
| **Local `~/.claude/plan-usage.json`** | ✅ Already exists, written by Claude Code |

`~/.claude/plan-usage.json` is the right source — Claude Code maintains it, and `update-plan-usage.sh` is the manual refresh helper.

## What Was Done

1. **Replaced cookie/OAuth API fetch with local file read** — reads `plan-usage.json` directly.
2. **Added session cost fallback** — when `plan-usage.json` is missing or empty, shows `$0.42` from `cost.total_cost_usd` in the stdin JSON.
3. **Simplified the script** — removed all HTTP fetching, cache TTL logic, and the broken legacy fallbacks.

## How to Update Plan Usage

```bash
# 1. Open https://claude.ai/settings/usage in your browser
# 2. Note the % used and minutes until reset, then run:
update-plan-usage.sh <used_percent> <reset_in_minutes>

# Example: 21% used, resets in 2h 8min (128 minutes)
update-plan-usage.sh 21 128
```

This writes to `~/.claude/plan-usage.json`:
```json
{ "used_percent": 21, "reset_epoch": 1771006692 }
```

## Display Formats

- **With valid plan-usage.json:** `plan:21% (↺2h8m)`
- **After reset epoch passes:** `plan:21%` (no countdown)
- **No plan-usage.json:** `$0.42` (session cost fallback)

## Files Changed

- `claude/.claude/statusline-command.sh`

## Verification

```bash
# Should show plan % from ~/.claude/plan-usage.json
echo '{"model":{"id":"claude-opus-4-6","display_name":"Claude Opus 4"},"context_window":{"used_percentage":12},"cost":{"total_cost_usd":0.42}}' \
  | bash ~/.claude/statusline-command.sh

# Test fallback: temporarily move plan-usage.json aside
mv ~/.claude/plan-usage.json ~/.claude/plan-usage.json.bak
echo '{"model":{"id":"claude-opus-4-6","display_name":"Claude Opus 4"},"context_window":{"used_percentage":12},"cost":{"total_cost_usd":0.42}}' \
  | bash ~/.claude/statusline-command.sh
mv ~/.claude/plan-usage.json.bak ~/.claude/plan-usage.json
```

## Related Docs

- [Claude Code Config Task](./2026-02-18-claude-code-config.md)
- [README.md](../../README.md)
