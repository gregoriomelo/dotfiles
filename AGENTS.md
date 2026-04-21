# Project Agents

This file describes the specialized agent personalities (subagents) available for the **dotfiles** project. These agents are project-scoped and should be used to maintain repository conventions.

## @steward
**Role:** Expert in dotfiles maintenance, GNU Stow, and Makefile integrity.
**Location:** `.agents/steward.md`
**Usage:** Call with `@steward` to ensure any new tools or configurations follow the repository's patterns.

---

### Shared Agent Rules (ai/rules/)
These rules are loaded by the main agents (Claude, Gemini, Pi) for all project tasks:
- **git.md:** Conventional commits and AI-assisted commit trailers.
- **docs.md:** Proactive ADRs and task-recorder automation.
- **testing.md:** Coverage and mutation testing standards.
- **coding.md:** Preferred aesthetic and functional coding preferences.
- **design.md:** Professional design thinking for visual output.
- **product.md:** Incremental roadmap and parallelization strategies.
- **security.md:** Credential leakage prevention and SAST scanning.

### Agent Skills (ai/skills/)
On-demand capabilities available to all agents:
- **task-recorder:** Automates the generation of `docs/tasks/` summaries.
- **usage-tracker:** Monitors Claude plan usage and session costs.
- **design:** Activates design director mode for visual artifacts.
