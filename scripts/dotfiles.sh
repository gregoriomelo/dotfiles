#!/usr/bin/env bash

set -e

echo "Getting my dotfiles and storing them at $DOTFILES_HOME"
if [ ! -d "$DOTFILES_HOME" ]; then
  git clone https://github.com/gregoriomelo/dotfiles.git $DOTFILES_HOME
else
  git -C $DOTFILES_HOME pull
fi

echo "Applying my personal set up"
cd $DOTFILES_HOME
brew tap homebrew/bundle
brew bundle
sh scripts/stow-all.sh
