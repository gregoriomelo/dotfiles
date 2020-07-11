export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"
plugins=(git brew pass kubectl)

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

source $ZSH/oh-my-zsh.sh

source ~/.config/zsh/aliases/git
source ~/.config/zsh/aliases/clojure
source ~/.config/zsh/aliases/vagrant
source ~/.config/zsh/aliases/docker
source ~/.config/zsh/aliases/brew
source ~/.config/zsh/aliases/misc
source ~/.config/zsh/aliases/kubernetes
source ~/.config/zsh/aliases/terraform
source ~/.config/zsh/aliases/vault
source ~/.config/zsh/aliases/aws
source ~/.config/zsh/aliases/gaming

for file in ~/.config/zsh/aliases/private/*
do
  if [[ -f $file ]]; then
    source $file
  fi
done

source ~/.config/zsh/env
source ~/.config/zsh/gnupg
source ~/.config/zsh/gopass

eval "$(rbenv init - zsh)"
