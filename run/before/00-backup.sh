#!/bin/sh
set -o errexit -o nounset
source ../lib/setup.sh

is_symlink() {
  file="${1}"
  [ -f "$file" ] && [ -L "$file" ] && return 0
  [ -d "$file" ] && [ -L "$file" ] && return 0
  return 1
}

title "Backup"
packages=$(find "$DOTFILES/symlinks" -mindepth 2 -maxdepth 3)
for package in $packages; do
  filename=$(basename "$package")
  is_symlink "$HOME/$filename" && continue
  info "Moved $HOME/$filename => $DOTFILES_BACKUP/$filename"
  mv "$HOME/$filename" "$DOTFILES_BACKUP/$filename"
done
