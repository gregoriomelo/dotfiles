#!/usr/bin/env bash

set -e

echo "Applying my personal set up with stow"
PROGRAMS=(git zsh tmux vim ruby)
STOW_DIR=~

rm -f ~/.gitconfig
rm -f ~/.tmux.conf
rm -f ~/.zshrc
rm -f ~/.vimrc.bundles.local
rm -f ~/.vimrc.local

for program in ${PROGRAMS[@]}; do
  stow -t $STOW_DIR $program
  echo "Stowing $program"
done

# gnupg
stow -t $STOW_DIR/.gnupg gnupg
echo "Stowing gnupg"

echo "Done!"
