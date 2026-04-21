---
name: usage-tracker
description: >
  Tracks and reports current usage across all AI agents (Claude, Gemini, Pi).
  Uses `~/.claude/plan-usage.json` and session token metrics to provide insights.
user-invocable: true
---

# Usage Tracker Skill

This skill provides a comprehensive view of your current AI resource consumption.

## Data Sources

1. **Claude Code Usage:** Read `~/.claude/plan-usage.json`.
2. **Session Cost:** Calculate based on current tokens (inbound + outbound).

## Protocol

### 1. Data Retrieval
- Access `~/.claude/plan-usage.json` to get `used_percent` and `reset_epoch`.
- Calculate time remaining until reset if `reset_epoch` is present.

### 2. Analysis
- Interpret the usage percentage:
  - **Low (0-50%):** Standard operation.
  - **Medium (50-85%):** Suggest more concise responses or batching.
  - **High (>85%):** Recommend switching to a different agent or delaying complex tasks.

### 3. Reporting
- Display the status in a compact format:
  ```text
  [Plan Status]
  Claude Plan: [used_percent]% (Resets in [minutes]m)
  Session Cost: $[cost_usd]

  [Insight]
  [Brief advice based on usage]
  ```

## Guidance
- If the user asks "How am I doing on usage?" or "What's my budget?", activate this skill.
- Proactively notify the user if consumption is high (>85%) before starting a major task.
