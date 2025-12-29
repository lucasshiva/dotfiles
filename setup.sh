#!/usr/bin/env bash

# Helper script to setup my dotfiles.
# This script is supposed to be run on a minimal Arch/CachyOS install.
#
# NOTE: we must move this directory to `$HOME/.config/home-manager`.
# This is configurable, but then we'd need to specify the directory everytime we ran `home-manager switch`.

echo "Installing yay"
source ./scripts/yay.sh

echo "Installing packages: core utils"
# This is just to make sure subsequent steps won't fail due to missing packages like wget.
source ./scripts/install_packages.sh core,utils

echo "Installing and configuring Nix for the user 'lucas'"
source ./scripts/nix.sh

echo "Installing DankMaterialShell"
# DMS before home-manager because I don't want it to overwrite my symlinks for Niri and Kitty.
source ./scripts/dms-shell.sh

echo "Installing DankGreeter"
# This will also install Niri but without the important packages.
source ./scripts/dank_greeter.sh

# 6. Delete DMS generated config for symlinked files.
rm -f $HOME/.config/niri/config.kdl
rm -f $HOME/.config/kitty/kitty.conf

echo "Running home-manager activation"
# By default it uses "$HOME/.config/home-manager".
nix run home-manager -- switch -b backup

echo "Installing all packages"
source ./scripts/install_packages.sh

echo "Installing Niri and recommended packages"
source ./scripts/niri.sh

# 10. OPTIONAL: Install GNOME, KDE, or another DE of your choice.
# Note that the `niri.sh` script makes use of gnome-keyring and the GNOME desktop portal.
# 
# For KDE Plasma
# source ./scripts/plasma.sh

# For GNOME
# TODO: add GNOME script.


echo "Setup completed!"