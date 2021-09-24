#!/bin/sh
# Dotfiles bootstrap installer
set -o errexit -o nounset

export DOTFILES=${1:-"${HOME}/.dotfiles"}

# Colors
RESET="\033[0m"
BOLD="\033[1m"
CYAN="\033[0;96m"
RED="\033[0;91m"
YELLOW="\033[0;93m"
#GREEN="\033[0;92m"

info() {
  echo "${CYAN}${*}${RESET}"
}

#success() {
#  echo "${GREEN}${*}${RESET}"
#}

error() {
  echo "${RED}${*}${RESET}"
}

title() {
  echo "${CYAN}==>${RESET} ${BOLD}${*}${RESET}"
}

package() {
  echo "${YELLOW}==>${RESET} ${*}"
}


if [ "$(uname)" != 'Darwin' ]; then
  error 'Installer is inteded only for macOS!'
  exit 1
fi

info '         __      __  _______ __         '
info '    ____/ /___  / /_/ ____(_) /__  _____'
info '   / __  / __ \/ __/ /_  / / / _ \/ ___/'
info ' _/ /_/ / /_/ / /_/ __/ / / /  __(__  ) '
info '(_)__,_/\____/\__/_/   /_/_/\___/____/  '
info '                                        '
info '              by @pdrastil              '
info '                                        '


package "Admin"
info 'Please enter sudo password to proceed with the installation'
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

package "Homebrew"
if ! command -v brew >/dev/null; then
  info 'Installing Homebrew...'
  sudo chown -R "$USER":admin /usr/local/*
  if command -v curl >/dev/null 2>&1; then
    echo | /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  else
    echo | /bin/bash -c "$(wget -O- https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
fi

package "Zero.sh"
if ! command -v zero >/dev/null; then
  info 'Installing Zero.sh...'
  brew install zero-sh/tap/zero
fi

package "Dotfiles"
if [ ! -d "$DOTFILES" ]; then
  git clone --recursive https://github.com/pdrastil/dotfiles.git "$DOTFILES"
else
  workdir=$(pwd)
  cd "$DOTFILES"
  git pull --ff-only
  git submodule update --init --recursive --quiet
  cd "$workdir"
  unset workdir
fi

# Run Zero.sh bootstrap
caffeinate -i zero setup --directory "$DOTFILES"
