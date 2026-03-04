# git instructions
- Use concise messages, that explain why something was done. Don't focus too much on the technical details. The diff will cover the details.
- Only create branches if asked to. Otherwise use main.

- Use scopes when they clarify what component/area changed:
  - `feat(auth): add OAuth login support`
  - `fix(docker): resolve container networking issue`
  - `chore(deps): update React to v18`

- Skip scopes for broad/obvious changes:
  - `feat: implement user dashboard`
  - `fix: resolve memory leak in background tasks`

- Prefer present tense: "adds feature" not "added feature"
- Keep first line under 72 characters when possible
- Use body text for complex changes requiring explanation
- Reference issues/PRs when relevant: `fixes #123`

- Always add git trailers to identify AI-assisted commits:

```
feat(auth): add OAuth login support

Optional body text.

Coding-Agent: Claude Code
Model: claude-sonnet-4-20250514
```

- `Coding-Agent`: the tool name (e.g. `Claude Code`, `pi`). Include version if available.
- `Model`: the most specific model identifier available (e.g. `claude-sonnet-4-20250514`).
- Trailers go after a blank line following the body (or subject if no body).
