#!/usr/bin/env bash

set -e

BASE_PATH=${1:-$HOME}
DOTFILES_HOME=${BASE_PATH}/dotfiles

mkdir -p $BASE_PATH

echo "Getting my dotfiles and storing them at $DOTFILES_HOME"
if [ ! -d "$DOTFILES_HOME" ]; then
  git clone https://github.com/gregoriomelo/dotfiles.git $DOTFILES_HOME
else
  git -C $DOTFILES_HOME pull
fi

cd $DOTFILES_HOME

. scripts/checks.sh
. scripts/maximum-awesome.sh
. scripts/tmux.sh
. scripts/brew.sh
#sh scripts/oh-my-zsh.sh
. scripts/gpg.sh
. scripts/asdf.sh
. scripts/stow-all.sh
. scripts/gopass.sh
. scripts/system-preferences.sh
. scripts/gitbook.sh
