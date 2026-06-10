---
name: git-commit-assistant
description: Assists in writing git commit messages following the project's specific conventions, including scope formatting and concise why-focused summaries. Use this whenever you are asked to prepare, draft, or write a git commit message.
---

# Git Commit Assistant

This skill helps you draft git commit messages that adhere to the project's standards.

## Workflow

1. **Analyze changes**: Use `git status` and `git diff` to understand what was changed.
2. **Determine scope**: If the change is focused on a specific component, identify the scope (e.g., `auth`, `docker`, `ai`).
3. **Write summary**: Create a concise, present-tense summary (max 72 chars).
4. **Draft body**: If the change is complex, explain *why* it was done.

## Rules

- **Concise messages**: Explain *why*, not just *what*. The diff shows *what*.
- **Present tense**: "adds feature", not "added feature".
- **Scopes**: Use them when they clarify (e.g., `feat(auth): ...`). Skip for broad changes.
- **No Push/Commit**: Never commit or push unless explicitly instructed by the user.

## Helper Script

You can use the bundled script to generate a draft message:

```bash
node ai/skills/git-commit-assistant/scripts/generate-commit-message.cjs --scope "auth" --summary "add OAuth login support"
```
