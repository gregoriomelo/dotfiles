#!/usr/bin/env bash

set -e

echo "Setting up vim Square's Maximum Awesome at $BASE_PATH/maximum-awesome"
if [ ! -d "$BASE_PATH/maximum-awesome" ]; then
  cd $BASE_PATH
  git clone https://github.com/square/maximum-awesome.git
fi
cd $BASE_PATH/maximum-awesome
rake
cd $DOTFILES_HOME
