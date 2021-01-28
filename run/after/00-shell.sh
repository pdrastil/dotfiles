#!/bin/sh
source ../lib/setup.sh

title "Default system shell"
# Set ZSH as default user shell for older macOS
if [ "$SHELL" = '/bin/bash' ]; then
  chsh -s /bin/zsh
fi

# Use latest version of ZSH from Homebrew
title "Default user shell"
if ! dscl . read "/Users/$USER" UserShell | grep -q '/usr/local/bin/zsh'; then
  sudo dscl . -create "/Users/$USER" UserShell /usr/local/bin/zsh
fi

# Install https://github.com/romkatv/zsh4humans
title "Zsh for humans"
if [ ! -d "$HOME/.cache/zsh4humans" ]; then
  package "Installing Zsh for humans..."
  if command -v curl >/dev/null 2>&1; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/romkatv/zsh4humans/v5/install)"
  else
    sh -c "$(wget -O- https://raw.githubusercontent.com/romkatv/zsh4humans/v5/install)"
  fi
fi
