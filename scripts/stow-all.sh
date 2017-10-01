#!/usr/bin/env bash

set -e

PROGRAMS=(git zsh tmux vim ruby)
STOW_DIR=~

for program in ${PROGRAMS[@]}; do
  stow -t $STOW_DIR $program
  echo "Stowing $program"
done

# gnupg
stow -t $STOW_DIR/.gnupg gnupg
echo "Stowing gnupg"

echo "Done!"
