#!/bin/sh
set -o errexit -o nounset
source ../lib/setup.sh

if brew list --cask | grep -q parallels; then
  title "Parallels integrations"
  if command -v minikube >/dev/null; then
    subtitle "Minikube"
    minikube config set driver parallels
  fi

  if command -v vagrant >/dev/null; then
    subtitle "Vagrant"
    if ! vagrant plugin list | grep -q vagrant-parallels; then
      vagrant plugin install vagrant-parallels
    fi
  fi
fi
