#!/bin/sh
set -o errexit -o nounset
source ../lib/setup.sh

test_link() {
  file="${1}"
  [ -f "$file" ] && [ ! -L "$file" ] && return 0
  [ -d "$file" ] && [ ! -L "$file" ] && return 0
  return 1
}

title "Saving existing dotfiles..."
packages=$(find "$DOTFILES/symlinks" -mindepth 2 -maxdepth 3)
for file in $packages; do
  filename=$(basename "$file")
  if test_link "$HOME/$filename"; then
    info "Moved $HOME/$filename => $DOTFILES/bak/$filename"
    mv "$HOME/$filename" "$DOTFILES/bak/$filename"
  fi
done
