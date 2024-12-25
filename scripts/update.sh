#!/usr/bin/env bash

FLAKE_PATH=/home/craig/Code/nix-infra

cd $FLAKE_PATH

if nix flake check --no-build; then
  sudo nix-collect-garbage --delete-older-than 30d
  sudo nixos-rebuild switch --flake .
  home-manager rebuild switch --flake .
  flatpak update -y
fi
