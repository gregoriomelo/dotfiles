STOW_PACKAGES := aliases zsh git tmux glow nushell claude ghostty

.PHONY: setup homebrew brew stow clean-stow-conflicts tpm macos nushell-init ghostty-init default-shell

setup: homebrew brew stow tpm macos nushell-init ghostty-init
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

clean-stow-conflicts:
	@echo "Removing conflicting files in $$HOME..."
	@for pkg in $(STOW_PACKAGES); do \
		find $$pkg -type f | while read f; do \
			rel="$${f#$$pkg/}"; \
			target="$$HOME/$$rel"; \
			if [ -L "$$target" ] && readlink "$$target" | grep -q "dev/dotfiles"; then \
				continue; \
			fi; \
			dir="$$HOME"; \
			skip=false; \
			for part in $$(echo "$$rel" | tr '/' ' '); do \
				dir="$$dir/$$part"; \
				if [ -L "$$dir" ] && readlink "$$dir" | grep -q "dev/dotfiles"; then \
					skip=true; \
					break; \
				fi; \
			done; \
			if [ "$$skip" = true ]; then \
				continue; \
			fi; \
			if [ -e "$$target" ] || [ -L "$$target" ]; then \
				echo "  removing $$target"; \
				rm -f "$$target"; \
			fi; \
		done; \
	done

stow: brew clean-stow-conflicts
	@echo "Symlinking dotfiles..."
	stow --verbose --dir=. --target=$$HOME $(STOW_PACKAGES)
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

nushell-init: stow
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

ghostty-init: stow
	@echo "Linking macOS Ghostty config to stow-managed ~/.config/ghostty..."
	@GDIR="$$HOME/Library/Application Support/com.mitchellh.ghostty"; \
	    mkdir -p "$$GDIR"; \
	    rm -f "$$GDIR/config"; \
	    ln -sf "$$HOME/.config/ghostty/config" "$$GDIR/config"
	@echo "✓ Ghostty macOS config linked"

default-shell:
	@echo "Registering nushell in /etc/shells and setting as default..."
	@if ! grep -q "/opt/homebrew/bin/nu" /etc/shells; then \
		echo "/opt/homebrew/bin/nu" | sudo tee -a /etc/shells; \
	fi
	chsh -s /opt/homebrew/bin/nu
	@echo "✓ Default shell set to nushell. Restart your terminal."
