#!/bin/bash
set -o nounset

# Colors
readonly RESET="\033[0m"
readonly BOLD="\033[1m"
readonly CYAN="\033[0;96m"
readonly RED="\033[0;91m"
readonly YELLOW="\033[0;93m"
readonly GREEN="\033[0;92m"

# Prompt functions
info() {
  echo -e "${CYAN}${*}${RESET}"
}

warn() {
  echo -e "${YELLOW}${*}${RESET}"
}

error() {
  echo -e "${RED}${*}${RESET}"
}

success() {
  echo -e "${GREEN}${*}${RESET}"
}

title() {
  echo -e "${GREEN}==>${RESET} ${BOLD}${*}${RESET}"
}

subtitle() {
  echo -e "${CYAN}==>${RESET} ${*}"
}

download() {
  if command -v curl >/dev/null 2>&1; then
    curl -fsSL "${1}"
  else
    wget -O- "${1}"
  fi
}

function ask() {
  msg=${1:-""}
  default=${2:-"Y"}

  if [ "$default" = "Y" ]; then
    dialog="${GREEN}y${RESET}/N"
  else
    dialog="y/${GREEN}N${RESET}"
  fi

  while true; do
    printf '%b [%b]: ' "$msg" "$dialog" && read -er answer
    if [ -z "$answer" ]; then
      answer="$default"
    fi

    case $answer in
      [Yy]*) return 0 ;;
      [Nn]*) return 1 ;;
    esac
  done
}
