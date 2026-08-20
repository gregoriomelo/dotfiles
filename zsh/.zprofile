eval "$(/opt/homebrew/bin/brew shellenv zsh)"

export DEV_HOME="$HOME/dev"
export DOTFILES_HOME="$HOME/dev/dotfiles"

# Proton Pass CLI
export PROTON_PASS_KEY_PROVIDER=fs

# ai
export OPENSPEC_TELEMETRY=0
if [ -z "$CONTEXT7_API_KEY" ] && command -v pass-cli &>/dev/null; then
    export CONTEXT7_API_KEY="$(pass-cli item view "pass://Personal/Context7/password" 2>/dev/null)"
fi
