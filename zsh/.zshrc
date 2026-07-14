# History
HISTFILE="$HOME/.zsh_history"
HISTSIZE=100000
SAVEHIST=100000
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt SHARE_HISTORY

# Atuin history sync
if command -v atuin &>/dev/null; then
    eval "$(atuin init zsh)"
fi

eval "$(starship init zsh)"

# opencode
export PATH=/Users/gregoriomelo/.opencode/bin:$PATH

# gpg
export GPG_TTY=$(tty)

source ~/.aliases

