#!/bin/sh
source ../lib/setup.sh
set -o errexit -o nounset

# Extra shell completions
readonly COMPLETION_URLS=$(cat << EOF
https://raw.githubusercontent.com/docker/docker-ce/master/components/cli/contrib/completion/zsh/_docker
https://raw.githubusercontent.com/docker/compose/master/contrib/completion/zsh/_docker-compose
EOF
)

# Use latest version of ZSH from Homebrew
title "Default user shell"
if ! dscl . read "/Users/$USER" UserShell | grep -q '/usr/local/bin/zsh'; then
  sudo dscl . -create "/Users/$USER" UserShell /usr/local/bin/zsh
fi

title "Shell completions"
echo "$COMPLETION_URLS" | while read -r url; do
  filename=$(basename "$url")
  subtitle "Downloading completion '$filename'..."
  download "$url" > "$DOTFILES_COMPLETIONS/$filename"
done
