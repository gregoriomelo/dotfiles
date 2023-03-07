export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"
plugins=(git brew)

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

export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
