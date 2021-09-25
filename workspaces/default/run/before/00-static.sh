#!/bin/bash
set -o errexit -o nounset
DOTFILES=${DOTFILES:-"$HOME/.dotfiles"}
source "${DOTFILES}/lib/setup.sh"

title "Fonts"
rsync "$DOTFILES"/static/fonts/*.ttf "$HOME"/Library/Fonts/
