# dotfiles/local-ai/Makefile
# Isolated lifecycle management for local AI development

SHELL := /usr/bin/env bash
.SHELLFLAGS := -eu -o pipefail -c
BREWFILE := Brewfile
MANIFEST := models.manifest

.PHONY: help setup serve models upgrade fit status

help:
	@echo "Local AI Management:"
	@echo "  make setup    - Install dependencies from Brewfile"
	@echo "  make serve    - Ensure Ollama background API server is running"
	@echo "  make models   - Pull all models declared in $(MANIFEST)"
	@echo "  make upgrade  - Upgrade packages and update model weights"
	@echo "  make fit      - Check hardware capabilities using llmfit"
	@echo "  make status   - Show running Ollama status and loaded models"

setup:
	@echo "==> Checking and installing dependencies..."
	@brew bundle check --file=$(BREWFILE) 2>/dev/null || brew bundle --file=$(BREWFILE)
	@echo "✓ Dependencies installed"

serve:
	@if curl -s -f http://localhost:11434/api/tags >/dev/null 2>&1; then \
		echo "✓ Ollama server is already running on http://localhost:11434"; \
	else \
		echo "==> Starting Ollama service..."; \
		if command -v brew >/dev/null && brew services list | grep -q ollama; then \
			brew services start ollama; \
		else \
			nohup ollama serve >/tmp/ollama-server.log 2>&1 & \
		fi; \
		echo "Waiting for Ollama to become available..."; \
		for i in {1..30}; do \
			if curl -s -f http://localhost:11434/api/tags >/dev/null 2>&1; then \
				echo "✓ Ollama is ready"; \
				break; \
			fi; \
			sleep 1; \
		done; \
		if ! curl -s -f http://localhost:11434/api/tags >/dev/null 2>&1; then \
			echo "✗ Timed out waiting for Ollama to start. Check /tmp/ollama-server.log" >&2; \
			exit 1; \
		fi; \
	fi

models: serve
	@echo "==> Pulling models from $(MANIFEST)..."
	@grep -v '^[[:space:]]*#' $(MANIFEST) | grep -v '^[[:space:]]*$$' | awk '{print $$1}' | while read -r model; do \
		echo "--> Pulling $$model..."; \
		ollama pull "$$model"; \
	done
	@echo "✓ All manifest models verified"

upgrade: setup
	@echo "==> Upgrading packages..."
	@brew bundle --file=$(BREWFILE)
	@$(MAKE) models
	@echo "✓ Local AI components upgraded"

fit:
	@echo "==> Hardware Analysis (llmfit)..."
	@llmfit system
	@echo ""
	@echo "==> Recommendations for your machine:"
	@llmfit recommend --limit 5

status:
	@if curl -s -f http://localhost:11434/api/tags >/dev/null 2>&1; then \
		echo "Ollama API: Running (http://localhost:11434)"; \
		echo ""; \
		echo "Installed models:"; \
		ollama list; \
	else \
		echo "Ollama API: Stopped (run 'make serve' to start)"; \
	fi
