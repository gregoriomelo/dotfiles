#!/usr/bin/env bash

set -e

BASE_PATH=${1:-$HOME}
DOTFILES_HOME=${BASE_PATH}/dotfiles

mkdir -p $BASE_PATH

. scripts/checks.sh
. scripts/maximum-awesome.sh
. scripts/tmux.sh
. scripts/dotfiles.sh
