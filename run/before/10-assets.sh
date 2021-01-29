#!/bin/sh
set -o errexit -o nounset
source ../lib/setup.sh

title "Nerd Fonts"
cp "$DOTFILES_ASSETS"/fonts/*.ttf "$HOME"/Library/Fonts/
