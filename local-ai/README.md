# Local AI Development Environment

A standalone, version-controlled module for local LLM inference and terminal coding agents on Apple Silicon (M5 Pro, 48 GB Unified Memory).

## Key Design Principles

* **Config-as-Code**: All dependencies, model manifests, and agent configs are tracked in git.
* **Strict Isolation**: Intentionally separated from root dotfiles `Makefile` and `STOW_PACKAGES`. It is never executed automatically by `make setup`.
* **Hardware-Aware**: Integrates with `llmfit` to evaluate model size, memory bandwidth, and speed before downloading.
* **Multi-Agent**: Supports [OpenCode](https://opencode.ai) (primary) and [Pi](https://github.com/pi-coding/pi).

---

## Directory Structure

```
dotfiles/local-ai/
├── Brewfile                        # Declares ollama, opencode formulas
├── Makefile                        # Isolated lifecycle commands (setup, serve, models, upgrade, fit)
├── models.manifest                 # Plain-text list of target models to pull and keep updated
├── config/
│   ├── opencode-provider.json      # OpenCode local Ollama provider profile
│   └── pi-settings-snippet.json    # Pi local provider configuration
├── bin/
│   └── local-ai                    # Interactive CLI launcher
├── tests/                          # Automated verification suite
└── README.md                       # This guide
```

---

## Getting Started

### 1. Install Dependencies
Installs `ollama` and `opencode` via Homebrew bundle without touching global dotfiles:
```bash
make setup
```

### 2. Start the Local API Server
Ensures the background Ollama daemon is running at `http://localhost:11434`:
```bash
make serve
```

### 3. Pull Models
Pulls all models declared in `models.manifest`:
```bash
make models
```

### 4. Verify System Fit
Runs `llmfit` against your Apple Silicon hardware:
```bash
make fit
```

---

## Day-to-Day Workflow

### Launching an Agent
Run the interactive launcher:
```bash
./bin/local-ai
```
Or specify the agent and model directly:
```bash
# Launch OpenCode with Qwen 3 Coder 30B (default)
./bin/local-ai -a opencode -m qwen3-coder:30b

# Launch OpenCode with DeepSeek R1 32B for planning
./bin/local-ai -a opencode -m deepseek-r1:32b

# Launch Pi
./bin/local-ai -a pi -m qwen3:14b
```

### Diagnostic Check
To inspect server reachability and installed models without launching a session:
```bash
./bin/local-ai --check
```

### Agent Profiles & Configuration

* **OpenCode**: `bin/local-ai` automatically injects `config/opencode-provider.json` via `OPENCODE_CONFIG` and sets the selected model via `OPENCODE_CONFIG_CONTENT`. OpenCode also natively discovers local Ollama models under `ollama/<model_name>`.
* **Pi**: To register the local provider in Pi permanently, merge `config/pi-settings-snippet.json` into `~/.pi/agent/settings.json`.

---

## Maintenance & Upgrades

To upgrade Ollama, OpenCode, and re-pull the latest model weights:
```bash
make upgrade
```

---

## Optional Shell Alias

To make `local-ai` available from any project directory, add this alias to your shell configuration (`aliases/.aliases` or `zsh/.zshrc`):
```bash
alias ai="$HOME/dev/dotfiles/local-ai/bin/local-ai"
```
