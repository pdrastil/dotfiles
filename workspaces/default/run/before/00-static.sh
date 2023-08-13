#!/bin/bash
set -o errexit -o nounset
DOTFILES=${DOTFILES:-"$HOME/.dotfiles"}
source "${DOTFILES}/lib/setup.sh"

title "Fonts"
rsync "$DOTFILES"/static/fonts/*.ttf "$HOME/Library/Fonts/"

title "SSH config"
if [[ ! -d "$HOME/.ssh" ]]; then
  mkdir -p "$HOME/.ssh" && chmod 700 "$HOME/.ssh"
  rsync -r "$DOTFILES"/static/ssh/* "$HOME/.ssh/"
fi
