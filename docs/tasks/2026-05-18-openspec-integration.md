# Task: OpenSpec Integration

**Date:** 2026-05-18

## Goal
Install and configure OpenSpec (https://github.com/Fission-AI/OpenSpec) following the repository's "config as code" model, integrating it into the existing AI tool structure.

## What Was Done
- Added `openspec` to the AI section of the `Brewfile`.
- Created `ai/.openspec` directory and symlinked `rules` and `skills` to the shared AI rules/skills.
- Disabled OpenSpec telemetry globally by setting `OPENSPEC_TELEMETRY=0` in `zsh/.zprofile` and `nushell/.config/nushell/env.nu`.
- Added an `openspec-init` target to the `Makefile` and integrated it into the main `setup` workflow.
- Verified the setup by running `make stow` and `make openspec-init`.

## Key Decisions
- **AI Package Integration:** Followed the existing pattern for AI tools (Claude, Gemini, Pi) by placing OpenSpec's configuration within the `ai` Stow package and linking it to shared rules/skills.
- **Global Telemetry Opt-out:** Proactively disabled telemetry via environment variables in all supported shells to respect user privacy and adhere to the project's security-conscious model.
- **Makefile Initialization:** Added a dedicated initialization step to ensure symlinks are correctly established during the bootstrap process.

## Files Changed
- `Brewfile` — Added `openspec`.
- `ai/.openspec/` — New configuration structure for OpenSpec.
- `zsh/.zprofile` — Added `OPENSPEC_TELEMETRY=0`.
- `nushell/.config/nushell/env.nu` — Added `OPENSPEC_TELEMETRY = '0'`.
- `Makefile` — Added `openspec-init` target.

## Verification
- Run `openspec --version` to verify the CLI is installed.
- Check `~/.openspec/rules` and `~/.openspec/skills` are correctly linked.
- Verify environment variables are loaded in your shell (`echo $OPENSPEC_TELEMETRY`).

## Related Docs
- `README.md`
- `docs/tasks/2026-05-18-taskwarrior-config.md` — Previous configuration task following the same model.
