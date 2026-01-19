export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"
plugins=(git brew rails)

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

source $ZSH/oh-my-zsh.sh

source ~/.config/zsh/aliases/git
source ~/.config/zsh/aliases/docker
source ~/.config/zsh/aliases/brew
source ~/.config/zsh/aliases/misc
source ~/.config/zsh/aliases/aws
source ~/.config/zsh/aliases/gaming

source ~/.config/zsh/env
source ~/.config/zsh/gnupg

eval "$(rbenv init - zsh)"
eval "$(direnv hook zsh)"
eval "$(starship init zsh)"

export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# Add JBang to environment
alias j!=jbang
export PATH="/opt/homebrew/bin/:/opt/homebrew/opt/python@3.13/libexec/bin:$HOME/.jbang/bin:$PATH"
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"

# Added by Windsurf
export PATH="/Users/gregoriomelo/.codeium/windsurf/bin:$PATH"

## [Completion]
## Completion scripts setup. Remove the following line to uninstall
[[ -f /Users/gregoriomelo/.dart-cli-completion/zsh-config.zsh ]] && . /Users/gregoriomelo/.dart-cli-completion/zsh-config.zsh || true
## [/Completion]


[[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path zsh)"

# Added by Antigravity
export PATH="/Users/gregoriomelo/.antigravity/antigravity/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
