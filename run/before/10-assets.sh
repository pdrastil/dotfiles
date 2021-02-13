#!/bin/sh
set -o errexit -o nounset
source ../lib/setup.sh

title "Shell completions"
while read -r url; do
  filename=$(basename "$url")
  subtitle "Downloading '$filename'..."
  download "$url" > "$DOTFILES_ASSETS/zsh/$filename"
done <<-EOF
  https://raw.githubusercontent.com/docker/cli/master/contrib/completion/zsh/_docker
  https://raw.githubusercontent.com/docker/compose/master/contrib/completion/zsh/_docker-compose
EOF

title "Fonts"
cp "$DOTFILES_ASSETS"/fonts/*.ttf "$HOME"/Library/Fonts/
