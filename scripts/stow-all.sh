#!/usr/bin/env bash

set -e

echo "Applying my personal set up with stow"
PROGRAMS=(git zsh vim ruby starship nix)
STOW_DIR=~

rm -f ~/.gitconfig
rm -f ~/.zshrc
rm -f ~/.vimrc.bundles.local
rm -f ~/.vimrc.local

for program in ${PROGRAMS[@]}; do
  echo "Stowing $program"
  stow -t $STOW_DIR $program
done

# gnupg
echo "Stowing gnupg"
stow -t $STOW_DIR/.gnupg gnupg

# clojure
echo "Stowing clojure"
rm -f ~/.clojure/deps.edn
stow -t $STOW_DIR/.clojure clojure

echo "Done!"
