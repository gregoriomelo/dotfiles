#!/bin/zsh

declare BASE_PATH=${1:-$HOME}
declare DOTFILES_HOME=${BASE_PATH}/dotfiles

mkdir -p $BASE_PATH

echo "Checking for required dependencies before continuing..."
hash git 2>/dev/null || { echo "Error: git is not installed. Please install git first."; exit 1;}
hash curl 2>/dev/null || { echo "Error: curl is not installed. Please install curl first."; exit 1;}
hash ruby 2>/dev/null || { echo "Error: ruby is not installed. Please install stow first."; exit 1;}
hash brew 2>/dev/null || { echo "Installing Homebrew"; /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)";}

echo "Setting up vim Square's Maximum Awesome at $BASE_PATH/maximum-awesome"
if [ ! -d "$BASE_PATH/maximum-awesome" ]; then
  cd $BASE_PATH
  git clone https://github.com/square/maximum-awesome.git
fi
cd $BASE_PATH/maximum-awesome
rake

echo "Getting my dotfiles and storing them at $DOTFILES_HOME"
if [ ! -d "$DOTFILES_HOME" ]; then
  git clone https://github.com/gregoriomelo/dotfiles.git $DOTFILES_HOME
else
  git -C $DOTFILES_HOME pull
fi

echo "Setting up tmux plugin manager"
mkdir -p ~/.tmux/plugins
if [ ! -d ~/.tmux/plugins/tpm ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

echo "Applying my personal set up"
rm ~/.tmux.conf
cd $DOTFILES_HOME
brew tap homebrew/bundle
brew bundle
sh bin/stow-all
