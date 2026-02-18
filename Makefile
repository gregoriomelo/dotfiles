.PHONY: setup homebrew brew stow tpm macos

setup: homebrew brew stow tpm macos
	@echo "✓ Bootstrap complete"

homebrew:
	@if ! command -v brew &> /dev/null; then \
		echo "Installing Homebrew..."; \
		/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; \
	else \
		echo "✓ Homebrew already installed"; \
	fi

brew: homebrew
	@echo "Installing packages from Brewfile..."
	brew bundle --file=Brewfile

stow: brew
	@echo "Symlinking dotfiles..."
	stow --verbose --dir=. --target=$$HOME aliases zsh git tmux glow
	@echo "✓ Dotfiles symlinked"

tpm:
	@if [ ! -d "$$HOME/.tmux/plugins/tpm" ]; then \
		echo "Cloning TPM..."; \
		mkdir -p $$HOME/.tmux/plugins; \
		git clone https://github.com/tmux-plugins/tpm $$HOME/.tmux/plugins/tpm; \
	else \
		echo "✓ TPM already installed"; \
	fi
	@if [ ! -d "$$HOME/.tmux/plugins/tmux" ]; then \
		echo "Cloning catppuccin/tmux..."; \
		git clone https://github.com/catppuccin/tmux $$HOME/.tmux/plugins/tmux; \
	else \
		echo "✓ catppuccin/tmux already installed"; \
	fi
	@echo "Installing TPM plugins..."
	@$$HOME/.tmux/plugins/tpm/bin/install_plugins || true
	@echo "✓ TPM plugins installed"

macos:
	@echo "Applying macOS defaults..."
	@bash scripts/macos-defaults.sh
	@killall Dock Finder &> /dev/null || true
	@echo "✓ macOS defaults applied"
