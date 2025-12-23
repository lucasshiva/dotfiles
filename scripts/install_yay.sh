#!/usr/bin/env bash

set -e

if command -v yay >/dev/null; then
  echo "yay is already installed. Aborting.."
  exit 1
fi

sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay-bin.git "$HOME/yay"
cd "$HOME/yay"
makepkg -si
