#!/bin/sh

export readonly DOTFILES=${1:-"${HOME}/.dotfiles"}
export readonly DOTFILES_ASSETS="$DOTFILES/assets"
export readonly DOTFILES_BACKUP="$DOTFILES/backup"
export readonly DOTFILES_COMPLETIONS="$DOTFILES/completions"

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

subtitle() {
  echo "${YELLOW}==>${RESET} ${*}"
}

download() {
  if command -v curl >/dev/null 2>&1; then
    curl -fsSL "${1}"
  else
    wget -O- "${1}"
  fi
}

ask() {
  msg=$1
  default=${2:-"Y"}

  if [ "$default" = "Y" ]; then
    prompt="${GREEN}y${RESET}/N"
  else
    prompt="y/${GREEN}N${RESET}"
  fi

  while true; do
    printf "${msg} [${prompt}]: " && read -r answer
    if [ -z "$answer" ]; then
      answer="$default"
    fi

    case $answer in
      [Yy]*) return 0 ;;
      [Nn]*) return 1 ;;
    esac
  done
}
