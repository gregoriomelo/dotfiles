---
name: new-adr
description: >
  Generates a new Architecture Decision Record (ADR) in `docs/adr/` using the standard template.
  Activate when you or the user propose a significant change to tools, frameworks, or repository structure.
user-invocable: true
---

# New ADR Skill

You are responsible for ensuring that major technical decisions are documented before implementation begins.

## Protocol

### 1. Preparation
- Review `docs/adr/TEMPLATE.md` to understand the required structure.
- Determine the next sequential number for the ADR (e.g., if `001-stow.md` exists, create `002-new-decision.md`). If there are none, start with `001`.

### 2. Drafting
- Draft the content covering Context, Decision, Consequences (Positive/Negative), and Alternatives Considered based on the current discussion or proposal.

### 3. Execution
- Create the new file in `docs/adr/` (e.g., `docs/adr/001-adopt-nushell.md`).
- Output the drafted ADR content to the new file.

## Guidance
- Keep the language professional, objective, and focused on the technical tradeoffs.
- Inform the user that the ADR has been proposed and is awaiting their review before you proceed with any code or configuration changes.
