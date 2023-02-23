#!/usr/bin/env bash

set -e

echo "Setting up vim Square's Maximum Awesome at ${PWD}/maximum-awesome"
if [ ! -d "${PWD}/maximum-awesome" ]; then
  git clone https://github.com/square/maximum-awesome.git
fi
cd ${PWD}/maximum-awesome
rake
cd $DOTFILES_HOME
