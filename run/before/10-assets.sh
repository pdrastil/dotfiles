#!/bin/sh
set -o errexit -o nounset
source ../lib/setup.sh

title "Fonts"
find "$DOTFILES_ASSETS/fonts" -name '*.ttf' -exec ln '{}' "$HOME/Library/Fonts/" \;

title "Shell"
if brew list --cask | grep -q docker; then
  subtitle "Docker completions"
  ln -s /Applications/Docker.app/Contents/Resources/etc/docker.zsh-completion /usr/local/share/zsh/site-functions/_docker
  ln -s /Applications/Docker.app/Contents/Resources/etc/docker-compose.zsh-completion /usr/local/share/zsh/site-functions/_docker-compose
fi
