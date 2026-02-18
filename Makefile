.PHONY: setup homebrew brew stow tpm macos nushell-init default-shell

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
	stow --verbose --dir=. --target=$$HOME aliases zsh git tmux glow nushell claude
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

nushell-init:
	@echo "Generating starship cache for nushell..."
	@mkdir -p $$HOME/.cache/starship
	starship init nu > $$HOME/.cache/starship/init.nu
	@echo "✓ Starship nushell cache written"
	@echo "Linking macOS nushell config dir to stow-managed ~/.config/nushell..."
	@NUDIR="$$HOME/Library/Application Support/nushell"; \
	    rm -f "$$NUDIR/config.nu" "$$NUDIR/env.nu"; \
	    ln -sf "$$HOME/.config/nushell/config.nu" "$$NUDIR/config.nu"; \
	    ln -sf "$$HOME/.config/nushell/env.nu" "$$NUDIR/env.nu"
	@echo "✓ Nushell macOS config dir linked"

default-shell:
	@echo "Registering nushell in /etc/shells and setting as default..."
	@if ! grep -q "/opt/homebrew/bin/nu" /etc/shells; then \
		echo "/opt/homebrew/bin/nu" | sudo tee -a /etc/shells; \
	fi
	chsh -s /opt/homebrew/bin/nu
	@echo "✓ Default shell set to nushell. Restart your terminal."
