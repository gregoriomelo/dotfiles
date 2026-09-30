eval "$(/opt/homebrew/bin/brew shellenv zsh)"

export DEV_HOME="$HOME/dev"
export DOTFILES_HOME="$HOME/dev/dotfiles"

# Proton Pass CLI
export PROTON_PASS_KEY_PROVIDER=fs

# ai
export OPENSPEC_TELEMETRY=0
if [ -z "$CONTEXT7_API_KEY" ]; then
    for env_file in "$DOTFILES_HOME/.env" "$HOME/.env"; do
        if [ -f "$env_file" ]; then
            val="$(grep -E '^[[:space:]]*(export[[:space:]]+)?CONTEXT7_API_KEY[[:space:]]*=' "$env_file" 2>/dev/null | tail -n 1 | sed -E 's/^[[:space:]]*(export[[:space:]]+)?CONTEXT7_API_KEY[[:space:]]*=[[:space:]]*//' | tr -d '"' | tr -d "'" | tr -d '\r' | xargs)"
            if [ -n "$val" ]; then
                export CONTEXT7_API_KEY="$val"
                break
            fi
        fi
    done
    if [ -z "$CONTEXT7_API_KEY" ] && command -v pass-cli &>/dev/null; then
        export CONTEXT7_API_KEY="$(pass-cli item view "pass://Personal/Context7/password" 2>/dev/null)"
        if [ -n "$CONTEXT7_API_KEY" ] && [ -d "$DOTFILES_HOME" ] && [ ! -f "$DOTFILES_HOME/.env" ]; then
            printf 'CONTEXT7_API_KEY="%s"\n' "$CONTEXT7_API_KEY" > "$DOTFILES_HOME/.env" 2>/dev/null || true
        fi
    fi
fi
