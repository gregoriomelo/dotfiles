---
name: task-recorder
description: >
  Generates a standardized task summary in `docs/tasks/` based on current changes and session history.
  Activate when you finish a significant task or when the user says "Record this task" or "I'm done."
user-invocable: true
---

# Task Recorder Skill

You are responsible for maintaining the high standard of documentation in this repository. When activated, your goal is to synthesize the work done during this session into a clear, concise, and structured task report.

## Protocol

### 1. Research phase
- Run `git status` and `git diff HEAD` to see exactly what files were modified or created.
- Review the session history to identify the key goals and decisions made.
- Look at `docs/tasks/` to identify the date and naming convention (e.g., `2026-03-17-vim-plugins.md`).

### 2. Strategy phase
- Determine the appropriate filename: `YYYY-MM-DD-short-description.md`.
- Identify the "Goal", "Key Decisions", and "Files Changed".

### 3. Execution phase
- Create the file in `docs/tasks/`.
- Use the following Markdown structure:
  ```markdown
  # Task: [Clear Title]

  **Date:** YYYY-MM-DD

  ## Goal
  [1-2 sentences on what was the initial objective]

  ## What Was Done
  [Bullet points of physical changes made]

  ## Key Decisions
  [Rationale for specific technical choices or architectural directions]

  ## Files Changed
  - `path/to/file` — [short description of change]

  ## Verification
  [How you or the user can verify the change is working as expected]

  ## Related Docs
  - [Link to other docs or README sections]
  ```

### 4. Finality
- Do not just write the file; confirm to the user that the task has been recorded and provide the path to the new document.
- If a related ADR was created, ensure it is linked in the "Related Docs" section.
