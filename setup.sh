#!/bin/zsh

declare DOTFILES_HOME=${HOME}/dev/dotfiles

# Check for required dependencies before continuing:
hash git 2>/dev/null || { echo "Error: git is not installed. Please install git first."; exit 1;}

hash curl 2>/dev/null || { echo "Error: curl is not installed. Please install curl first."; exit 1;}

hash ruby 2>/dev/null || { echo "Error: ruby is not installed. Please install stow first."; exit 1;}

hash brew 2>/dev/null || { echo "Installing Homebrew"; /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)";}

if [ ! -d "$DOTFILES_HOME" ]; then
  git clone https://github.com/jonathanwiesel/dotfiles.git $DOTFILES_HOME
else
  git -C $DOTFILES_HOME pull
fi

# Set up tmux plugin manager:
mkdir -p ~/.tmux/plugins
if [ ! -d ~/.tmux/plugins/tpm ]; then
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

cd $DOTFILES_HOME
brew tap homebrew/bundle
brew bundle
sh bin/stow-all
