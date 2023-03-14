#!/usr/bin/env bash

set -e

DOTFILES_HOME=${PWD}

echo "Getting my dotfiles and storing them at $DOTFILES_HOME"
if [ ! -d "$DOTFILES_HOME" ]; then
  git clone https://github.com/gregoriomelo/dotfiles.git $DOTFILES_HOME
else
  git -C $DOTFILES_HOME pull
fi

cd $DOTFILES_HOME

. scripts/checks.sh
#. scripts/maximum-awesome.sh
. scripts/brew.sh
. scripts/oh-my-zsh.sh
. scripts/gpg.sh
. scripts/stow-all.sh
. scripts/system-preferences.sh
. scripts/talisman.sh
