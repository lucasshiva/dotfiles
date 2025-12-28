#!/usr/bin/env bash

set -e

# Install a minimal plasma desktop
# This assumes we're using DankGreeter + Niri, so we're not installing SDDM.

PACKAGES=(
    # The base desktop. 
    # For a more batteries-included solution, install ` plasma-meta` instead.
    plasma-desktop
    plasma-nm # Network manager applet
    plasma-pa # Audio volume applet
    bluedevil # Bluetooth applet
    kscreen # Screen management
    kscreenlocker
    ffmpegthumbs # Video thumbnails
    kdegraphics-thumbnailers # PDF and PS thumbnails
    qt5ct # Qt5 theming
    qt6ct # Qt6 theming
    kwallet-pam # Enables kwallet on login. Might need to use with SDDM.
    kwalletmanager # Manage secure vaults.
    kde-gtk-config # Manage gtk theming
    cups # Printing support
    print-manager # KDE front-end for printing

    # -- PLASMA META --
    # The following packages are dependencies of plasma-meta.
    # If you use plasma-meta over plasma-desktop, you don't need to install these separately.

    kinfocenter # An utility that providers information about a computer system
    # Breeze theme
    breeze 
    breeze-gtk
    kdeplasma-addons # All kinds of addons
    
    # -- Apps --
    dolphin # File manager
    dolphin-plugins # Plugins for dolphin
    kitty # Terminal emulator
    okular # PDF/Document viewer
    gwenview # Image viewer
    spectacle # Screenshot tool
)

sudo pacman -S --needed --noconfirm "${PACKAGES[@]}"
