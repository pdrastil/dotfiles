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
  subtitle "Installing Zsh for humans..."
  sh -c "$(download https://raw.githubusercontent.com/romkatv/zsh4humans/v5/install)"
fi


# Docker completion
if [ ! -f ../completion/_docker ]; then
  download https://raw.githubusercontent.com/docker/docker-ce/master/components/cli/contrib/completion/zsh/_docker > "$DOTFILES/completions/_docker"
fi

# Docker compose completion
if [ ! -f ../completion/_docker-compose ]; then
  download https://raw.githubusercontent.com/docker/compose/1.28.2/contrib/completion/zsh/_docker-compose > "$DOTFILES/completions/_docker-compose"
fi
