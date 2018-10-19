export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"
plugins=(git brew pass)

source $ZSH/oh-my-zsh.sh

# my aliases
source ~/.config/zsh/aliases/git
source ~/.config/zsh/aliases/clojure
source ~/.config/zsh/aliases/vagrant
source ~/.config/zsh/aliases/docker
source ~/.config/zsh/aliases/brew
source ~/.config/zsh/aliases/misc
source ~/.config/zsh/aliases/kubernetes
source ~/.config/zsh/aliases/private/*

source ~/.config/zsh/env
source ~/.config/zsh/gnupg
source ~/.config/zsh/gopass
