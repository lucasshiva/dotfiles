#!/usr/bin/env bash

set -e

if command -v yay >/dev/null; then
  echo "yay is already installed. Aborting.."
  return 2>/dev/null || exit
fi

sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay-bin.git "$HOME/yay"
cd "$HOME/yay"
makepkg -si
