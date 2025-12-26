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
    qt6ct # Qt6 application theming
    adw-gtk-theme # For theming GTK applications

    # For theming Qt applications. Must set `qt6ct` env var accordingly.
    # There's also qt6ct-kde, which might have a better integration with KDE apps.
    # For more information on theming, see https://danklinux.com/docs/dankmaterialshell/application-themes
    qt6ct
)
# I just want to make sure that latest quickshell is available before installing DMS.
yay -S $QUICKSHELL --needed --noconfirm

# Install selected DMS packages.
yay -S "${DMS_PACKAGES[@]}" --needed --noconfirm
