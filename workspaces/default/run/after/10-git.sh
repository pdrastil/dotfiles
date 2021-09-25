#!/bin/bash
set -o errexit -o nounset
DOTFILES=${DOTFILES:-"$HOME/.dotfiles"}
source "${DOTFILES}/lib/setup.sh"

title "Configuration"
if ! rsync --specials -uir "${DOTFILES}/static/git/" | grep -E '^>'; then
  exit 0
fi

title "Name"
name=$(git config --get user.name || true)
if [ -z "$name" ] || ask "${YELLOW}Change name?${RESET} (${BOLD}$name${RESET})" N; then
  echo -n "New name: " && read -r name
  git config --global user.name "$name"
fi

title "E-mail"
email=$(git config --get user.email || true)
if [ -z "$email" ] || ask "${YELLOW}Change e-mail?${RESET} (${BOLD}$email${RESET})" N; then
  echo -n "New e-mail: " && read -r email
  git config --global user.email "$email"
fi

# https://gist.github.com/bcomnes/647477a3a143774069755d672cb395ca
# https://gist.github.com/bmhatfield/cc21ec0a3a2df963bffa3c1f884b676b
title "Commit signing"
signing_key=$(git config --get user.signingKey || true)
if [ -z "$signing_key" ] && ask "${YELLOW}Enable GPG signature?${RESET}" Y; then
  subtitle "Getting GPG key..."
  gpg_key=$(gpg --list-secret-keys --with-colons "$email" 2>/dev/null | awk -F: '$1 == "sec" { print $5 }')
  if [ -z "$gpg_key" ]; then
    echo -n "New GPG password: " && read -s -r -e password
    echo

    gpg_request=/tmp/gpg_request
    trap 'rm -f "$gpg_request"' EXIT
    cat > "$gpg_request" <<EOF
Key-Type: RSA
Key-Length: 4096
Name-Real: $name
Name-Email: $email
Expire-Date: 0
Passphrase: $password
%commit
EOF

    unset password
    gpg --batch --generate-key "$gpg_request"
    gpg_key=$(gpg --list-secret-keys --with-colons "$email" | awk -F: '$1 == "sec" { print $5 }')
  fi

  subtitle "Opening GitHub..."
  gpg --armor --export "$gpg_key" | pbcopy
  open -n https://github.com/settings/gpg/new
  read -n 1 -s -r -p "Press any key to continue..."
  echo

  subtitle "Persisting GPG configuration..."
  public_key=$(gpg --list-keys --with-colons "$email" | awk -F: '$1 == "fpr" { print $10 }' | head -n 1)
  git config --global user.signingKey "$public_key"
  git config --global commit.gpgSign true
  git config --global tag.forceSignAnnotated true
fi
