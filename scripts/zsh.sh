#!/usr/bin/env bash

# Set ZSH as default shell.
# All configuration is done via home-manager.

set -e

sudo pacman -S zsh
sudo chsh -s /usr/bin/zsh $USER