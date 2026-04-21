# Task: AI Agent Enhancements (Project Scoped)

**Date:** 2026-04-21

## Goal
Enhance the AI agent experience (Claude, Gemini, Pi) within the dotfiles repository by providing specialized project-scoped skills, rules, and subagents.

## What Was Done
1.  **Project-Scoped Agents:** Created `.agents/steward.md` at the repository root to define the `@steward` personality.
2.  **Central Manifest:** Created a root-level `AGENTS.md` to index all specialized agents and provide a clear overview for any coding agent (Claude, Gemini, Pi).
3.  **Global Rule Cleanup:** Removed global `pi/` stow package configurations to ensure the dotfiles steward is only active within this project.
4.  **Task Recorder Skill:** Created `ai/skills/task-recorder/SKILL.md` to automate standardized documentation in `docs/tasks/`.
5.  **Usage Tracker Skill:** Created `ai/skills/usage-tracker/SKILL.md` to monitor resource consumption.
6.  **Config Sync:** Updated `CLAUDE.md` and `GEMINI.md` to reference the new root `AGENTS.md`.
7.  **Makefile Update:** Added `pi` to the `quarantine-clean` target.

## Key Decisions
- **Project-Scope First:** Transitioned from a global stow-based agent setup to a repository-root setup (`.agents/` and `AGENTS.md`) for better isolation and cross-agent compatibility.
- **Shared Source of Truth:** Continued using `ai/rules/` and `ai/skills/` as common resources shared between all tools.
- **Proactive Documentation:** Hardcoded the requirement for ADRs and automated task summaries into the core `docs.md` rules.

## Files Changed
- `AGENTS.md` (new) — Project-wide agent manifest
- `.agents/steward.md` (new) — Dotfiles subagent definition
- `ai/skills/task-recorder/SKILL.md` (new) — Documentation automation
- `ai/skills/usage-tracker/SKILL.md` (new) — Usage monitoring
- `ai/rules/docs.md` — Updated documentation rules
- `claude/.claude/CLAUDE.md` — Added agent manifest reference
- `gemini/.gemini/GEMINI.md` — Added agent manifest reference
- `Makefile` — Updated quarantine-clean target
- `pi/` — Cleaned up global agent configs

## Verification
- Verified `.agents/steward.md` exists and contains correct YAML frontmatter.
- Verified `AGENTS.md` correctly lists all shared rules and skills.
- The presence of this file in `docs/tasks/` verifies the new `@task-recorder` workflow.

## Related Docs
- [README.md](../../README.md)
- [ADR Index (Future)](../adr/)
