#!/usr/bin/env bash

set -e

echo "Installing apps with homebrew"
cd $DOTFILES_HOME
brew tap homebrew/bundle
brew bundle
