#!/usr/bin/env bash

set -euo pipefail

# Manual installation of Dank Material Shell.

QUICKSHELL="quickshell-git"
DMS_PACKAGES=(
    dms-shell-git
    cava # Audio visualizer
    i2c-tools # External monitor brightness control
    matugen-bin # Dynamic wallpaper-based theming 
    qt6-multimedia # Sound effect support 
    power-profiles-daemon # Set power profile
    adw-gtk-theme # For theming GTK applications

    # For theming Qt applications. Must set `qt6ct` env var accordingly.
    # There's also qt6ct-kde, which might have a better integration with KDE apps.
    # For more information on theming, see https://danklinux.com/docs/dankmaterialshell/application-themes
    qt6ct
    qt5ct
)
# I just want to make sure that latest quickshell is available before installing DMS.
yay -S $QUICKSHELL --needed --noconfirm

# Install selected DMS packages.
yay -S "${DMS_PACKAGES[@]}" --needed --noconfirm

if command -v code; then
  EXT_ID="local.dynamic-base16-dankshell"
  VSIX_FILE="dynamic-base16-dankshell.vsix"

  # Install dynamic theme extension in VS Code.
  #
  # NOTE: We have to reload the window (or maybe just the extensions) when we change colors in DMS.

  if code --list-extensions | grep -qx "$EXT_ID"; then
    echo "dynamic-base16-dankshell extension already installed."
    exit 0
  fi

  echo "Installing dynamic-base16-dankshell extension for VS Code.."
  wget "https://github.com/AvengeMedia/DankMaterialShell/raw/refs/heads/master/quickshell/matugen/$VSIX_FILE";
  code --install-extension $VSIX_FILE
  rm -f $VSIX_FILE
fi
