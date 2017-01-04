export ZSH=/Users/gregoriomelo/.oh-my-zsh
ZSH_THEME="robbyrussell"
plugins=(git brew aws)

source $ZSH/oh-my-zsh.sh

eval "$(pyenv init -)"

# My aliases
source ~/.config/zsh/aliases/git
source ~/.config/zsh/aliases/clojure
source ~/.config/zsh/aliases/vagrant
source ~/.config/zsh/aliases/docker
source ~/.config/zsh/aliases/misc
source ~/.config/zsh/env
