#!/usr/bin/env bash

set -euo pipefail

# Helper script to setup my dotfiles.
# This script is supposed to be run on a minimal Arch/CachyOS install.
#
# NOTE: we must move this directory to `$HOME/.config/home-manager`.
# This is configurable, but then we'd need to specify the directory everytime we ran `home-manager switch`.

# 1. Install yay
source ./scripts/yay.sh

# 2. Install core and util packages.
# This is just to make sure subsequent steps won't fail due to missing packages like wget.
source ./scripts/install_packages.sh core,utils

# 3. Install and configure Nix
source ./scripts/nix.sh

# 4. Install DMS prior to home-manager.
# I don't want DMS to overwrite my symlinks for Niri and Kitty.
source ./scripts/dms-shell.sh

# 5. Install DankGreeter.
# This will also install Niri but without the important packages.
source ./scripts/dank_greeter.sh

# 6. Delete DMS generated config for symlinked files.
rm -f $HOME/.config/niri/config.kdl
rm -f $HOME/.config/kitty/kitty.conf

# 7. Run home-manager.
# By default it uses "$HOME/.config/home-manager".
nix run home-manager -- switch -b backup

# 8. Install the rest of the packages
source ./scripts/install_packages.sh

# 9. Install Niri and core packages
source ./scripts/niri.sh

# 10. OPTIONAL: Install GNOME, KDE, or another DE of your choice.
# Note that the `niri.sh` script makes use of gnome-keyring and the GNOME desktop portal.
# 
# For KDE Plasma
# source ./scripts/plasma.sh

# For GNOME
# TODO: add GNOME script.