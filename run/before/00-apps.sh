#!/bin/sh
set -o errexit -o nounset
source ../lib/setup.sh

title "Remove quarantine attribute"
for app in /Applications/*; do
  if xattr "$app"| grep -q com.apple.quarantine; then
    echo "Fixing $app"
    sudo xattr -d com.apple.quarantine "$app"
  fi
done
