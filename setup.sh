#!/usr/bin/env bash

set -e

BASE_PATH=${1:-$HOME}
DOTFILES_HOME=${BASE_PATH}/dotfiles

mkdir -p $BASE_PATH

. scripts/dotfiles.sh

cd $DOTFILES_HOME

. scripts/checks.sh
. scripts/maximum-awesome.sh
. scripts/tmux.sh
. scripts/brew.sh
sh scripts/oh-my-zsh.sh
. scripts/gpg.sh
. scripts/stow-all.sh
