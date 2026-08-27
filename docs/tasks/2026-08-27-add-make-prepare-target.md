# Task: Add Make Prepare Target and Pre-Flight Checklist

**Date:** 2026-08-27

## Goal
Implement `make prepare` and `scripts/prepare.sh` to provide an interactive, clean CLI pre-flight checklist for fresh machine setup, verifying prerequisites and resolving configuration gaps before running `make setup`.

## What Was Done
- **Pre-flight Checklist Script ([scripts/prepare.sh](file:///Users/gregoriomelo/dev/dotfiles/scripts/prepare.sh)):**
  - Created an interactive, colored CLI checklist covering 6 pre-flight checks:
    1. **Xcode Command Line Tools:** Verifies installation via `xcode-select -p`. If missing, prompts to run `xcode-select --install`.
    2. **Sudo Privileges:** Verifies and caches administrative credentials via `sudo -v`.
    3. **Mac App Store Login:** Reminds user to sign into the App Store app for `mas` apps (Xcode, Magnet, The Unarchiver) and inspects `mas account` if installed.
    4. **GPG Key Presence:** Checks keyring for key `A37F13909665B893`. If absent and `~/.gitconfig.local` does not exist, prompts user to generate `~/.gitconfig.local` with `[commit] gpgsign = false`.
    5. **.env Configuration:** Checks for presence of `.env` and `CONTEXT7_API_KEY`. If missing, prompts to copy `.env.example` to `.env`.
    6. **GitHub SSH Connectivity:** Tests GitHub authentication via `ssh -T -o StrictHostKeyChecking=accept-new -o BatchMode=yes -o ConnectTimeout=5 git@github.com`.
  - Added non-interactive fallbacks so the script runs safely in automated environments without blocking.
  - Final summary section categorizes issues into blockers vs non-blocking reminders, and offers to execute `make setup` immediately if critical checks pass.
  - Set executable permissions `100755` with `chmod +x` and `git update-index --chmod=+x`.
- **Makefile Integration ([Makefile](file:///Users/gregoriomelo/dev/dotfiles/Makefile)):**
  - Added `prepare` to `.PHONY`.
  - Added `prepare` target calling `@bash scripts/prepare.sh`.
- **Documentation Updates ([README.md](file:///Users/gregoriomelo/dev/dotfiles/README.md)):**
  - Updated "Quick Start" to feature `make prepare` as step 1 and `make setup` as step 2.
  - Updated "Make Targets" table to document `make prepare`.
  - Added `scripts/prepare.sh` to the directory tree and documentation references.

## Key Decisions
- **Non-Interactive Resilience:** Handled non-interactive terminal sessions gracefully by avoiding blocking `sudo -v` and interactive prompts when stdin is redirected, preventing hanging during automated tasks or tests.
- **Fail-Safe Git Signing Override:** Automatically offered to generate `~/.gitconfig.local` with `[commit] gpgsign = false` if the author's personal GPG key is not imported yet, preventing fatal commit errors on new systems.
- **Seamless Setup Transition:** Once all critical checks pass, user is given a prompt to trigger `make setup` immediately, reducing onboarding friction to a single streamlined workflow.

## Files Changed
- `scripts/prepare.sh` — Interactive pre-flight checklist script.
- `Makefile` — Added `prepare` target and `.PHONY` declaration.
- `README.md` — Updated Quick Start and Make Targets documentation.
- `docs/tasks/2026-08-27-add-make-prepare-target.md` — Task documentation record.

## Verification
- `bash -n scripts/prepare.sh`: Verified clean shell script syntax.
- `make -n prepare`: Verified Makefile target correctly executes `bash scripts/prepare.sh`.
- `make -n`: Verified default goal remains `setup`.
- `./scripts/prepare.sh < /dev/null`: Verified non-interactive execution, check evaluation, and summary output.
- `git ls-files --stage scripts/prepare.sh`: Verified executable file mode `100755`.

## Related Docs
- [README.md](file:///Users/gregoriomelo/dev/dotfiles/README.md)
- [docs/tasks/2026-08-27-fresh-machine-bootstrap-evaluation-and-fixes.md](file:///Users/gregoriomelo/dev/dotfiles/docs/tasks/2026-08-27-fresh-machine-bootstrap-evaluation-and-fixes.md)
- [docs/tasks/2026-08-27-mas-in-brewfile-and-gitconfig-local-template.md](file:///Users/gregoriomelo/dev/dotfiles/docs/tasks/2026-08-27-mas-in-brewfile-and-gitconfig-local-template.md)
