# OpenSpec Integration Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Install and configure OpenSpec following the repository's "config as code" model, integrating it into the existing AI tool structure.

**Architecture:**
- Global package managed via `Brewfile`.
- Configuration managed via `ai` Stow package, providing a `~/.openspec` directory linked to shared `rules/` and `skills/`.
- Telemetry disabled via environment variables in Zsh and Nushell.
- Automated initialization via `Makefile`.

**Tech Stack:** Homebrew, GNU Stow, Make, Zsh, Nushell, OpenSpec

---

### Task 1: Package and Structure Setup

**Files:**
- Modify: `Brewfile`
- Create: `ai/.openspec` (directory)
- Create: `ai/.openspec/rules` (symlink)
- Create: `ai/.openspec/skills` (symlink)

- [ ] **Step 1: Add OpenSpec to Brewfile**

Add `brew 'openspec'` to the `ai` section.

- [ ] **Step 2: Create directory structure and symlinks**

```bash
mkdir -p ai/.openspec
ln -sf ../rules ai/.openspec/rules
ln -sf ../skills ai/.openspec/skills
```

### Task 2: Environment Configuration

**Files:**
- Modify: `zsh/.zprofile`
- Modify: `nushell/.config/nushell/env.nu`

- [ ] **Step 1: Disable telemetry in Zsh**

Add `export OPENSPEC_TELEMETRY=0` to `zsh/.zprofile`.

- [ ] **Step 2: Disable telemetry in Nushell**

Add `$env.OPENSPEC_TELEMETRY = '0'` to `nushell/.config/nushell/env.nu`.

### Task 3: Makefile Integration and Verification

**Files:**
- Modify: `Makefile`

- [ ] **Step 1: Add openspec-init target to Makefile**

Add `openspec-init` to `.PHONY` and `setup` dependencies.
Add the implementation after `task-init`:

```makefile
openspec-init: stow
	@echo "Initializing OpenSpec..."
	@# Since openspec is project-based, we just verify the global symlinks
	@if [ -L "$$HOME/.openspec/rules" ]; then \
		echo "✓ OpenSpec global rules linked"; \
	else \
		echo "✗ OpenSpec global rules not linked properly"; \
	fi
```

- [ ] **Step 2: Run verification**

```bash
make stow
make openspec-init
```

### Task 4: Documentation and Finalize

**Files:**
- Create: `docs/tasks/2026-05-18-openspec-integration.md`

- [ ] **Step 1: Record the task**

Create the task report in `docs/tasks/`.

- [ ] **Step 2: Single Commit**

Stage all changes and commit.

```bash
git add .
git commit -m "feat: add openspec configuration and integration"
```
