#!/usr/bin/env bash

set -e

echo "Installing apps with homebrew"
cd $DOTFILES_HOME

brew tap mas-cli/tap
brew install mas

# installs xcode and accepts its license
if [ ! -d /Applications/Xcode.app ]; then
  mas install 497799835
  sudo xcodebuild -license accept
fi

# and now installs the rest of the stuff
brew tap homebrew/bundle
brew bundle
