#!/usr/bin/env bash

set -e

export GPG_TTY=`tty`

# clones password store
if [ ! -d ~/.password-store ]; then
  echo "Cloning the password store"
  read -p "URL for the git repository for your password store: " PASSWORD_STORE_REPOSITORY
  gopass clone $PASSWORD_STORE_REPOSITORY
fi
