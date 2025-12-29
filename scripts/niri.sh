#!/usr/bin/env bash

set -euo pipefail

# Helper for installing Niri without running a DE (GNOME or KDE) alongside it.
# This assumes we're using DMS, Noctalia, or some other batteries-included shell.
# If not using one of these shells, then we also need additional packages for things like a notification daemon.
# If that's the case, see https://github.com/YaLTeR/niri/wiki/Getting-Started and https://github.com/YaLTeR/niri/wiki/Important-Software.

PACKAGES=(
    niri
    xwayland-satellite
    xdg-desktop-portal-gnome
    xdg-desktop-portal-gtk
    gnome-keyring
    nautilus
    wl-clipboard
    cliphist
)

yay -S "${PACKAGES[@]}" --needed --noconfirm
