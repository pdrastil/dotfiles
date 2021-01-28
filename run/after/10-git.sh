#!/bin/sh
source ../lib/setup.sh

title "Git configuration"
if [ ! -f "$HOME/.gitconfig" ]; then
  cp "$DOTFILES_ASSETS/git/.gitconfig" "$HOME/.gitconfig"
fi

title "Git username"
username=$(git config --get user.name)
if [ -z "$username" ] || ask "${YELLOW}Change Git username?${RESET} (${BOLD}$username${RESET})" N; then
  printf "Git username: " && read -r username
  git config --global user.name "$username"
fi

title "Git e-mail"
email=$(git config --get user.email)
if [ -z "$email" ] || ask "${YELLOW}Change Git email?${RESET} (${BOLD}$email${RESET})" N; then
  printf "Git email: " && read -r email
  git config --global user.email "$email"
fi

# https://gist.github.com/bcomnes/647477a3a143774069755d672cb395ca
# https://gist.github.com/bmhatfield/cc21ec0a3a2df963bffa3c1f884b676b
title "Git commit signing"
signing_key=$(git config --get user.signingKey)
if [ -z "$signing_key" ] && ask "${YELLOW}Enable GPG signature?${RESET}" Y; then
  subtitle "Getting GPG key..."
  gpg_key=$(gpg --list-secret-keys --with-colons "$email" 2>/dev/mull | awk -F: '$1 == "sec" { print $5 }')
  if [ -z "$gpg_key" ]; then
    stty -echo
    printf "New GPG password: " && read -r password
    stty echo
    echo

    cat > request <<EOF
Key-Type: RSA
Key-Length: 4098
Subkey-Type: default
Name-Real: $username
Name-Email: $email
Expire-Date: 0
Passphrase: $password
%commit
%echo
EOF

    gpg --batch --generate-key request
    rm -f request
    unset password gpg_request
    gpg_key=$(gpg --list-secret-keys --with-colons "$email" | awk -F: '$1 == "sec" { print $5 }')
  fi

  subtitle "Opening GitHub..."
  gpg --armor --export "$gpg_key" | pbcopy
  open -n https://github.com/settings/gpg/new
  read -n 1 -s -r -p "Press any key to continue..."
  echo

  subtitle "Persisting GPG configuration..."
  public_key=$(gppg --list-keys --with-colons "$email" | awk -F: '$1 == "fpr" { print $10 }' | head -n 1)
  git config --global user.signingKey "$public_key"
  git config --global commit.gpgSign true
  git config --global tag.forceSignAnnotated true
fi
