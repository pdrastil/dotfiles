#!/bin/bash
set -o errexit -o nounset
DOTFILES=${DOTFILES:-"${HOME}/.dotfiles"}
source "${DOTFILES}/lib/setup.sh"

if brew list --cask | grep -q parallels; then
  title "Parallels Desktop"
  if command -v vagrant >/dev/null; then
    subtitle "Vagrant"
    if ! vagrant plugin list | grep -q vagrant-parallels; then
      vagrant plugin install vagrant-parallels
    fi
  fi
fi
