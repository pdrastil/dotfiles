#!/bin/sh

export DOTFILES=${1:-"${HOME}/.dotfiles"}

# Colors
readonly RESET="\033[0m"
readonly BOLD="\033[1m"
readonly CYAN="\033[0;96m"
readonly RED="\033[0;91m"
readonly YELLOW="\033[0;93m"
readonly GREEN="\033[0;92m"

# Messages
info() {
  echo "${CYAN}${*}${RESET}"
}

warn() {
  echo "${YELLOW}${*}${RESET}"
}

error() {
  echo "${RED}${*}${RESET}"
}

success() {
  echo "${GREEN}${*}${RESET}"
}

title() {
  echo "${CYAN}==>${RESET} ${BOLD}${*}${RESET}"
}

package() {
  echo "${YELLOW}==>${RESET} ${*}"
}

download() {
  if command -v curl >/dev/null 2>&1; then
    curl -fsSL "${1}"
  else
    wget -O- "${1}"
  fi
}
